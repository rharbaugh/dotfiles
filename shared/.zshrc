export EDITOR="${EDITOR:-nvim}"
export VISUAL="${VISUAL:-$EDITOR}"
export PAGER="${PAGER:-less}"
export LESS="${LESS:--R --use-color -Dd+r -Du+b}"

path=("$HOME/.local/bin" /usr/local/sbin /usr/local/bin /usr/bin $path)
typeset -U path

HISTFILE="${XDG_STATE_HOME:-$HOME/.local/state}/zsh/history"
HISTSIZE=50000
SAVEHIST=50000
mkdir -p "${HISTFILE:h}" 2>/dev/null

setopt append_history
setopt hist_ignore_all_dups
setopt hist_ignore_space
setopt hist_reduce_blanks
setopt inc_append_history
setopt share_history
setopt autocd
setopt interactive_comments
setopt no_beep

autoload -Uz compinit
zstyle ':completion:*' matcher-list 'm:{a-z}={A-Z}'
zstyle ':completion:*' menu select
compinit -d "${XDG_CACHE_HOME:-$HOME/.cache}/zsh/zcompdump"

bindkey -e

if command -v keychain >/dev/null 2>&1; then
  ssh_keys=()
  for key in "$HOME/.ssh/github" "$HOME/.ssh/git"; do
    [[ -r "$key" ]] && ssh_keys+=("$key")
  done

  if (( ${#ssh_keys[@]} )); then
    eval "$(keychain --eval --quiet --agents ssh "${ssh_keys[@]}")"
  fi
fi

if command -v nvim >/dev/null 2>&1; then
  alias v='nvim'
fi

if command -v eza >/dev/null 2>&1; then
  alias ls='eza -al --group-directories-first --icons=auto'
  alias ll='ls'
  alias la='ls'
  alias tree='eza --tree --level=2 --long --icons=auto --git'
fi

if command -v bat >/dev/null 2>&1; then
  alias cat='bat --paging=never'
  alias less='bat'
  export MANPAGER="sh -c 'col -bx | bat -l man -p'"
fi

if command -v starship >/dev/null 2>&1 && [[ ${TERM:-} != dumb ]]; then
  eval "$(starship init zsh)"
fi
