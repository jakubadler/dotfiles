# The following lines were added by compinstall
zstyle :compinstall filename '/home/kuba/.zshrc'

autoload -Uz compinit
compinit
# End of lines added by compinstall
# Lines configured by zsh-newuser-install
HISTFILE=~/.histfile
HISTSIZE=1000
SAVEHIST=1000
bindkey -v
# End of lines configured by zsh-newuser-installs

bindkey '^[[A' up-line-or-search
bindkey '^[[B' down-line-or-search

autoload -Uz promptinit
promptinit
prompt gentoo

export VISUAL=vim
export EDITOR=vim
export PAGER=vimpager
export MANPAGER=vimmanpager
export PATH=${HOME}/bin:${PATH}
