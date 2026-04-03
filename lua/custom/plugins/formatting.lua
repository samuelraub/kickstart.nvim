return {
  'stevearc/conform.nvim',
  event = { 'BufWritePre' },
  cmd = { 'ConformInfo' },
  keys = {
    {
      '<leader>bf',
      function()
        require('conform').format { async = true, lsp_format = 'fallback' }
      end,
      mode = '',
      desc = '[F]ormat buffer',
    },
  },
  opts = {
    notify_on_error = true,
    format_on_save = function(bufnr)
      if vim.g.disable_autoformat or vim.b[bufnr].disable_autoformat then
        return nil
      end

      local disable_filetypes = { c = true, cpp = true }
      if disable_filetypes[vim.bo[bufnr].filetype] then
        return nil
      else
        return {
          timeout_ms = 2000,
          lsp_format = 'fallback',
        }
      end
    end,
    formatters_by_ft = {
      lua = { 'stylua' },
      astro = { 'prettierd', 'prettier' },
      css = { 'biome' },
      graphql = { 'biome' },
      javascript = { 'biome' },
      javascriptreact = { 'biome' },
      json = { 'biome' },
      jsonc = { 'biome' },
      typescript = { 'biome' },
      typescriptreact = { 'biome' },
      handlebars = { 'prettierd', 'prettier' },
      html = { 'prettierd', 'prettier' },
      less = { 'prettierd', 'prettier' },
      markdown = { 'prettierd', 'prettier' },
      mdx = { 'prettierd', 'prettier' },
      scss = { 'prettierd', 'prettier' },
      vue = { 'prettierd', 'prettier' },
      yaml = { 'prettierd', 'prettier' },
    },
  },
}
