# PATH varaibles
export PATH=$PATH:$HOME/.local/scripts:$DENO_INSTALL_ROOT

# enable colors and change prompt:
autoload -U colors && colors	# Load colors

setopt autocd		# automatically cd into typed directory.
setopt interactive_comments # type comments not only in scripts
setopt correct  # try to suggest the correct command

# history settings
# history in cache directory:
HISTSIZE=1000
SAVEHIST=1000
# don't clutter the home directory
HISTFILE=~/.cache/zsh/history
# don't record repeated lines in history
setopt histignoredups
# don't save this line if it has a space in front of the command
setopt histignorespace

# don't accidentally overwrite existing files
setopt noclobber


# basic auto/tab complete:
autoload -U compinit
zstyle ':completion:*' menu select
zmodload zsh/complist
compinit

# suggest hidden files inside tab completions
_comp_options+=(globdots)		# Include hidden files.

# vi mode
#bindkey -v
export KEYTIMEOUT=1

# Use vim keys in tab complete menu:
bindkey -M menuselect 'h' vi-backward-char
bindkey -M menuselect 'k' vi-up-line-or-history
bindkey -M menuselect 'l' vi-forward-char
bindkey -M menuselect 'j' vi-down-line-or-history
bindkey -v '^?' backward-delete-char

# Change cursor shape for different vi modes.
#function zle-keymap-select () {
#    case $KEYMAP in
#        vicmd) echo -ne '\e[1 q';;      # block
#        viins|main) echo -ne '\e[5 q';; # beam
#    esac
#}
#zle -N zle-keymap-select
#zle-line-init() {
#    zle -K viins # initiate `vi insert` as keymap (can be removed if `bindkey -V` has been set elsewhere)
#    echo -ne "\e[5 q"
#}
#zle -N zle-line-init
#echo -ne '\e[5 q' # Use beam shape cursor on startup.
#preexec() { echo -ne '\e[5 q' ;} # Use beam shape cursor for each new prompt.
#
# Use lf to switch directories and bind it to ctrl-o
lfcd () {
    tmp="$(mktemp)"
    lf -last-dir-path="$tmp" "$@"
    if [ -f "$tmp" ]; then
        dir="$(cat "$tmp")"
        rm -f "$tmp" >/dev/null
        [ -d "$dir" ] && [ "$dir" != "$(pwd)" ] && cd "$dir"
    fi
}

bindkey -s '^o' 'lfcd\n'

#bindkey -s '^a' 'bc -lq\n'

#bindkey -s '^f' 'cd "$(dirname "$(fzf)")"\n'

#bindkey '^[[P' delete-char

# Edit line in vim with ctrl-e:
autoload edit-command-line; zle -N edit-command-line
bindkey '^e' edit-command-line

#
# OH MY ZSH settings
#
ZSH_THEME="robbyrussell"

# case sensitive completion
CASE_SENSITIVE="true"

zstyle ':omz:update' mode reminder  # just remind me to update when it's time

# Uncomment the following line if pasting URLs and other text is messed up.
DISABLE_MAGIC_FUNCTIONS="true"

plugins=(
  zsh-syntax-highlighting
)

source "$ZSH/oh-my-zsh.sh"

# apparently OH MY ZSH adds some alias which clashes with my aliases
[ -f "${XDG_CONFIG_HOME:-$HOME/.config}/shell/aliasrc" ] && source "${XDG_CONFIG_HOME:-$HOME/.config}/shell/aliasrc"
