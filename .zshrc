# Lines configured by zsh-newuser-install
source ~/.cache/wal/colors-tty.sh
HISTFILE=~/.histfile
HISTSIZE=1000
SAVEHIST=10000
setopt autocd
bindkey -v
# End of lines configured by zsh-newuser-install
# The following lines were added by compinstall
zstyle :compinstall filename '/home/rajs/.zshrc'
export EDITOR='nvim'
export VISUAL='nvim'
export PATH="$HOME/.config/hypr/scripts/bin:$PATH"
fastfetch
(cat ~/.cache/wal/sequences &)
autoload -Uz compinit
compinit
eval `ssh-agent`
# End of lines added by compinstall
eval "$(starship init zsh)"
