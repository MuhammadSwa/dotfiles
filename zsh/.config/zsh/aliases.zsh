# Better ls
alias ls='eza --icons'

# Detailed listing
alias ll='eza -lh --icons --git'

# Detailed listing including hidden files
alias la='eza -lah --icons --git'

# Tree view
alias tree='eza --tree --icons'


alias ba='bash ~/dotfiles/scripts/scripts/android.sh'
alias bap='./gradlew assembleRelease && adb install -r app/build/outputs/apk/release/app-release.apk'
alias bar='./gradlew assembleFast && adb install -r app/build/outputs/apk/fast/app-fast.apk'

# Reuse ls completions for eza (avoids defining a separate completion function)
compdef eza=ls

# Better cat
# alias cat='bat'

# =========================================================
# Core utilities
# =========================================================

# alias grep='rg --color=auto'
alias diff='diff --color=auto'
alias df='df -h'

# =========================================================
# Navigation
# =========================================================

alias -- -='cd -'  # -- prevents - being parsed as a flag; cd - jumps to previous directory

lf() { # zsh follow lf navigation
    tmp=$(mktemp)
    command lf -last-dir-path="$tmp" "$@"
    if [ -f "$tmp" ]; then
        dir=$(cat "$tmp")
        rm -f "$tmp"
        [ -d "$dir" ] && [ "$dir" != "$(pwd)" ] && cd "$dir"
    fi
}

# =========================================================
# Editor
# =========================================================

alias vim='nvim'
zv() { nvim "$(zoxide query "$*")" }

# =========================================================
# Git
# =========================================================

alias glog='PAGER="less -F -X" git log'                              # -F quit if one screen, -X no clear on exit
alias gadog='PAGER="less -F -X" git log --all --decorate --oneline --graph'
alias dotfiles='git --git-dir=$HOME/.dotfiles --work-tree=$HOME'
alias gs="git status"

function gg() {
    git add .
    if [[ -n "$1" ]]; then
        git commit -m "$*"
    else
        git commit -m "Update $(date +%Y-%m-%d\ %H:%M)"
    fi
    git push
}

# =========================================================
# Video
# =========================================================

alias stream='mpv av://v4l2:/dev/video4 --fullscreen --demuxer-lavf-o=input_format=mjpeg,framerate=30 --profile=low-latency --untimed'
