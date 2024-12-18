# Lines configured by zsh-newuser-install
HISTSIZE=1000
SAVEHIST=1000

HISTFILE=~/.cache/zsh_history
mkdir -p "$(dirname "$HISTFILE")"

setopt HIST_FCNTL_LOCK
setopt HIST_IGNORE_DUPS
unsetopt HIST_IGNORE_ALL_DUPS
setopt HIST_IGNORE_SPACE
unsetopt HIST_EXPIRE_DUPS_FIRST
setopt SHARE_HISTORY
unsetopt EXTENDED_HISTORY

bindkey -v
# End of lines configured by zsh-newuser-install
# The following lines were added by compinstall
zstyle :compinstall filename '/home/rob/.zshrc'

autoload -Uz compinit
compinit
# End of lines added by compinstall

PROMPT="%F{blue}%m %~%b "$'\n'"%(?.%F{green}%Bλ%b |.%F{red}?) %f"

bindkey '^ ' autosuggest-accept
export EDITOR="nvim"

#load ssh keys on shell startup
eval `keychain --eval --quiet github devops`

#direnv hook
eval "$(direnv hook zsh)"

#aliases
alias -- 'c'='clear'
alias -- 'cat'='bat --paging=never --style=plain'
alias -- 'cp'='cp -riv'
alias -- 'ls'='eza -al --icons'
alias -- 'mkdir'='mkdir -vp'
alias -- 'mv'='mv -iv'
alias -- 'rm'='rm -rifv'
alias -- 'tree'='eza --tree --icons'

#gcc stuff
alias -- 'g++'='g++ -ggdb -pedantic-errors -Wall -Weffc++ -Wextra -Wconversion -Wsign-conversion -std=c++23'
alias -- 'g+++'='g++ -O2 -DNDEBUG -pedantic-errors -Wall -Weffc++ -Wextra -Wconversion -Wsign-conversion -std=c++23'


#named directory hashes
hash -d dots="$HOME/.dotfiles"
hash -d media="$HOME/media"
hash -d src="$HOME/src"
hash -d work="$HOME/work"
