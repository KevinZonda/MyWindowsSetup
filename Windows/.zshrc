# Lines configured by zsh-newuser-install
HISTFILE=~/.histfile
HISTSIZE=1000
SAVEHIST=1000
bindkey -e
# End of lines configured by zsh-newuser-install
# The following lines were added by compinstall
zstyle :compinstall filename '/home/Kevin/.zshrc'

autoload -Uz compinit
compinit
# End of lines added by compinstall
bindkey "^[[1;5D" backward-word
bindkey "^[[1;5G" forward-word
bindkey '^[[1;5C' forward-word
bindkey '^[[1;3C' forward-word # Alt + Right
bindkey '^[[1;3D' backward-word # Alt + Left
