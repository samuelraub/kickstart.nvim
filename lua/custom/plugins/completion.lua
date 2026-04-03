return {
  'saghen/blink.cmp',
  event = 'VimEnter',
  version = '1.*',
  dependencies = {
    {
      'L3MON4D3/LuaSnip',
      version = '2.*',
      build = (function()
        if vim.fn.has 'win32' == 1 or vim.fn.executable 'make' == 0 then
          return
        end
        return 'make install_jsregexp'
      end)(),
      dependencies = {
        {
          'rafamadriz/friendly-snippets',
          config = function()
            require('luasnip.loaders.from_vscode').lazy_load()
            require('luasnip').filetype_extend('ruby', { 'rails' })
            require('luasnip.loaders.from_lua').load { paths = { './lua/custom/snippets' } }
          end,
        },
      },
      opts = {},
    },
    'folke/lazydev.nvim',
  },
  --- @module 'blink.cmp'
  --- @type blink.cmp.Config
  opts = {
    keymap = {
      preset = 'default',
    },

    appearance = {
      nerd_font_variant = 'mono',
    },

    completion = {
      documentation = { auto_show = true, auto_show_delay_ms = 500 },
    },

    sources = {
      default = { 'snippets', 'lsp', 'path', 'buffer', 'lazydev' },
      providers = {
        lazydev = { module = 'lazydev.integrations.blink', score_offset = 100 },
      },
    },

    snippets = { preset = 'luasnip' },

    fuzzy = {
      sorts = {
        function(a, b)
          local source_priority = {
            snippets = 5,
            lsp = 4,
            path = 3,
            buffer = 2,
            lazydev = 1,
          }
          local a_priority = source_priority[a.source_id]
          local b_priority = source_priority[b.source_id]
          if a_priority ~= b_priority then
            return a_priority > b_priority
          end
        end,
        'score',
        'sort_text',
      },
      implementation = 'lua',
    },

    signature = { enabled = true },
  },
}
