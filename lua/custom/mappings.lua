local map = vim.keymap.set

map('n', '<leader>ee', '<cmd>echo "foobar"<cr>')

-- Clear highlights on search when pressing <Esc> in normal mode
--  See `:help hlsearch`
map('n', '<Esc>', '<cmd>nohlsearch<CR>')

-- Diagnostic keymaps
map('n', '<leader>q', vim.diagnostic.setloclist, { desc = 'Open diagnostic [Q]uickfix list' })

-- Keybinds to make split navigation easier.
--  Use CTRL+<hjkl> to switch between windows
--
--  See `:help wincmd` for a list of all window commands
map('n', '<C-left>', '<C-w><C-h>', { desc = 'Move focus to the left window' })
map('n', '<C-right>', '<C-w><C-l>', { desc = 'Move focus to the right window' })
map('n', '<C-down>', '<C-w><C-j>', { desc = 'Move focus to the lower window' })
map('n', '<C-up>', '<C-w><C-k>', { desc = 'Move focus to the upper window' })

map('n', '<S-left>', '<cmd>bprev<cr>', { desc = 'Move focus to the left' })
map('n', '<S-right>', '<cmd>bnext<cr>', { desc = 'Move focus to the right' })

map('n', '<leader>w', '<cmd>update<cr>', { desc = 'Save current buffer' })

map('n', '<leader>qq', '<cmd>qa<cr>', { desc = 'Quit' })

map('n', '<leader>fm', function()
  require('mini.files').open(vim.api.nvim_buf_get_name(0))
end, { desc = 'Open MiniFiles here' })

map('n', '<leader>fM', function()
  require('mini.files').open()
end, { desc = 'Open MiniFiles in CWD' })

map('n', '<leader>bq', function()
  require('snacks').bufdelete()
end, { desc = '[Q]uit current [B]uffer' })

map('n', '<leader>bqo', function()
  require('snacks').bufdelete.other()
end, { desc = '[Q]uit [O]ther [B]uffers' })

map('n', '<leader>bqw', '<cmd>bd<cr>', { desc = '[Q]uit [B]uffer and [W]indow' })

map('n', '<leader>gg', function()
  require('snacks').lazygit()
end, { desc = 'Open Lazygit' })

return {}
