# Neovim Configuration

Modern Neovim **0.12** configuration for **frontend development** (TypeScript/JSX/Astro/SolidJS),
**Zig**, and **GTK/GNOME** development. Uses only current APIs:

- `vim.lsp.config()` / `vim.lsp.enable()` (no `setup {}` boilerplate)
- [blink.cmp](https://github.com/saghen/blink.cmp) for completion
- nvim-treesitter **main branch**
- TS7 native TypeScript LSP (`tsc --lsp --stdio`)

## Requirements

- **Neovim 0.12+** (`vim.lsp.config` is core)
- **Git**
- **Node.js 18+** (LSP servers, formatters)
- **A Nerd Font** (icons)
- **ripgrep** + **fd** (fzf-lua pickers)
- **zig** + **zls** (Zig), **blueprint-compiler** (GTK, see [docs/GTK.md](docs/GTK.md))

## Installation

```bash
mv ~/.config/nvim ~/.config/nvim.backup   # if needed
git clone <your-repo-url> ~/.config/nvim
nvim                                      # Lazy installs plugins on first run
```

copilot.lua is expected at `~/.local/share/nvim/local_plugins/copilot.lua`
(`dir = ...` spec in `lua/plugins/copilot.lua`):

```bash
git clone https://github.com/zbirenbaum/copilot.lua \
  ~/.local/share/nvim/local_plugins/copilot.lua
```

## Structure

```
~/.config/nvim/
├── init.lua                  # Entry point (load order matters: mason before lsp)
├── lazy-lock.json            # Plugin lockfile
├── lua/
│   ├── core/
│   │   ├── lazy.lua          # lazy.nvim bootstrap + UI
│   │   ├── options.lua       # vim.opt settings + basic autocmds
│   │   ├── keymaps.lua       # All keybindings
│   │   ├── colorscheme.lua   # tokyonight night
│   │   ├── cmp.lua           # blink.cmp + LuaSnip snippets
│   │   ├── treesitter.lua    # autotag, commentstring, blueprint parser start
│   │   ├── mason.lua         # Mason + mason-lspconfig (automatic_enable)
│   │   ├── bufferline.lua    # Buffer tabs
│   │   ├── lualine.lua       # Status line
│   │   ├── nvim-tree.lua     # File explorer
│   │   ├── terminal.lua      # Custom floating terminal (no plugin)
│   │   ├── lsp/
│   │   │   ├── init.lua      # vim.lsp.config per server + LspAttach keymaps
│   │   │   └── handlers.lua  # Diagnostic UI config
│   │   └── snippets/solidjs.lua
│   └── plugins/
│       ├── init.lua          # Plugin specs (lazy.nvim imports "plugins")
│       ├── conform.lua       # Formatting (oxfmt / prettierd / stylua)
│       ├── lint.lua          # oxlint + custom blueprint_lint
│       ├── copilot.lua       # Copilot ghost text
│       ├── fzf.lua           # fzf-lua pickers
│       └── trouble.lua       # Diagnostics/symbols panel
└── queries/blueprint/highlights.scm
```

## Language Support

| Language        | LSP                          | Format              | Lint              |
| --------------- | ---------------------------- | ------------------- | ----------------- |
| Zig             | zls                          | zls                 | —                 |
| TS/JS/TSX/JSX   | TS7 native (`tsc --lsp`)     | oxfmt → prettierd   | oxlint            |
| Astro           | astro-ls                     | prettierd           | oxlint            |
| HTML/CSS/JSON…  | emmet_ls, jsonls             | prettierd           | —                 |
| Lua             | lua_ls (+ lazydev)           | stylua              | —                 |
| Go              | gopls                        | gopls               | —                 |
| Blueprint `.blp`| blueprint-compiler           | —                   | blueprint_lint    |
| XML `.ui`       | lemminx                      | —                   | —                 |

Notes:

- **ts_ls** resolves `tsc.js` via `npm root -g` at startup; falls back to
  typescript-language-server if not found.
- **qml** parser is unsupported in nvim-treesitter main registry; `qmlls6` LSP is still enabled.

---

# Keybindings

> Leader: `Space`, LocalLeader: `\`

### General

| Keybind     | Action                        |
| ----------- | ----------------------------- |
| `<Esc>`     | Clear search highlight        |
| `<leader>w` | Save                          |
| `<C-d>`/`<C-u>` | Scroll half page (centered) |
| `n`/`N`     | Next/prev match (centered)    |
| `<A-j>`/`<A-k>` | Move line down/up         |
| `<leader>p` | Paste over w/o yanking        |
| `<leader>x` / `x` | Delete w/o yanking      |

### Windows & Buffers

| Keybind         | Action                     |
| --------------- | -------------------------- |
| `<C-h/j/k/l>`   | Focus window               |
| `<leader>sv/sh` | Vertical/horizontal split  |
| `<C-Arrows>`    | Resize window              |
| `<S-l>`/`<S-h>` | Next/previous buffer       |
| `gb`            | Pick buffer (bufferline)   |
| `<C-w>`         | Close buffer ⚠️ shadows window chords |
| `<A-w>`         | Force close buffer         |

### Motion (flash.nvim)

| Keybind        | Action                              |
| -------------- | ----------------------------------- |
| `f/F/t/T/;/,`  | Flash char motions (labelled jumps) |
| `;`            | Flash jump (search + labels)        |
| `<leader>;`    | Flash treesitter (smart target)     |

### Pickers (fzf-lua)

| Keybind      | Action            | Keybind      | Action              |
| ------------ | ----------------- | ------------ | ------------------- |
| `<leader>ff` | Files             | `<leader>fr` | LSP references      |
| `<leader>fg` | Live grep         | `<leader>fs` | Document symbols    |
| `<leader>fb` | Buffers           | `<leader>fd` | Workspace diagnostics|
| `<leader>fh` | Help tags         | `<leader>gc/gs/gB` | Git commits/status/branches |
| `<leader>fo` | Recent files      | `<leader>fw` | Grep word           |

### LSP

Built-in 0.12 defaults are kept (`grr` refs, `gri` implementations, `grn` rename,
`gra` code action, `gO` symbols, `K` hover, `grt` type definition). Additions:

| Keybind       | Action                |
| ------------- | --------------------- |
| `gd`/`gD`     | Definition/Declaration|
| `<leader>rn`  | Rename                |
| `<leader>f`   | Format (LSP)          |
| `<leader>ih`  | Toggle inlay hints    |
| `gl`          | Diagnostic float      |
| `[d`/`]d`     | Prev/next diagnostic  |
| `<leader>q`   | Diagnostics → loclist |

### TypeScript

| Keybind      | Action           |
| ------------ | ---------------- |
| `<leader>to` | Organize imports |
| `<leader>tu` | Remove unused    |
| `<leader>tf` | Quickfix         |
| `<leader>ti` | Add missing imports |

### Formatting & Trouble

| Keybind      | Action                    |
| ------------ | ------------------------- |
| `<leader>cf` | Format (conform, any mode)|
| `<leader>m`  | Split/join (treesj)       |
| `<leader>xx`/`xX` | All/buffer diagnostics |
| `<leader>cs`/`cl`  | Symbols/LSP panel   |
| `<leader>xL`/`xQ`  | Loclist/quickfix    |

### Completion (blink.cmp)

| Keybind        | Action                    |
| -------------- | ------------------------- |
| `<C-Space>`    | Trigger / toggle docs     |
| `<C-n/p>`      | Select next/prev          |
| `<Tab>`/`<S-Tab>` | Next/prev + snippet jump |
| `<C-y>`        | Accept                    |
| `<C-e>`        | Cancel                    |
| `<C-b/f>`      | Scroll documentation      |

Copilot provides independent ghost text: `<C-j>` accept, `<M-]>/<M-[>` cycle,
`<C-x>` dismiss.

### Terminal

| Keybind      | Action                   |
| ------------ | ------------------------ |
| `<C-\>`      | Toggle floating terminal |
| `<leader>dn` | `npm run dev`            |
| `<leader>dp` | `pnpm dev`               |
| `<leader>db` | `npm run build`          |

---

## Customization

### Add a language server

```lua
-- lua/core/lsp/init.lua
vim.lsp.config("pyright", {
  settings = { python = { analysis = { typeCheckingMode = "basic" } } },
})

-- add to the vim.lsp.enable({ ... }) list
```

Install via Mason (`ensure_installed` in `lua/core/mason.lua`) or system package.

### Formatter / linter

```lua
-- lua/plugins/conform.lua
formatters_by_ft = { python = { "ruff" } }

-- lua/plugins/lint.lua
lint.linters_by_ft = { python = { "ruff" } }
```

### Snippets

Add a file under `lua/core/snippets/` and `pcall(require, "core.snippets.<name>")`
in `lua/core/cmp.lua`.

## Troubleshooting

| Problem          | Check                                        |
| ---------------- | -------------------------------------------- |
| LSP missing      | `:checkhealth lsp`, `:Mason`                 |
| Plugin issues    | `:Lazy` (red = broken)                       |
| Formatting off   | `:ConformInfo`                               |
| Parsers stale    | `:TSUpdate`                                  |
| No icons         | Install a Nerd Font, set it in your terminal |
