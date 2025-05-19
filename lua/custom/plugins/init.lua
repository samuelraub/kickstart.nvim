-- You can add your own plugins here or in other files in this directory!
--  I promise not to create any merge conflicts in this directory :)
--
-- See the kickstart.nvim README for more information
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
      { '<c-left>', '<cmd>TmuxNavigateLeft<cr>' },
      { '<c-down>', '<cmd>TmuxNavigateDown<cr>' },
      { '<c-up>', '<cmd>TmuxNavigateUp<cr>' },
      { '<c-right>', '<cmd>TmuxNavigateRight<cr>' },
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
      bigfile = { enabled = true },
      bufdelete = { enabled = true },
      indent = { enabled = true },
      lazygit = { enabled = true },
      scratch = { enabled = true },
      scroll = { enabled = true },
    },
  },
  {
    'nmac427/guess-indent.nvim',
    opts = {},
  },
  {
    'MagicDuck/grug-far.nvim',
    opts = {},
  },
  {
    'windwp/nvim-ts-autotag',
    opts = {},
  },
  { 'MeanderingProgrammer/render-markdown.nvim', opts = {} },
  {
    'tadmccorkle/markdown.nvim',
    ft = 'markdown', -- or 'event = "VeryLazy"'
    opts = {
      -- configuration here or empty for defaults
    },
  },
  {
    'renerocksai/telekasten.nvim',
    dependencies = { 'nvim-telescope/telescope.nvim' },
    config = function()
      require('telekasten').setup {
        home = vim.fn.expand '~/zettelkasten',
      }
    end,
  },
}
