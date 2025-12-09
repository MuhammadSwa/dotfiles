#!/usr/bin/env zsh
# ╔═══════════════════════════════════════════════════════════════════════════╗
# ║                          Modern ZSH Configuration                         ║
# ║                         ~/.config/zsh/.zshrc                              ║
# ╚═══════════════════════════════════════════════════════════════════════════╝

# ┌───────────────────────────────────────────────────────────────────────────┐
# │                            Core Settings                                  │
# └───────────────────────────────────────────────────────────────────────────┘
export ZDOTDIR="${ZDOTDIR:-$HOME/.config/zsh}"
export EDITOR="${EDITOR:-nvim}"
export VISUAL="${VISUAL:-nvim}"
export TERMINAL="${TERMINAL:-ghostty}"
export BROWSER="${BROWSER:-brave}"

# XDG Base Directories
export XDG_CONFIG_HOME="${XDG_CONFIG_HOME:-$HOME/.config}"
export XDG_DATA_HOME="${XDG_DATA_HOME:-$HOME/.local/share}"
export XDG_CACHE_HOME="${XDG_CACHE_HOME:-$HOME/.cache}"
export XDG_STATE_HOME="${XDG_STATE_HOME:-$HOME/.local/state}"

# ┌───────────────────────────────────────────────────────────────────────────┐
# │                           History Configuration                           │
# └───────────────────────────────────────────────────────────────────────────┘
HISTFILE="${XDG_STATE_HOME:-$HOME/.local/state}/zsh/history"
HISTSIZE=50000
SAVEHIST=50000

# Create history directory if it doesn't exist
[[ -d "${HISTFILE:h}" ]] || mkdir -p "${HISTFILE:h}"

setopt EXTENDED_HISTORY          # Write timestamps to history
setopt HIST_EXPIRE_DUPS_FIRST    # Expire duplicates first when trimming
setopt HIST_FIND_NO_DUPS         # Don't display duplicates when searching
setopt HIST_IGNORE_ALL_DUPS      # Remove older duplicate entries
setopt HIST_IGNORE_DUPS          # Don't record consecutive duplicates
setopt HIST_IGNORE_SPACE         # Don't record commands starting with space
setopt HIST_REDUCE_BLANKS        # Remove superfluous blanks
setopt HIST_SAVE_NO_DUPS         # Don't write duplicates to history file
setopt HIST_VERIFY               # Show command before executing from history
setopt INC_APPEND_HISTORY        # Add commands immediately to history
setopt SHARE_HISTORY             # Share history between all sessions

# ┌───────────────────────────────────────────────────────────────────────────┐
# │                            ZSH Options                                    │
# └───────────────────────────────────────────────────────────────────────────┘
setopt AUTO_CD                   # cd by typing directory name
setopt AUTO_PUSHD                # Push directories onto stack
setopt PUSHD_IGNORE_DUPS         # Don't push duplicates
setopt PUSHD_SILENT              # Don't print directory stack
setopt CORRECT                   # Command auto-correction
setopt EXTENDED_GLOB             # Extended globbing patterns
setopt GLOB_DOTS                 # Include dotfiles in globbing
setopt INTERACTIVE_COMMENTS      # Allow comments in interactive mode
setopt MENU_COMPLETE             # Auto-select first completion
setopt NO_BEEP                   # Silence terminal bell
setopt NO_FLOW_CONTROL           # Disable flow control (Ctrl-S/Ctrl-Q)
setopt PROMPT_SUBST              # Enable prompt substitution
setopt RM_STAR_WAIT              # Wait 10 seconds before rm * confirmation

# Disable Ctrl-S freeze
stty stop undef 2>/dev/null

# Don't highlight pasted text
zle_highlight=('paste:none')

# ┌───────────────────────────────────────────────────────────────────────────┐
# │                         Completion System                                 │
# └───────────────────────────────────────────────────────────────────────────┘
autoload -Uz compinit

# Cache completion for better performance (rebuild once per day)
_comp_cache="${XDG_CACHE_HOME:-$HOME/.cache}/zsh/zcompdump"
[[ -d "${_comp_cache:h}" ]] || mkdir -p "${_comp_cache:h}"

