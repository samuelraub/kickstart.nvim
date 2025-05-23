local map = vim.keymap.set

-- Clear highlights on search when pressing <Esc> in normal mode
--  See `:help hlsearch`
map('n', '<Esc>', '<cmd>nohlsearch<CR>')

-- Diagnostic keymaps
map('n', '<leader>q', vim.diagnostic.setloclist, { desc = 'Open diagnostic [Q]uickfix list' })

-- Keybinds to make split and tab navigation easier.
--  See `:help wincmd` for a list of all window commands
map('n', '<C-left>', '<C-w><C-h>', { desc = 'Move focus to the left window' })
map('n', '<C-right>', '<C-w><C-l>', { desc = 'Move focus to the right window' })
map('n', '<C-down>', '<C-w><C-j>', { desc = 'Move focus to the lower window' })
map('n', '<C-up>', '<C-w><C-k>', { desc = 'Move focus to the upper window' })

map('n', '<S-left>', '<cmd>bprev<cr>', { desc = 'Move focus to the left' })
map('n', '<S-right>', '<cmd>bnext<cr>', { desc = 'Move focus to the right' })

-- Save current buffer
map('n', '<leader>w', '<cmd>update<cr>', { desc = 'Save current buffer' })

-- Quit current window
map('n', '<leader>q', '<cmd>q<cr>', { desc = 'Quit current window' })

-- Quit Neovim
map('n', '<leader>qq', '<cmd>qa<cr>', { desc = 'Quit' })

-- MiniFiles
map('n', '<leader>fm', function()
  require('mini.files').open(vim.api.nvim_buf_get_name(0))
end, { desc = 'Open MiniFiles here' })

map('n', '<leader>fM', function()
  require('mini.files').open()
end, { desc = 'Open MiniFiles in CWD' })

-- Delete buffers and windows
map('n', '<leader>bq', function()
  require('snacks').bufdelete()
end, { desc = '[Q]uit current [B]uffer' })

map('n', '<leader>bqo', function()
  require('snacks').bufdelete.other()
end, { desc = '[Q]uit [O]ther [B]uffers' })

map('n', '<leader>bqw', '<cmd>bd<cr>', { desc = '[Q]uit [B]uffer and [W]indow' })

-- Lazygit
map('n', '<leader>gg', function()
  require('snacks').lazygit()
end, { desc = 'Open Lazygit' })

---
--SUBSTITUTE--
---

vim.keymap.set('n', '<leader>su', ':%s/<c-r><c-w>//gc<left><left><left>', { desc = 'Substitute' })
vim.keymap.set('v', '<leader>su', function()
  local esc = vim.api.nvim_replace_termcodes('<esc>', true, false, true)
  vim.api.nvim_feedkeys(esc, 'x', false)

  local _, ls, cs = unpack(vim.fn.getpos "'<") -- start of selection
  local _, le, ce = unpack(vim.fn.getpos "'>") -- end of selection
  local lines = vim.api.nvim_buf_get_lines(0, ls - 1, le, false)

  local selection
  if #lines == 1 then
    selection = string.sub(lines[1], cs, ce)
  else
    selection = lines[1]:sub(cs) .. '\n' .. table.concat(lines, '\n', 2, #lines - 1) .. '\n' .. lines[#lines]:sub(1, ce)
  end

  selection = vim.fn.escape(selection, '/\\')

  vim.api.nvim_feedkeys(':%s/' .. selection .. '//gc', 'n', false)

  local move_cursor = vim.api.nvim_replace_termcodes('<left><left><left>', true, false, true)
  vim.api.nvim_feedkeys(move_cursor, 'n', false)
end, { desc = 'Search and replace with visual selection', silent = true })

---
--RELOAD BROWSER TAB--
---

vim.keymap.set('n', '<leader>rr', function()
  os.execute [[
    osascript -e 'tell application "Firefox" to activate'
    sleep 0.2
    osascript -e 'tell application "System Events" to keystroke "r" using command down'
  ]]
  print 'Reloaded Firefox tab'
end, { noremap = true, silent = true })

---
--SEARCH AND REPLACE--
---

vim.keymap.set('n', '<leader>srb', function()
  require('grug-far').open { prefills = { paths = vim.fn.expand '%' } }
end, { desc = '[S]earch and [R]eplace in buffer' })

vim.keymap.set('n', '<leader>sra', function()
  require('grug-far').open()
end, { desc = '[S]earch and [R]eplace in CWD' })

---
--TELEKASTEN--
---

-- Most used functions
vim.keymap.set('n', '<leader>z', '<cmd>Telekasten panel<CR>')
vim.keymap.set('n', '<leader>zf', '<cmd>Telekasten find_notes<CR>')
vim.keymap.set('n', '<leader>zg', '<cmd>Telekasten search_notes<CR>')
vim.keymap.set('n', '<leader>zd', '<cmd>Telekasten goto_today<CR>')
vim.keymap.set('n', '<leader>zz', '<cmd>Telekasten follow_link<CR>')
vim.keymap.set('n', '<leader>zn', '<cmd>Telekasten new_note<CR>')
vim.keymap.set('n', '<leader>zc', '<cmd>Telekasten show_calendar<CR>')
vim.keymap.set('n', '<leader>zb', '<cmd>Telekasten show_backlinks<CR>')
vim.keymap.set('n', '<leader>zI', '<cmd>Telekasten insert_img_link<CR>')

---
--UI RELATED
---

vim.keymap.set('n', '<leader>ub', function()
  if vim.o.background == 'dark' then
    vim.o.background = 'light'
  else
    vim.o.background = 'dark'
  end
end, { desc = 'Toggle [U]I [B]ackground' })

---
--TOGGLE AUTOFORMAT
---

vim.keymap.set('n', '<leader>uf', function()
  if vim.g.disable_autoformat then
    vim.g.disable_autoformat = false
    vim.notify 'Autoformat enabled'
  else
    vim.g.disable_autoformat = true
    vim.notify 'Autoformat disabled'
  end
end, { desc = 'Toggle Auto [F]ormat on save' })

--QUICKADD
---
vim.keymap.set('n', '<leader>at', '<cmd>Quickadd t<cr>', { desc = 'Quickadd [T]odo' })
vim.keymap.set('n', '<leader>an', '<cmd>Quickadd n<cr>', { desc = 'Quickadd [N]odo' })

return {} ---
