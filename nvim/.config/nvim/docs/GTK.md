# GTK / GNOME Development Setup

Neovim support for building GTK4/Libadwaita apps in Zig with [zig-gobject](https://github.com/ianprime0509/zig-gobject).

## Requirements

```sh
# Arch (paru)
paru -S blueprint-compiler    # provides blueprint-lsp + linter

# lemminx (XML LSP) installs automatically via Mason on first launch
```

## Toolchain

| File type          | Syntax highlighting            | LSP                  | Linter                     |
| ------------------ | ------------------------------ | -------------------- | -------------------------- |
| `.zig`             | treesitter                     | zls                  | —                          |
| `.blp` (Blueprint) | treesitter (**manual parser**) | `blueprint-compiler` | `blueprint_lint` on save   |
| `.ui` (GtkBuilder) | treesitter                     | lemminx              | —                          |
| XML (schemas etc.) | treesitter                     | lemminx              | —                          |

Filetype detection (`lua/core/lsp/init.lua`):

- `*.blp` → `blueprint`
- `*.ui` → `xml`

## Blueprint

### Syntax highlighting (manual parser)

The blueprint parser is **not** in the nvim-treesitter main-branch registry, so it is compiled and installed manually:

- Parser: `~/.local/share/nvim/site/parser/blueprint.so` (auto-discovered by Neovim)
- Queries: `queries/blueprint/highlights.scm`
- Activation: `FileType` autocmd calls `vim.treesitter.start(buf, "blueprint")`

Update/rebuild the grammar:

```sh
cd /tmp/opencode/tree-sitter-blueprint && git pull && \
cc -O2 -fPIC -I src -shared src/parser.c -o ~/.local/share/nvim/site/parser/blueprint.so
```

If `/tmp/opencode/tree-sitter-blueprint` is gone, re-clone first:

```sh
git clone --depth 1 https://github.com/huanie/tree-sitter-blueprint /tmp/opencode/tree-sitter-blueprint
```

### LSP

Runs as a subcommand (there is no `blueprint-lsp` binary):

```lua
vim.lsp.config("blueprint_ls", { cmd = { "blueprint-compiler", "lsp" }, ... })
```

### Linting

Custom `blueprint_lint` in `lua/plugins/lint.lua` wraps:

```sh
blueprint-compiler lint <file.blp>
```

Flags HIG/accessibility issues the LSP does not report (missing labels,
non-translatable strings, unused widgets, all-caps text, widget placement).
Parses the ANSI-colored CLI output into diagnostics with exact ranges.
Runs automatically on save / BufEnter like the JS linters.

### Compile check from terminal

```sh
blueprint-compiler compile ui/main.blp --output main.ui
```

## zls notes

zig-gobject generates large wrapper modules — keep them resolvable via your
project's `build.zig.zon` dependencies so zls can index them. zls uses default
settings here (`vim.lsp.enable({ "zls", ... })` in `lua/core/lsp/init.lua`);
if generated code produces noise, add a `zls` config with
`settings = { zls = { enable_snippets = false } }` or per-project `.zls.json`.

## Known limitations (upstream)

Extensions (`layout`, `styles`, `accessibility`, `responses`, ...) are **not part
of the GObject type system**, so no tool can type-check them:

- No completion for `column`, `row`, etc. inside `layout {}`
- Invalid names inside extension blocks are never flagged

This is inherent to Blueprint/GtkBuilder, not an editor issue. Regular
properties, signals, and classes get full validation.

## Config file map

| File                                    | Purpose                                    |
| --------------------------------------- | ------------------------------------------ |
| `lua/core/lsp/init.lua`                 | blueprint_ls, lemminx, zls configs + ftdetect |
| `lua/plugins/lint.lua`                  | `blueprint_lint` custom linter + parser     |
| `lua/core/treesitter.lua`               | `vim.treesitter.start` autocmd for blueprint |
| `lua/plugins/init.lua`                  | treesitter parser install list (incl. xml)  |
| `lua/core/mason.lua`                    | mason `ensure_installed` (lemminx)          |
| `queries/blueprint/highlights.scm`      | custom highlight queries                    |
