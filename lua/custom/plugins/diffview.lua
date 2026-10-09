local function git(...)
  local res = vim.system({ 'git', ... }, { text = true }):wait()
  return res.code == 0 and vim.trim(res.stdout) or nil
end

local function ref_exists(ref)
  return git('rev-parse', '--verify', '--quiet', ref .. '^{commit}') ~= nil
end

-- Branches are often stacked, so the base is: pinned `branch.<name>.base`,
-- then the open MR's target branch, then the default branch
local function resolve_base(callback)
  local branch = git('branch', '--show-current')
  if not branch or branch == '' then
    return callback(nil)
  end

  local pinned = git('config', 'branch.' .. branch .. '.base')
  if pinned and pinned ~= '' then
    return callback(pinned)
  end

  local function default_branch()
    callback(git('symbolic-ref', '--short', 'refs/remotes/origin/HEAD') or 'main')
  end

  if vim.fn.executable 'glab' == 0 then
    return default_branch()
  end

  vim.system(
    { 'glab', 'mr', 'list', '--source-branch', branch, '--output', 'json' },
    { text = true, timeout = 5000 },
    vim.schedule_wrap(function(res)
      local ok, mrs = pcall(vim.json.decode, res.stdout or '')
      local target = res.code == 0 and ok and type(mrs) == 'table' and mrs[1] and mrs[1].target_branch
      if not target then
        return default_branch()
      end
      callback(ref_exists(target) and target or 'origin/' .. target)
    end)
  )
end

local function review_branch(with_worktree)
  return function()
    resolve_base(function(base)
      if not base or not ref_exists(base) then
        vim.notify('Could not resolve a base branch' .. (base and (': ' .. base) or ''), vim.log.levels.WARN)
        return
      end
      if not with_worktree then
        vim.notify('Reviewing against ' .. base)
        return vim.cmd.DiffviewOpen(base .. '...HEAD')
      end
      -- A single rev diffs against the working tree; use the fork point, not the base's tip
      local merge_base = git('merge-base', base, 'HEAD')
      if not merge_base then
        vim.notify('No merge base with ' .. base, vim.log.levels.WARN)
        return
      end
      vim.notify('Reviewing against ' .. base .. ', including uncommitted changes')
      -- Diffview lists untracked files only for index vs. working tree
      local untracked = git('ls-files', '--others', '--exclude-standard', '--full-name', ':/')
      if untracked and untracked ~= '' then
        vim.notify('Untracked files are not shown:\n' .. untracked, vim.log.levels.WARN)
      end
      vim.cmd.DiffviewOpen(merge_base)
    end)
  end
end

return {
  'dlyongemallo/diffview-plus.nvim',
  cmd = { 'DiffviewOpen', 'DiffviewClose', 'DiffviewFileHistory' },
  keys = {
    { '<leader>gd', review_branch(), desc = '[G]it [D]iff branch against its base' },
    { '<leader>gD', review_branch(true), desc = '[G]it [D]iff branch and working tree against its base' },
    { '<leader>gw', '<cmd>DiffviewOpen<cr>', desc = '[G]it diff [W]orking tree' },
    { '<leader>gq', '<cmd>DiffviewClose<cr>', desc = '[G]it diff [Q]uit' },
  },
  opts = {},
}
