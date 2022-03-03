# PATH varaibles
export PATH=$PATH:$HOME/.local/scripts:$HOME/.local/share/npm-global/bin:$DENO_INSTALL_ROOT
# enable colors and change prompt:
autoload -U colors && colors	# Load colors

eval "$(starship init zsh)"
# using spaceship right now, I will just comment the custom prompt out
#PROMPT="[%B%0(?.%F{2}%?%f.%F{3}%?%f)%b] %B%F{6}%n%f%b at %B%F{7}%3~%f%b $(git_super_status)%B%(#.%F{1}#%f.%F{5}$%f)%b "
# right prompt
#RPROMPT='<%!>'

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

# enables keys like Ctrl+A, Ctrl+K etc.
bindkey -e
# pfetch configuration
# a white colour, instead of a greyish colour
export PF_COL2=7

# what to show in pfetch
export PF_INFO="ascii os kernel uptime pkgs editor shell"

# node version manager
export NVM_DIR="$([ -z "${XDG_CONFIG_HOME-}" ] && printf %s "${HOME}/.nvm" || printf %s "${XDG_CONFIG_HOME}/nvm")"
# this will make nvm work on demand
alias nvm="unalias nvm; [ -s "$NVM_DIR/nvm.sh" ] && . "$NVM_DIR/nvm.sh"; nvm $@"

[ -f "${XDG_CONFIG_HOME:-$HOME/.config}/shell/aliasrc" ] && source "${XDG_CONFIG_HOME:-$HOME/.config}/shell/aliasrc"

# source plugins
source /usr/share/zsh/plugins/zsh-autosuggestions/zsh-autosuggestions.zsh
source /usr/share/zsh/plugins/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh

# auto suggestions settings
bindkey '^ ' autosuggest-accept
