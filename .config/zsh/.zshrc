# Enable Powerlevel10k instant prompt. Should stay close to the top of ~/.config/zsh/.zshrc.
# Initialization code that may require console input (password prompts, [y/n]
# confirmations, etc.) must go above this block; everything else may go below.
if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi

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

[ -f "${XDG_CONFIG_HOME:-$HOME/.config}/shell/aliasrc" ] && source "${XDG_CONFIG_HOME:-$HOME/.config}/shell/aliasrc"

# basic auto/tab complete:
autoload -U compinit
zstyle ':completion:*' menu select
zmodload zsh/complist
compinit

# suggest hidden files inside tab completions
_comp_options+=(globdots)		# Include hidden files.

# vi mode
bindkey -v
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

# this is provided by zsh-you-should-use package on AUR
source /usr/share/zsh/plugins/zsh-you-should-use/you-should-use.plugin.zsh
# powerlevel10k also from AUR
source /usr/share/zsh-theme-powerlevel10k/powerlevel10k.zsh-theme
# this is provided by zsh-syntax-highlighting package
source /usr/share/zsh/plugins/zsh-syntax-highlighting/zsh-syntax-highlighting.plugin.zsh
# I will re-organize it later
source $HOME/.local/repos/zsh-autosuggestions/zsh-autosuggestions.plugin.zsh

# To customize prompt, run `p10k configure` or edit ~/.config/zsh/.p10k.zsh.
[[ ! -f ~/.config/zsh/.p10k.zsh ]] || source ~/.config/zsh/.p10k.zsh
