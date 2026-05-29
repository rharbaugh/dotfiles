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
    eval "$(keychain --eval --quiet "${ssh_keys[@]}")"
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
  alias cat='bat --plain --paging=never'
  alias less='bat'
  export MANPAGER="sh -c 'col -bx | bat -l man -p'"
fi

if command -v rg >/dev/null 2>&1; then
  export RIPGREP_CONFIG_PATH="${XDG_CONFIG_HOME:-$HOME/.config}/ripgrep/ripgreprc"
fi

if command -v gpg-connect-agent >/dev/null 2>&1; then
  export GPG_TTY="$(tty)"
  gpg-connect-agent updatestartuptty /bye >/dev/null 2>&1
fi

if command -v fd >/dev/null 2>&1; then
  alias find='fd'
fi

if command -v ykman >/dev/null 2>&1; then
  alias yk='ykman oath accounts code'
fi

if command -v fzf >/dev/null 2>&1; then
  export FZF_DEFAULT_OPTS="${FZF_DEFAULT_OPTS:---height 40% --layout=reverse --border --cycle}"
  if command -v fd >/dev/null 2>&1; then
    export FZF_DEFAULT_COMMAND='fd --hidden --follow --exclude .git'
    export FZF_CTRL_T_COMMAND="$FZF_DEFAULT_COMMAND"
    export FZF_ALT_C_COMMAND='fd --type d --hidden --follow --exclude .git'
  fi

  source <(fzf --zsh)
fi

if command -v zoxide >/dev/null 2>&1; then
  eval "$(zoxide init zsh)"
fi

yy() {
  local tmp cwd
  tmp="$(mktemp -t yazi-cwd.XXXXXX)" || return
  yazi --cwd-file="$tmp" "$@"
  if cwd="$(command cat -- "$tmp")" && [[ -n "$cwd" && "$cwd" != "$PWD" ]]; then
    cd -- "$cwd"
  fi
  rm -f -- "$tmp"
}

if command -v starship >/dev/null 2>&1 && [[ ${TERM:-} != dumb ]]; then
  eval "$(starship init zsh)"
fi
