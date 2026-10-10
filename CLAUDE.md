# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## Overview

This is a Neovim configuration based on [kickstart.nvim](https://github.com/nvim-kickstart/kickstart.nvim). It uses **lazy.nvim** as the plugin manager and is written entirely in Lua.

Developed against Neovim 0.12.5 (Homebrew). Update this line when upgrading.

## Architecture

- **`init.lua`** -- Main entry point. Contains vim options, autocommands, the `lazy.nvim` bootstrap and the inline specs for gitsigns, which-key, the colorscheme, mini.nvim and treesitter. Everything else is imported from `lua/custom/plugins/`.
- **`lua/custom/`** -- User customizations that won't conflict with upstream kickstart:
  - `mappings.lua` -- All custom keymaps (returned as an empty table to satisfy lazy.nvim import)
  - `plugins/lspconfig.lua` -- Native `vim.lsp.enable`/`vim.lsp.config` setup for non-Mason LSP servers (ruby_lsp, vtsls, jsonls, yamlls, dockerls, tailwindcss, biome, marksman, gopls), plus the nvim-lspconfig/Mason spec, LSP keymaps and diagnostics
  - `plugins/` -- Further plugin specs: `init.lua` (tmux-navigator, snacks.nvim, grug-far, telekasten, local dev plugin), `completion.lua`, `diffview.lua` (branch review against the resolved base: `<leader>gd`, `<leader>gD` including the working tree, `<leader>gw` working tree only), `formatting.lua`, `telescope.lua`
  - `snippets/` -- Custom LuaSnip snippets (Lua loader format)
- **`lua/kickstart/plugins/`** -- Optional kickstart modules. Only `autopairs` is currently enabled in init.lua.
- **`after/ftplugin/`** -- Filetype-specific settings (telekasten)
- **`telekasten` parser** -- Custom Tree-sitter grammar at `~/dev/tree-sitter-telekasten`, registered with nvim-treesitter as a local `path` parser in `init.lua`; its queries live in the grammar repo. After `tree-sitter generate`, `:TSUpdate telekasten` recompiles the parser and re-links the queries (`:TSInstall` is a no-op once installed). If the `site/queries/telekasten` link is missing, `:TSUpdate` reports up to date; repair with `:TSInstall! telekasten`

## Key Conventions

- **Formatting**: stylua for Lua (2-space indent, spaces not tabs). JS/TS use biome; markdown/yaml/html use prettierd/prettier. Format-on-save is enabled via conform.nvim (toggle with `<leader>uf`).
- **LSP strategy**: Mason manages lua_ls and installer tools. Other LSP servers are configured natively at the top of `lua/custom/plugins/lspconfig.lua` and come from mise, not Mason (see the comment at the top of that file).
- **Leader key**: Space. Keymaps use `[D]escription` bracket notation for which-key display.
- **Local plugins**: `trackit.nvim` is loaded from `~/dev/` via `dir` field. It owns the daily zettelkasten file: `<leader>zd` opens/creates today's note, `<leader>at`/`<leader>an` add a todo/note, `<leader>oci`/`<leader>oco`/`<leader>ocs` clock in/out and sync to Redmine, all from any buffer.
- **Colorscheme**: rose-pine

## Lua Style

- 2 spaces indentation
- Single quotes for strings (stylua enforced)
- Plugin configs use `opts = {}` pattern where possible; `config = function()` only when needed
