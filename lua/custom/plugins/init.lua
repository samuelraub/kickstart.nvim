-- You can add your own plugins here or in other files in this directory!
--  I promise not to create any merge conflicts in this directory :)
--
-- See the kickstart.nvim README for more information

-- Past the last split, move like tmux's C-arrow bindings do: next pane, or
-- AeroSpace at the outer pane. TmuxNavigate* would wrap inside tmux instead.
local function navigate(wincmd, tmux_dir, edge, aerospace_dir)
  local win = vim.api.nvim_get_current_win()
  vim.cmd('wincmd ' .. wincmd)
  if vim.api.nvim_get_current_win() ~= win or not vim.env.TMUX then
    return
  end
  local select = 'select-pane -' .. tmux_dir
  vim.system {
    'tmux',
    'if-shell',
    '-F',
    '#{pane_at_' .. edge .. '}',
    'run-shell -b "aerospace focus --boundaries all-monitors-outer-frame ' .. aerospace_dir .. ' 2>/dev/null || tmux ' .. select .. '"',
    select,
  }
end

return {
  {
    'christoomey/vim-tmux-navigator',
    cmd = {
      'TmuxNavigateLeft',
      'TmuxNavigateDown',
      'TmuxNavigateUp',
      'TmuxNavigateRight',
      'TmuxNavigatePrevious',
      'TmuxNavigatorProcessList',
    },
    keys = {
      { '<c-left>', function() navigate('h', 'L', 'left', 'left') end },
      { '<c-down>', function() navigate('j', 'D', 'bottom', 'down') end },
      { '<c-up>', function() navigate('k', 'U', 'top', 'up') end },
      { '<c-right>', function() navigate('l', 'R', 'right', 'right') end },
    },
  },
  {
    'folke/snacks.nvim',
    priority = 1000,
    lazy = false,
    ---@type snacks.Config
    opts = {
      -- your configuration comes here
      -- or leave it empty to use the default settings
      -- refer to the configuration section below
      bigfile = {},
      bufdelete = {},
      indent = {},
      lazygit = {},
      scratch = {},
      scroll = {},
      toggle = {},
    },
    init = function()
      vim.api.nvim_create_autocmd('User', {
        pattern = 'VeryLazy',
        callback = function()
          -- Setup some globals for debugging (lazy-loaded)
          _G.dd = function(...)
            Snacks.debug.inspect(...)
          end
          _G.bt = function()
            Snacks.debug.backtrace()
          end
          vim.print = _G.dd -- Override print to use snacks for `:=` command

          -- Create some toggle mappings
          Snacks.toggle.diagnostics():map '<leader>ud'
        end,
      })
    end,
  },
  {
    'nmac427/guess-indent.nvim',
    opts = {},
  },
  {
    'MagicDuck/grug-far.nvim',
    lazy = true,
    opts = {
      showCompactInputs = true,
    },
  },
  {
    'windwp/nvim-ts-autotag',
    opts = {},
  },
  { 'MeanderingProgrammer/render-markdown.nvim', lazy = true, opts = {} },
  {
    'tadmccorkle/markdown.nvim',
    ft = 'markdown', -- or 'event = "VeryLazy"'
    opts = {
      -- configuration here or empty for defaults
    },
  },
  { 'RRethy/nvim-treesitter-endwise' },
  {
    dir = '~/dev/trackit.nvim',
    opts = {},
  },
}
