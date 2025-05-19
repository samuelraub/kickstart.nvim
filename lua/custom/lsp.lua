vim.lsp.enable 'ruby_lsp'
vim.lsp.config('ruby_lsp', {
  cmd = { vim.fn.expand '~/.rbenv/shims/ruby-lsp' },
})

vim.lsp.enable 'vtsls'
vim.lsp.config('vtsls', {
  cmd = { 'vtsls', '--stdio' },
  settings = {
    javascript = {
      preferences = {
        importModuleSpecifier = 'non-relative',
      },
    },
    typescript = {
      preferences = {
        importModuleSpecifier = 'non-relative',
      },
    },
  },
})

vim.lsp.enable 'jsonls'

vim.lsp.enable 'yamlls'

vim.lsp.enable 'dockerls'

vim.lsp.enable 'docker_compose_language_service'

vim.lsp.enable 'tailwindcss'

vim.lsp.enable 'biome'

vim.lsp.enable 'marksman'

return {
  'yioneko/nvim-vtsls',
}

-- pnpm add -g vscode-langservers-extracted yaml-language-server @vtsls/language-server @microsoft/compose-language-service dockerfile-language-server-nodejs @tailwindcss/language-server @biomejs/biome
-- brew install marksman
