-- Set <space> as the leader key
-- See `:help mapleader`

vim.g.mapleader = ' '
vim.g.maplocalleader = ' '

-- Set to true if you have a Nerd Font installed and selected in the terminal
vim.g.have_nerd_font = true

-- [[ Setting options ]]
-- See `:help vim.o`

vim.o.number = true
vim.o.relativenumber = true
vim.o.mouse = 'a'
vim.o.showmode = false

-- Make `_` act as delimiter for word textobject
vim.opt.iskeyword:remove { '_' }

vim.schedule(function()
  vim.o.clipboard = 'unnamedplus'
end)

vim.o.breakindent = true
vim.o.undofile = true

-- Case-insensitive searching UNLESS \C or one or more capital letters in the search term
vim.o.ignorecase = true
vim.o.smartcase = true

vim.o.signcolumn = 'yes'
vim.o.updatetime = 250
vim.o.timeoutlen = 300

vim.o.splitright = true
vim.o.splitbelow = true

-- Treesitter folding
vim.o.foldmethod = 'expr'
vim.o.foldexpr = 'v:lua.vim.treesitter.foldexpr()'
vim.o.foldenable = false
vim.o.foldlevel = 20

vim.o.list = true
vim.opt.listchars = { tab = '» ', trail = '·', nbsp = '␣' }

vim.o.inccommand = 'split'
vim.o.cursorline = true
vim.o.scrolloff = 10
vim.o.confirm = true
vim.o.pumborder = 'rounded'
vim.o.exrc = true

-- [[ Basic Autocommands ]]

vim.api.nvim_create_autocmd('TextYankPost', {
  desc = 'Highlight when yanking (copying) text',
  group = vim.api.nvim_create_augroup('kickstart-highlight-yank', { clear = true }),
  callback = function()
    vim.hl.on_yank()
  end,
})

-- [[ Install `lazy.nvim` plugin manager ]]
local lazypath = vim.fn.stdpath 'data' .. '/lazy/lazy.nvim'
if not (vim.uv or vim.loop).fs_stat(lazypath) then
  local lazyrepo = 'https://github.com/folke/lazy.nvim.git'
  local out = vim.fn.system { 'git', 'clone', '--filter=blob:none', '--branch=stable', lazyrepo, lazypath }
  if vim.v.shell_error ~= 0 then
    error('Error cloning lazy.nvim:\n' .. out)
  end
end

---@type vim.Option
local rtp = vim.opt.rtp
rtp:prepend(lazypath)

