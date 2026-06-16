# Zsh Configuration

## Structure

```
~/.config/zsh/
├── .zshenv        # Env vars, XDG dirs, editor
├── .zshrc         # History, completion, sources everything
├── aliases.zsh    # Shell aliases
├── bindings.zsh   # Keybindings (vi-mode aware)
├── fzf.zsh        # fzf config and file picker
├── plugins.zsh    # Plugin loader (auto-installs)
├── prompt.zsh     # Custom prompt with git status
├── plugins/       # Git-cloned plugins
└── starship.toml  # Starship prompt config (unused)
```

## Keybindings

| Key          | Action                            |
| ------------ | --------------------------------- |
| `Ctrl+P`     | Accept full autosuggestion        |
| `Ctrl+F`     | fzf file picker (no hidden files) |
| `Ctrl+R`     | fzf history search                |
| `Ctrl+T`     | fzf file insert (includes hidden) |
| `Alt+C`      | fzf directory jump                |
| `Ctrl+Right` | Move forward one word             |
| `Ctrl+Left`  | Move backward one word            |
| `Up/Down`    | History substring search          |
| `Ctrl+\`     | Toggle autosuggestions            |
| `Right`      | Accept suggestion (partial/full)  |

## Vi-Mode (zsh-vi-mode)

Starts in insert mode. Press `Escape` to enter normal mode.

**Normal mode essentials:**

- `dd` - delete line
- `cc` - change line
- `p` - paste
- `u` - undo
- `Ctrl+r` - redo

**Insert mode:**

- `Ctrl+p` - accept autosuggestion
- `j k` - normal movement in normal mode

**Visual mode:**

- `v` - character select
- `V` - line select

## Aliases

| Alias      | Command                  |
| ---------- | ------------------------ |
| `ls`       | `eza --icons`            |
| `ll`       | `eza -lh --icons --git`  |
| `la`       | `eza -lah --icons --git` |
| `tree`     | `eza --tree --icons`     |
| `vim`      | `nvim`                   |
| `-`        | `cd -`                   |
| `df`       | `df -h`                  |
| `diff`     | `diff --color=auto`      |
| `glog`     | `git log` (one-page)     |
| `gadog`    | `git log --all --graph`  |
| `dotfiles` | git with dotfiles repo   |

## Navigation

- Type directory name + `Enter` to cd into it (`AUTOCD` enabled)
- `zoxide` tracks directories - use `z <pattern>` to jump
- `lf` - file manager that follows you to last visited dir
- Type `-` to go back to previous directory

## Plugins

| Plugin                       | Purpose                                |
| ---------------------------- | -------------------------------------- |
| zsh-autosuggestions          | Show gray suggestions from history     |
| zsh-history-substring-search | Type partial command + Up/Down to find |
| zsh-vi-mode                  | Vi keybindings in shell                |
| fast-syntax-highlighting     | Colorize commands as you type          |

Update all plugins: `zplugin-update`

## Git Status Symbols in Prompt

| Symbol | Meaning             |
| ------ | ------------------- |
| `●`    | Staged changes      |
| `∂`    | Unstaged changes    |
| `!`    | Untracked files     |
| `⇡/⇣`  | Ahead/behind remote |
| `⚡`   | Merge conflicts     |
| `✘`    | Deleted files       |

## Habits to Develop

1. **Use `z` instead of `cd`** - zoxide learns your patterns. `z proj` jumps to your projects dir.
2. **Use `Ctrl+P`** - Accept suggestions instead of retyping common commands.
3. **Use `Ctrl+R`** - Fuzzy search history instead of pressing Up repeatedly.
4. **Use `Ctrl+F`** - Insert file paths without leaving the terminal.
5. **Use `Up/Down`** - Search history by substring (type `git` + Up to cycle git commands).
6. **Use `-`** - Jump back to previous directory.
7. **Use `eza`** - `ls` is aliased; `ll` for details, `tree` for structure.
8. **Use `dotfiles`** - Manage dotfiles repo from anywhere.
9. **Use `Ctrl+\`** - Toggle suggestions off for screen recordings or clean output.
