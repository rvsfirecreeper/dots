# Lines configured by zsh-newuser-install
HISTFILE=~/.histfile
HISTSIZE=1000
SAVEHIST=10000
setopt autocd
export LANG=en_US.UTF-8
export LC_ALL=en_US.UTF-8
export TERM=xterm-256color
bindkey -v
# End of lines configured by zsh-newuser-install
# The following lines were added by compinstall
zstyle :compinstall filename '/home/rajs/.zshrc'
export EDITOR='nvim'
export VISUAL='nvim'
fastfetch
autoload -Uz compinit
compinit
export PATH=/home/ragef/.cargo/bin:$PATH
export PATH=/home/ragef/.local/bin:$PATH
alias sudo="doasidisahdiluahwdoliuakjwshdfiopawufhaespofihjewd"
alias yay="paru"
setopt interactivecomments
eval `ssh-agent`
# End of lines added by compinstall
eval "$(starship init zsh)"
