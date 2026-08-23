# Flutter / Dart Development Setup

Neovim support for Dart and Flutter using [flutter-tools.nvim](https://github.com/nvim-flutter/flutter-tools.nvim)
on top of the native LSP client (Neovim 0.11+ `vim.lsp.config` API).

## Requirements

```sh
# Arch (paru)
paru -S dart-sdk flutter    # or install Flutter via your preferred method

# Verify the toolchain
flutter doctor
```

`flutter` and `dart` must be on `$PATH` — flutter-tools locates the SDK
automatically and starts `dartls` from it. **Do not** install Dart tooling via
Mason; Mason's Dart packages are broken/legacy and would conflict with the SDK.

## Toolchain

| File type | Syntax highlighting | LSP      | Formatter     | Debugging        |
| --------- | ------------------- | -------- | ------------- | ---------------- |
| `.dart`   | treesitter (`dart`) | `dartls` (managed by flutter-tools) | `dart format` (conform) | DAP via `flutter debug_adapter` |

Snippets: friendly-snippets ships Dart snippets, loaded through blink.cmp +
LuaSnip like every other filetype.

## Architecture notes

- **flutter-tools owns `dartls`.** It wraps the LSP client to add
  flutter-specific handlers (hot reload protocol, dev log, widget guides).
  There is deliberately **no** `vim.lsp.config("dartls", ...)` in
  `lua/core/lsp/init.lua` — configuring it there would conflict with the
  plugin's setup.
- **blink.cmp capabilities** are passed to the plugin-managed client via
  `opts.lsp.capabilities`, resolved in `config` (with blink.cmp listed as a
  dependency to guarantee load order). Without this, completion would not
  attach to `dartls`.
- **Document colors** use the built-in Neovim 0.12 `vim.lsp.document_color`
  (enabled for all LSPs in the `LspAttach` autocmd). The plugin-managed
  `lsp.color` option is deprecated upstream and is not used.
- **Formatting** goes through conform (`dart_format` = `dart format`), so
  format-on-save and `<leader>cf` behave the same as every other filetype.

## Features

- `:FlutterRun` / hot reload / hot restart with a dev log split
- Device & emulator pickers
- Widget guides (indent guides for nested widgets) and closing-tag hints
- Statusline: `vim.g.flutter_tools_decorations.app_version` / `.device`
- DAP debugging (`run_via_dap = true`, so `:FlutterRun` supports breakpoints)
- LSP niceties: todos, snippet completion, import updates on rename,
  document colors

## Keymaps

### Flutter (`<leader>F`)

| Key            | Command                  | Action            |
| -------------- | ------------------------ | ----------------- |
| `<leader>Fr`   | `:FlutterRun`            | Run app (via DAP) |
| `<leader>Fl`   | `:FlutterReload`         | Hot reload        |
| `<leader>FR`   | `:FlutterRestart`        | Hot restart       |
| `<leader>Fd`   | `:FlutterDevices`        | Select device     |
| `<leader>Fe`   | `:FlutterEmulators`      | Launch emulator   |
| `<leader>Fq`   | `:FlutterQuit`           | Quit running app  |
| `<leader>Fo`   | `:FlutterOutlineToggle`  | Widget outline    |
| `<leader>FD`   | `:FlutterOpenDevTools`   | Flutter DevTools  |
| `<leader>FL`   | `:FlutterLogClear`       | Clear dev log     |

### Debugging (`<leader>d`, nvim-dap)

| Key           | Action                        |
| ------------- | ----------------------------- |
| `<leader>db`  | Toggle breakpoint             |
| `<leader>dB`  | Conditional breakpoint        |
| `<leader>dc`  | Continue / start debugging    |
| `<leader>di`  | Step into                     |
| `<leader>do`  | Step over                     |
| `<leader>dO`  | Step out                      |
| `<leader>dt`  | Terminate session             |
| `<leader>du`  | Toggle DAP UI                 |

### LSP

Standard LSP keymaps apply in Dart buffers (`gd`, `K`, `<leader>rn`, `gra`,
`grr`, ... — mostly Neovim 0.12 defaults, see `lua/core/lsp/init.lua`).

## Run configuration

The default DAP launch config targets `lib/main.dart`. It passes
`--dart-define-from-file=config.json` — remove `toolArgs` from
`debugger.register_configurations` in `lua/plugins/flutter.lua` if your
project does not use dart-defines.

Per-project run configurations (flavors, targets, devices) can be defined in
an `.nvim.lua` exrc file, similar to VS Code's `launch.json`:

```lua
-- .nvim.lua (project root)
require("flutter-tools").setup_project({
  {
    name = "Development",
    flavor = "dev",
    target = "lib/main_dev.dart",
    device = "pixel6pro",
    dart_define = { API_URL = "https://dev.example.com/api" },
  },
})
```

## Config file map

| File                        | Purpose                                              |
| --------------------------- | ---------------------------------------------------- |
| `lua/plugins/flutter.lua`   | flutter-tools, nvim-dap, dap-ui, DAP launch config   |
| `lua/plugins/conform.lua`   | `dart_format` formatter                              |
| `lua/core/keymaps.lua`      | `<leader>F` (Flutter) and `<leader>d` (DAP) keymaps  |
| `lua/core/lsp/init.lua`     | built-in document colors on `LspAttach`              |
| `lua/plugins/init.lua`      | treesitter parser install list (includes `dart`)     |

## Troubleshooting

- **No completion / diagnostics in `.dart` files**: run `flutter doctor`, make
  sure the SDK is healthy and `dart` is on `$PATH`, then `:FlutterLspRestart`.
- **`:FlutterRun` can't find devices**: `flutter devices` in a terminal first;
  emulators need `:FlutterEmulators` → launch before running.
- **Breakpoints not binding**: requires `run_via_dap = true` (set by default);
  plain `flutter run` outside DAP cannot receive breakpoint events.
- **First launch is slow**: `dartls` runs initial analysis on the whole
  project; subsequent sessions are warm.