if [[ -n "${_comp_cache}"(#qN.mh+24) ]]; then
    compinit -d "$_comp_cache"
else
    compinit -C -d "$_comp_cache"
fi
unset _comp_cache

# Load completion list module
zmodload zsh/complist

# Completion styling
zstyle ':completion:*' completer _extensions _complete _approximate
zstyle ':completion:*' menu select                          # Interactive menu
zstyle ':completion:*' use-cache on                         # Enable caching
zstyle ':completion:*' cache-path "${XDG_CACHE_HOME:-$HOME/.cache}/zsh/zcompcache"
zstyle ':completion:*' complete-options true                # Complete options
zstyle ':completion:*' file-sort modification               # Sort by modification
zstyle ':completion:*' squeeze-slashes true                 # Remove trailing slashes
zstyle ':completion:*' matcher-list 'm:{a-zA-Z}={A-Za-z}'   # Case insensitive
zstyle ':completion:*' list-colors ${(s.:.)LS_COLORS}       # Use LS_COLORS
zstyle ':completion:*' group-name ''                        # Group by category
zstyle ':completion:*:descriptions' format '%F{yellow}── %d ──%f'
zstyle ':completion:*:messages' format '%F{purple}── %d ──%f'
zstyle ':completion:*:warnings' format '%F{red}── No matches ──%f'
zstyle ':completion:*:corrections' format '%F{green}── %d (errors: %e) ──%f'
zstyle ':completion:*:default' list-prompt '%S%M matches%s'

# Kill completion
zstyle ':completion:*:*:kill:*:processes' list-colors '=(#b) #([0-9]#)*=0=01;31'
zstyle ':completion:*:kill:*' command 'ps -u $USER -o pid,%cpu,tty,cputime,cmd'

# SSH/SCP completion
zstyle ':completion:*:ssh:*' hosts off
zstyle ':completion:*:scp:*' hosts off

# Include hidden files in completion
_comp_options+=(globdots)

# ┌───────────────────────────────────────────────────────────────────────────┐
# │                         Source Configuration Files                        │
# └───────────────────────────────────────────────────────────────────────────┘
# Function to safely source files
function zsh_source() {
    [[ -f "$1" ]] && source "$1"
}

# Source modular config files
for config_file in \
    "$ZDOTDIR/zsh-exports" \
    "$ZDOTDIR/zsh-functions" \
    "$ZDOTDIR/zsh-aliases" \
    "$ZDOTDIR/zsh-prompt" \
    "$ZDOTDIR/zsh-vim-mode" \
    "$ZDOTDIR/zsh-keybinds"
do
    zsh_source "$config_file"
done
unset config_file

# ┌───────────────────────────────────────────────────────────────────────────┐
# │                            Plugin Management                              │
# └───────────────────────────────────────────────────────────────────────────┘
PLUGIN_DIR="$ZDOTDIR/plugins"

# Function to load plugins (auto-download if missing)
function zsh_add_plugin() {
    local plugin_name="${1:t}"
    local plugin_dir="$PLUGIN_DIR/$plugin_name"
    
    # Clone if not present
    if [[ ! -d "$plugin_dir" ]]; then
        print -P "%F{cyan}Installing plugin:%f %F{yellow}$plugin_name%f"
        git clone --depth=1 "https://github.com/$1.git" "$plugin_dir" 2>/dev/null
    fi
    
    # Source the plugin
    local plugin_file
    for plugin_file in \
        "$plugin_dir/$plugin_name.plugin.zsh" \
        "$plugin_dir/$plugin_name.zsh" \
        "$plugin_dir/${plugin_name#zsh-}.plugin.zsh"
    do
        if [[ -f "$plugin_file" ]]; then
            source "$plugin_file"
            return 0
        fi
    done
    
    return 1
}

# Update all plugins
function zsh_update_plugins() {
    print -P "%F{cyan}Updating plugins...%f"
    for dir in "$PLUGIN_DIR"/*/.git(/); do
        local plugin_dir="${dir:h}"
        local plugin_name="${plugin_dir:t}"
        print -P "  %F{yellow}$plugin_name%f"
        git -C "$plugin_dir" pull --quiet
    done
    print -P "%F{green}Done!%f"
}

# Load plugins
zsh_add_plugin "zsh-users/zsh-autosuggestions"
zsh_add_plugin "zsh-users/zsh-syntax-highlighting"
zsh_add_plugin "hlissner/zsh-autopair"

# ┌───────────────────────────────────────────────────────────────────────────┐
# │                         Zoxide Integration                                │
# └───────────────────────────────────────────────────────────────────────────┘
# Initialize zoxide if available (lazy load for performance)
if (( $+commands[zoxide] )); then
    eval "$(zoxide init zsh)"
fi

# ┌───────────────────────────────────────────────────────────────────────────┐
# │                           FZF Integration                                 │
# └───────────────────────────────────────────────────────────────────────────┘
if (( $+commands[fzf] )); then
    # FZF configuration
    export FZF_DEFAULT_OPTS="
        --height=50%
        --layout=reverse
        --border=rounded
        --info=inline
        --marker='✓'
        --pointer='▶'
        --prompt='❯ '
        --color=bg+:#313244,bg:#1e1e2e,spinner:#f5e0dc,hl:#f38ba8
        --color=fg:#cdd6f4,header:#f38ba8,info:#cba6f7,pointer:#f5e0dc
        --color=marker:#f5e0dc,fg+:#cdd6f4,prompt:#cba6f7,hl+:#f38ba8
        --bind='ctrl-y:execute-silent(echo -n {+} | xclip -selection clipboard)'
        --bind='ctrl-u:preview-half-page-up,ctrl-d:preview-half-page-down'
    "
    
    # Use fd/rg if available
    if (( $+commands[fd] )); then
        export FZF_DEFAULT_COMMAND='fd --type f --hidden --follow --exclude .git'
        export FZF_CTRL_T_COMMAND="$FZF_DEFAULT_COMMAND"
        export FZF_ALT_C_COMMAND='fd --type d --hidden --follow --exclude .git'
    elif (( $+commands[rg] )); then
        export FZF_DEFAULT_COMMAND='rg --files --hidden --follow --glob "!.git"'
    fi
    
    # Source FZF keybindings
    for fzf_path in \
        /usr/share/fzf/key-bindings.zsh \
        /usr/share/doc/fzf/examples/key-bindings.zsh \
        ~/.fzf.zsh \
        "${XDG_CONFIG_HOME:-$HOME/.config}/fzf/fzf.zsh"
    do
        [[ -f "$fzf_path" ]] && source "$fzf_path" && break
    done
    unset fzf_path
fi

# ┌───────────────────────────────────────────────────────────────────────────┐
# │                         Key Bindings                                      │
# └───────────────────────────────────────────────────────────────────────────┘
# Line navigation (Emacs-style in vi insert mode)
autoload -Uz up-line-or-beginning-search down-line-or-beginning-search
zle -N up-line-or-beginning-search
zle -N down-line-or-beginning-search

bindkey '^p' up-line-or-beginning-search
bindkey '^n' down-line-or-beginning-search
bindkey '^k' up-line-or-beginning-search
bindkey '^j' down-line-or-beginning-search
bindkey '^[[A' up-line-or-beginning-search    # Up arrow
bindkey '^[[B' down-line-or-beginning-search  # Down arrow

# Delete key
bindkey '^[[P' delete-char
bindkey '^[[3~' delete-char

# Home/End keys
bindkey '^[[H' beginning-of-line
bindkey '^[[F' end-of-line
bindkey '^[[1~' beginning-of-line
bindkey '^[[4~' end-of-line

# Quick commands
bindkey -s '^z' 'zi\n'

# Menu select navigation
bindkey -M menuselect 'h' vi-backward-char
bindkey -M menuselect 'k' vi-up-line-or-history
bindkey -M menuselect 'l' vi-forward-char
bindkey -M menuselect 'j' vi-down-line-or-history
bindkey -M menuselect '^[[Z' reverse-menu-complete  # Shift-Tab

# ┌───────────────────────────────────────────────────────────────────────────┐
# │                         pnpm Integration                                  │
# └───────────────────────────────────────────────────────────────────────────┘
export PNPM_HOME="${XDG_DATA_HOME:-$HOME/.local/share}/pnpm"
[[ ":$PATH:" != *":$PNPM_HOME:"* ]] && export PATH="$PNPM_HOME:$PATH"

# ┌───────────────────────────────────────────────────────────────────────────┐
# │                         Local Configuration                               │
# └───────────────────────────────────────────────────────────────────────────┘
# Source local config if exists (machine-specific settings)
zsh_source "$ZDOTDIR/.zshrc.local"
zsh_source "$HOME/.zshrc.local"

# vim: ft=zsh sw=4 ts=4 et