-- [[ Configure and install plugins ]]
require('lazy').setup({
  {
    'lewis6991/gitsigns.nvim',
    opts = {
      signs = {
        add = { text = '+' },
        change = { text = '~' },
        delete = { text = '_' },
        topdelete = { text = '‾' },
        changedelete = { text = '~' },
      },
      on_attach = function(bufnr)
        local gitsigns = require 'gitsigns'
        local function map(mode, lhs, rhs, desc)
          vim.keymap.set(mode, lhs, rhs, { buffer = bufnr, desc = desc })
        end

        map('n', ']c', function()
          if vim.wo.diff then
            vim.cmd.normal { ']c', bang = true }
          else
            gitsigns.nav_hunk 'next'
          end
        end, 'Jump to next git [c]hange')
        map('n', '[c', function()
          if vim.wo.diff then
            vim.cmd.normal { '[c', bang = true }
          else
            gitsigns.nav_hunk 'prev'
          end
        end, 'Jump to previous git [c]hange')

        map('v', '<leader>hs', function()
          gitsigns.stage_hunk { vim.fn.line '.', vim.fn.line 'v' }
        end, 'git [s]tage hunk')
        map('v', '<leader>hr', function()
          gitsigns.reset_hunk { vim.fn.line '.', vim.fn.line 'v' }
        end, 'git [r]eset hunk')
        map('n', '<leader>hs', gitsigns.stage_hunk, 'git [s]tage hunk')
        map('n', '<leader>hr', gitsigns.reset_hunk, 'git [r]eset hunk')
        map('n', '<leader>hS', gitsigns.stage_buffer, 'git [S]tage buffer')
        map('n', '<leader>hR', gitsigns.reset_buffer, 'git [R]eset buffer')
        map('n', '<leader>hp', gitsigns.preview_hunk, 'git [p]review hunk')
        map('n', '<leader>hi', gitsigns.preview_hunk_inline, 'git preview hunk [i]nline')
        map('n', '<leader>hb', function()
          gitsigns.blame_line { full = true }
        end, 'git [b]lame line')
        map('n', '<leader>hd', gitsigns.diffthis, 'git [d]iff against index')
        map('n', '<leader>hD', function()
          gitsigns.diffthis '~'
        end, 'git [D]iff against last commit')
        map('n', '<leader>hQ', function()
          gitsigns.setqflist 'all'
        end, 'git hunk [Q]uickfix list (all files in repo)')
        map('n', '<leader>hq', gitsigns.setqflist, 'git hunk [q]uickfix list (this file)')
        map('n', '<leader>tb', gitsigns.toggle_current_line_blame, '[T]oggle git show [b]lame line')
        map('n', '<leader>tw', gitsigns.toggle_word_diff, '[T]oggle git intra-line [w]ord diff')
        map({ 'o', 'x' }, 'ih', gitsigns.select_hunk, 'text object [i]nside [h]unk')
      end,
    },
  },

  {
    'folke/which-key.nvim',
    event = 'VimEnter',
    opts = {
      delay = 0,
      icons = {
        mappings = vim.g.have_nerd_font,
        keys = vim.g.have_nerd_font and {} or {
          Up = '<Up> ',
          Down = '<Down> ',
          Left = '<Left> ',
          Right = '<Right> ',
          C = '<C-…> ',
          M = '<M-…> ',
          D = '<D-…> ',
          S = '<S-…> ',
          CR = '<CR> ',
          Esc = '<Esc> ',
          ScrollWheelDown = '<ScrollWheelDown> ',
          ScrollWheelUp = '<ScrollWheelUp> ',
          NL = '<NL> ',
          BS = '<BS> ',
          Space = '<Space> ',
          Tab = '<Tab> ',
          F1 = '<F1>',
          F2 = '<F2>',
          F3 = '<F3>',
          F4 = '<F4>',
          F5 = '<F5>',
          F6 = '<F6>',
          F7 = '<F7>',
          F8 = '<F8>',
          F9 = '<F9>',
          F10 = '<F10>',
          F11 = '<F11>',
          F12 = '<F12>',
        },
      },
      spec = {
        { '<leader>s', group = '[S]earch' },
        { '<leader>t', group = '[T]oggle' },
        { '<leader>h', group = 'Git [H]unk', mode = { 'n', 'v' } },
        { '<leader>b', group = '[B]uffers' },
        { '<leader>f', group = '[F]iles' },
        { '<leader>g', group = '[G]it' },
        { '<leader>sr', group = '[S]earch and [R]eplace' },
        { '<leader>u', group = '[U]I related' },
        { '<leader>a', group = 'Quick[Add]' },
        { '<leader>o', group = '[O]rg' },
        { 'gr', group = 'LSP' },
        { '<leader>oc', group = '[O]rg [C]lock' },
        { '<leader>ot', group = '[O]rg [T]odo' },
      },
    },
  },

  {
    'rose-pine/neovim',
    priority = 1000,
    name = 'rose-pine',
    config = function()
      vim.cmd 'colorscheme rose-pine'
    end,
  },

  {
    'folke/todo-comments.nvim',
    event = 'VimEnter',
    dependencies = { 'nvim-lua/plenary.nvim' },
    opts = { signs = false },
  },

  {
    'nvim-mini/mini.nvim',
    version = false,
    config = function()
      require('mini.ai').setup {
        n_lines = 500,
        custom_textobjects = {
          g = function()
            local from = { line = 1, col = 1 }
            local to = {
              line = vim.fn.line '$',
              col = math.max(vim.fn.getline('$'):len(), 1),
            }
            return { from = from, to = to }
          end,
        },
      }

      require('mini.surround').setup()

      local statusline = require 'mini.statusline'
      statusline.setup { use_icons = vim.g.have_nerd_font }
      ---@diagnostic disable-next-line: duplicate-set-field
      statusline.section_location = function()
        return '%2l:%-2v'
      end

      require('mini.tabline').setup()
      require('mini.jump').setup()
      require('mini.bufremove').setup()

      require('mini.operators').setup {
        replace = {
          prefix = 'rr',
          reindent_linewise = true,
        },
      }

      require('mini.files').setup {
        mappings = {
          go_in = '<right>',
          go_out = '<left>',
        },
      }
    end,
  },

  {
    'nvim-treesitter/nvim-treesitter',
    branch = 'main',
    lazy = false,
    build = ':TSUpdate',
    config = function()
      local languages = {
        'bash',
        'c',
        'diff',
        'dockerfile',
        'go',
        'html',
        'javascript',
        'json5',
        'lua',
        'luadoc',
        'markdown',
        'markdown_inline',
        'python',
        'query',
        'ruby',
        'typescript',
        'vim',
        'vimdoc',
        'yaml',
        'toml',
      }

      -- Local grammar: `:TSUpdate telekasten` recompiles src/parser.c and links
      -- the queries; run `tree-sitter generate` first after a grammar.js change
      local telekasten = '~/dev/tree-sitter-telekasten'
      vim.api.nvim_create_autocmd('User', {
        pattern = 'TSUpdate',
        callback = function()
          require('nvim-treesitter.parsers').telekasten = {
            install_info = { path = telekasten, queries = 'queries' },
          }
        end,
      })
      if vim.uv.fs_stat(vim.fs.normalize(telekasten)) then
        table.insert(languages, 'telekasten')
      end

      require('nvim-treesitter').install(languages)

      vim.api.nvim_create_autocmd('FileType', {
        callback = function(ev)
          local ok = pcall(vim.treesitter.start, ev.buf)
          if not ok then
            return
          end
          local ft = vim.bo[ev.buf].filetype
          if ft == 'ruby' then
            vim.bo[ev.buf].syntax = 'ON'
          else
            vim.bo[ev.buf].indentexpr = "v:lua.require'nvim-treesitter'.indentexpr()"
          end
        end,
      })
    end,
  },

  require 'kickstart.plugins.autopairs',
  require 'custom.mappings',

  { import = 'custom.plugins' },
}, {
  ui = {
    icons = vim.g.have_nerd_font and {} or {
      cmd = '⌘',
      config = '🛠',
      event = '📅',
      ft = '📂',
      init = '⚙',
      keys = '🗝',
      plugin = '🔌',
      runtime = '💻',
      require = '🌙',
      source = '📄',
      start = '🚀',
      task = '📌',
      lazy = '💤 ',
    },
  },
})

-- vim: ts=2 sts=2 sw=2 et
