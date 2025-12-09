# Neovim Configuration for Frontend Development

A modern, fast, and fully-featured Neovim configuration optimized for **frontend development** (TypeScript, JavaScript, React, SolidJS, Vue, Svelte, HTML/CSS, Tailwind CSS) while being easily extensible for other languages.

## Requirements

- **Neovim 0.11+** (uses modern `vim.lsp.config()` API)
- **Git** (for plugin management)
- **Node.js 18+** (for LSP servers and formatters)
- **A Nerd Font** (for icons) - [Download here](https://www.nerdfonts.com/)
- **ripgrep** (for Telescope live grep): `sudo apt install ripgrep` or `brew install ripgrep`
- **fd** (optional, for faster file finding): `sudo apt install fd-find` or `brew install fd`

## Installation

```bash
# Backup existing config (if any)
mv ~/.config/nvim ~/.config/nvim.backup

# Clone this configuration
git clone <your-repo-url> ~/.config/nvim

# Start Neovim - plugins will install automatically
nvim
```

On first launch, Lazy.nvim will automatically install all plugins. Wait for the installation to complete, then restart Neovim.

## Directory Structure

```
~/.config/nvim/
├── init.lua                 # Entry point - loads all modules
├── lazy-lock.json           # Plugin version lock file
├── lua/
│   ├── core/                # Core configuration
│   │   ├── options.lua      # Neovim options (tabs, line numbers, etc.)
│   │   ├── keymaps.lua      # All keybindings
│   │   ├── lazy.lua         # Plugin manager setup
│   │   ├── colorscheme.lua  # Theme configuration
│   │   ├── cmp.lua          # Autocompletion setup
│   │   ├── treesitter.lua   # Syntax highlighting & text objects
│   │   ├── mason.lua        # LSP/formatter/linter installer
│   │   ├── bufferline.lua   # Buffer tabs configuration
│   │   ├── lualine.lua      # Status line configuration
│   │   ├── nvim-tree.lua    # File explorer configuration
│   │   ├── toggleterm.lua   # Terminal configuration
│   │   ├── codium.lua       # AI completion (Codeium)
│   │   ├── lsp/
│   │   │   ├── init.lua     # LSP configuration (vim.lsp.config)
│   │   │   └── handlers.lua # Diagnostic signs & handlers
│   │   └── snippets/
│   │       └── solidjs.lua  # Custom SolidJS snippets
│   └── plugins/
│       └── init.lua         # Plugin specifications
└── README.md                # This file
```

## Key Features

### Language Support

- **TypeScript/JavaScript** - Full LSP with typescript-tools.nvim
- **React/JSX/TSX** - Auto-closing tags, proper commenting
- **HTML/CSS/SCSS** - Emmet expansion, color highlighting
- **Tailwind CSS** - Class completion, color preview
- **Lua** - Neovim API completion with lazydev.nvim
- **Go, Bash, JSON, YAML** - Full LSP support

### Developer Experience

- **AI Completion** - Codeium integration for AI-powered suggestions
- **Auto-formatting** - Prettier/ESLint on save via conform.nvim
- **Linting** - ESLint_d for fast linting
- **Git Integration** - Gitsigns for inline git info
- **File Explorer** - nvim-tree with custom keybindings
- **Fuzzy Finding** - Telescope for files, grep, symbols
- **Diagnostics** - Trouble.nvim for a VSCode-like problems panel

---

## Keybindings Reference

> **Leader Key: `Space`**

### General

| Keybind     | Description             |
| ----------- | ----------------------- |
| `<Esc>`     | Clear search highlights |
| `<leader>w` | Save file               |
| `<C-d>`     | Scroll down (centered)  |
| `<C-u>`     | Scroll up (centered)    |

### Window Navigation

| Keybind          | Description           |
| ---------------- | --------------------- |
| `<C-h>`          | Move to left window   |
| `<C-j>`          | Move to bottom window |
| `<C-k>`          | Move to top window    |
| `<C-l>`          | Move to right window  |
| `<C-Up/Down>`    | Resize window height  |
| `<C-Left/Right>` | Resize window width   |

### Buffer Navigation

| Keybind | Description              |
| ------- | ------------------------ |
| `<S-l>` | Next buffer              |
| `<S-h>` | Previous buffer          |
| `gb`    | Pick buffer (BufferLine) |
| `<C-w>` | Close buffer             |
| `<A-w>` | Force close buffer       |

### File Explorer (nvim-tree)

| Keybind     | Description          |
| ----------- | -------------------- |
| `<leader>e` | Toggle file explorer |
| `l`         | Open file/folder     |
| `h`         | Close folder         |
| `a`         | Create file          |
| `d`         | Delete file          |
| `r`         | Rename file          |
| `?`         | Show help            |

### Telescope (Fuzzy Finder)

| Keybind      | Description             |
| ------------ | ----------------------- |
| `<leader>ff` | Find files              |
| `<leader>fg` | Live grep (search text) |
| `<leader>fb` | Find buffers            |
| `<leader>fh` | Help tags               |
| `<leader>fw` | Grep word under cursor  |
| `<leader>fo` | Recent files            |
| `<leader>fd` | Find diagnostics        |
| `<leader>fr` | Find LSP references     |
| `<leader>fs` | Document symbols        |

### Git (via Telescope)

| Keybind      | Description  |
| ------------ | ------------ |
| `<leader>gc` | Git commits  |
| `<leader>gs` | Git status   |
| `<leader>gb` | Git branches |

### LSP (Language Server)

| Keybind      | Description              |
| ------------ | ------------------------ |
| `gd`         | Go to definition         |
| `gD`         | Go to declaration        |
| `gi`         | Go to implementation     |
| `gr`         | Go to references         |
| `K`          | Hover documentation      |
| `<C-k>`      | Signature help           |
| `<leader>rn` | Rename symbol            |
| `<leader>ca` | Code action              |
| `<leader>D`  | Type definition          |
| `<leader>f`  | Format buffer            |
| `<leader>ih` | Toggle inlay hints       |
| `gl`         | Show line diagnostics    |
| `[d` / `]d`  | Previous/Next diagnostic |

### TypeScript Specific

| Keybind      | Description                   |
| ------------ | ----------------------------- |
| `<leader>to` | Organize imports              |
| `<leader>ts` | Sort imports                  |
| `<leader>tu` | Remove unused imports         |
| `<leader>tf` | Fix all issues                |
| `<leader>ti` | Add missing imports           |
| `<leader>tr` | Rename file (updates imports) |
| `<leader>td` | Go to source definition       |

### Formatting

| Keybind      | Description           |
| ------------ | --------------------- |
| `<leader>cf` | Format file/selection |

### Trouble (Diagnostics Panel)

| Keybind      | Description             |
| ------------ | ----------------------- |
| `<leader>xx` | Toggle all diagnostics  |
| `<leader>xX` | Buffer diagnostics only |
| `<leader>cs` | Toggle symbols panel    |
| `<leader>cl` | LSP definitions panel   |
| `<leader>xL` | Location list           |
| `<leader>xQ` | Quickfix list           |

### Motion (Hop)

| Keybind | Description                     |
| ------- | ------------------------------- |
| `f`     | Hop to character (current line) |
| `,`     | Hop to 2 characters             |
| `;`     | Hop to line                     |

### Terminal

| Keybind      | Description              |
| ------------ | ------------------------ |
| `<C-\>`      | Toggle floating terminal |
| `<leader>dn` | Run `npm run dev`        |
| `<leader>dp` | Run `pnpm dev`           |
| `<leader>db` | Run `npm run build`      |

### Completion (nvim-cmp)

| Keybind             | Description                    |
| ------------------- | ------------------------------ |
| `<C-Space>`         | Trigger completion             |
| `<C-n>` / `<Tab>`   | Next item                      |
| `<C-p>` / `<S-Tab>` | Previous item                  |
| `<CR>`              | Confirm selection              |
| `<C-y>`             | Confirm (select first if none) |
| `<C-e>`             | Abort completion               |
| `<C-b>` / `<C-f>`   | Scroll docs                    |

### AI Completion (Codeium)

| Keybind | Description         |
| ------- | ------------------- |
| `<C-g>` | Accept suggestion   |
| `<M-]>` | Next suggestion     |
| `<M-[>` | Previous suggestion |
| `<C-x>` | Clear suggestion    |

### Treesitter Text Objects

| Keybind     | Description            |
| ----------- | ---------------------- |
| `af` / `if` | Around/inside function |
| `ac` / `ic` | Around/inside class    |
| `aa` / `ia` | Around/inside argument |
| `]f` / `[f` | Next/previous function |
| `]c` / `[c` | Next/previous class    |
| `<leader>a` | Swap next argument     |
| `<leader>A` | Swap previous argument |

### Code Manipulation

| Keybind     | Description                |
| ----------- | -------------------------- |
| `<leader>m` | Toggle split/join (treesj) |
| `<C-space>` | Incremental selection      |
| `<BS>`      | Decrement selection        |

---

## Plugin Overview

### Core Plugins

| Plugin                                                                | Description             |
| --------------------------------------------------------------------- | ----------------------- |
| [lazy.nvim](https://github.com/folke/lazy.nvim)                       | Modern plugin manager   |
| [nvim-lspconfig](https://github.com/neovim/nvim-lspconfig)            | LSP configuration       |
| [mason.nvim](https://github.com/williamboman/mason.nvim)              | LSP/formatter installer |
| [nvim-treesitter](https://github.com/nvim-treesitter/nvim-treesitter) | Syntax highlighting     |
| [nvim-cmp](https://github.com/hrsh7th/nvim-cmp)                       | Autocompletion          |
| [telescope.nvim](https://github.com/nvim-telescope/telescope.nvim)    | Fuzzy finder            |

### Frontend Specific

| Plugin                                                                   | Description                |
| ------------------------------------------------------------------------ | -------------------------- |
| [typescript-tools.nvim](https://github.com/pmizio/typescript-tools.nvim) | TypeScript LSP replacement |
| [conform.nvim](https://github.com/stevearc/conform.nvim)                 | Formatting (Prettier)      |
| [nvim-lint](https://github.com/mfussenegger/nvim-lint)                   | Linting (ESLint)           |
| [nvim-ts-autotag](https://github.com/windwp/nvim-ts-autotag)             | Auto-close HTML/JSX tags   |
| [emmet-vim](https://github.com/mattn/emmet-vim)                          | Emmet expansion            |
| [nvim-colorizer.lua](https://github.com/NvChad/nvim-colorizer.lua)       | Color preview              |

### UI & Navigation

| Plugin                                                        | Description      |
| ------------------------------------------------------------- | ---------------- |
| [tokyonight.nvim](https://github.com/folke/tokyonight.nvim)   | Colorscheme      |
| [bufferline.nvim](https://github.com/akinsho/bufferline.nvim) | Buffer tabs      |
| [lualine.nvim](https://github.com/nvim-lualine/lualine.nvim)  | Status line      |
| [nvim-tree.lua](https://github.com/nvim-tree/nvim-tree.lua)   | File explorer    |
| [which-key.nvim](https://github.com/folke/which-key.nvim)     | Keybinding hints |

### Editor Enhancements

| Plugin                                                            | Description        |
| ----------------------------------------------------------------- | ------------------ |
| [hop.nvim](https://github.com/smoka7/hop.nvim)                    | Fast motions       |
| [nvim-autopairs](https://github.com/windwp/nvim-autopairs)        | Auto bracket pairs |
| [trouble.nvim](https://github.com/folke/trouble.nvim)             | Diagnostics panel  |
| [todo-comments.nvim](https://github.com/folke/todo-comments.nvim) | Highlight TODOs    |
| [gitsigns.nvim](https://github.com/lewis6991/gitsigns.nvim)       | Git integration    |
| [toggleterm.nvim](https://github.com/akinsho/toggleterm.nvim)     | Terminal           |

---

## Customization

### Adding a New Language

1. **Install LSP server via Mason**:

   ```vim
   :Mason
   ```

   Search for your language server and press `i` to install.

2. **Configure the LSP** in `lua/core/lsp/init.lua`:

   ```lua
   vim.lsp.config("pyright", {
     settings = {
       python = {
         analysis = { typeCheckingMode = "basic" },
       },
     },
   })
   ```

3. **Add formatter** in `lua/plugins/init.lua` (conform.nvim config):

   ```lua
   python = { "black", "isort" },
   ```

4. **Add linter** in `lua/plugins/init.lua` (nvim-lint config):
   ```lua
   python = { "pylint" },
   ```

### Changing the Colorscheme

Edit `lua/core/colorscheme.lua`:

```lua
local colorscheme = "tokyonight-storm"  -- or "catppuccin", "gruvbox", etc.
```

Popular themes to try:

- `tokyonight-night`, `tokyonight-storm`, `tokyonight-moon`
- Install others via lazy.nvim in `plugins/init.lua`

### Adding Custom Snippets

Create a new file in `lua/core/snippets/` (e.g., `react.lua`):

```lua
local ls = require("luasnip")
local s = ls.snippet
local t = ls.text_node
local i = ls.insert_node

ls.add_snippets("typescriptreact", {
  s("rfc", {
    t("export function "), i(1, "Component"), t("() {"),
    t({"", "  return ("}),
    t({"", "    <div>"}),
    t({"", "      "}), i(2),
    t({"", "    </div>"}),
    t({"", "  )"}),
    t({"", "}"}),
  }),
})
```

Then require it in `lua/core/cmp.lua`:

```lua
pcall(require, "core.snippets.react")
```

---

## Troubleshooting

### LSP Not Working

1. Check if the LSP is installed:

   ```vim
   :Mason
   ```

2. Check LSP status:

   ```vim
   :LspInfo
   ```

3. Check for errors:
   ```vim
   :checkhealth lsp
   ```

### Plugins Not Loading

1. Update plugins:

   ```vim
   :Lazy sync
   ```

2. Check for errors:
   ```vim
   :Lazy
   ```
   Look for plugins with errors (shown in red).

### Treesitter Issues

1. Update parsers:

   ```vim
   :TSUpdate
   ```

2. Reinstall a specific parser:
   ```vim
   :TSInstall! typescript
   ```

### Icons Not Displaying

Ensure you have a Nerd Font installed and configured in your terminal:

- [Nerd Fonts Download](https://www.nerdfonts.com/font-downloads)
- Recommended: JetBrainsMono Nerd Font, FiraCode Nerd Font

---

## Commands Reference

| Command           | Description                  |
| ----------------- | ---------------------------- |
| `:Lazy`           | Open plugin manager          |
| `:Lazy sync`      | Update all plugins           |
| `:Mason`          | Open LSP/formatter installer |
| `:LspInfo`        | Show LSP status              |
| `:TSUpdate`       | Update Treesitter parsers    |
| `:ConformInfo`    | Show formatter status        |
| `:Trouble`        | Open diagnostics panel       |
| `:SessionManager` | Manage sessions              |
| `:checkhealth`    | Run health checks            |

---

## Performance Tips

1. **Lazy loading** - Most plugins are lazy-loaded by event or command
2. **Disable unused plugins** - Comment out plugins you don't need in `plugins/init.lua`
3. **Use faster alternatives** - `prettierd` and `eslint_d` are used for speed
4. **Treesitter** - Only enabled languages are installed

---

## Credits & Inspiration

- [LazyVim](https://github.com/LazyVim/LazyVim)
- [NvChad](https://github.com/NvChad/NvChad)
- [LunarVim](https://github.com/LunarVim/LunarVim)
- Neovim community and plugin authors

---

## License

MIT License - Feel free to use and modify as you wish!
