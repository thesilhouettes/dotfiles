#
# ~/.bashrc
#

# If not running interactively, don't do anything
[[ $- != *i* ]] && return

[[ "$(whoami)" = "root" ]] && return

[[ -z "$FUNCNEST" ]] && export FUNCNEST=100          # limits recursive functions, see 'man bash'

## Use the up and down arrow keys for finding a command in history
## (you can write some initial letters of the command first).
bind '"\e[A":history-search-backward'
bind '"\e[B":history-search-forward'

# add more paths for my own scripts and other things
PATH=$PATH:$HOME/.local/scripts

# source my alias file
source $HOME/.config/scgen/shortcuts.sh

# more aliases
alias ls="exa -l"
alias la="exa -la"
alias lss="exa"

alias config="git --git-dir=$HOME/.dotfiles --work-tree=$HOME"

