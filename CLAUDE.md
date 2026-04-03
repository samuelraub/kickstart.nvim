# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## Overview

This is a Neovim configuration based on [kickstart.nvim](https://github.com/nvim-kickstart/kickstart.nvim). It uses **lazy.nvim** as the plugin manager and is written entirely in Lua.

## Architecture

- **`init.lua`** -- Main entry point. Contains vim options, autocommands, and the full `lazy.nvim` plugin spec (inline, not split into separate files). Core plugins (telescope, lspconfig, conform, blink.cmp, treesitter, mini.nvim) are configured here.
- **`lua/custom/`** -- User customizations that won't conflict with upstream kickstart:
  - `mappings.lua` -- All custom keymaps (returned as an empty table to satisfy lazy.nvim import)
  - `lsp.lua` -- Native `vim.lsp.enable`/`vim.lsp.config` setup for non-Mason LSP servers (ruby_lsp, vtsls, jsonls, yamlls, dockerls, tailwindcss, biome, marksman, gopls). Also returns the `nvim-vtsls` plugin spec.
  - `plugins/init.lua` -- Additional plugin specs (tmux-navigator, snacks.nvim, grug-far, telekasten, local dev plugins)
  - `snippets/` -- Custom LuaSnip snippets (Lua loader format)
- **`lua/kickstart/plugins/`** -- Optional kickstart modules. Only `autopairs` is currently enabled in init.lua.
- **`after/ftplugin/`** -- Filetype-specific settings (telekasten)
- **`queries/telekasten/`** -- Custom Tree-sitter queries for a custom `telekasten` parser (source at `~/dev/tree-sitter-telekasten`)

## Key Conventions

- **Formatting**: stylua for Lua (2-space indent, spaces not tabs). JS/TS use biome; markdown/yaml/html use prettierd/prettier. Format-on-save is enabled via conform.nvim (toggle with `<leader>uf`).
- **LSP strategy**: Mason manages lua_ls and installer tools. Other LSP servers are configured natively in `lua/custom/lsp.lua` and expected to be installed externally (see comment at bottom of that file for install commands).
- **Leader key**: Space. Keymaps use `[D]escription` bracket notation for which-key display.
- **Local plugins**: `quickadd.nvim` and `trackit.nvim` are loaded from `~/dev/` via `dir` field.
- **Colorscheme**: rose-pine

## Lua Style

- 2 spaces indentation
- Single quotes for strings (stylua enforced)
- Plugin configs use `opts = {}` pattern where possible; `config = function()` only when needed
