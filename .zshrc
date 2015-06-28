#
# Executes commands at the start of an interactive session.
#
# Authors:
#   Sorin Ionescu <sorin.ionescu@gmail.com>
#

# Source Prezto.
if [[ -s "${ZDOTDIR:-$HOME}/.zprezto/init.zsh" ]]; then
  source "${ZDOTDIR:-$HOME}/.zprezto/init.zsh"
fi

# Customize to your needs...
##MY CONFIG
export PATH="$PATH:$HOME/.rvm/bin" # Add RVM to PATH for scripting
#export PATH="$PATH:/usr/local/mysql-5.5.24-osx10.5-x86_64/bin"
# MacPorts Installer addition on 2015-03-11_at_01:02:07: adding an appropriate PATH variable for use with MacPorts.
export PATH="/opt/local/bin:/opt/local/sbin:$PATH"
export PATH="/Users/user/bin:$PATH"
# export SSL_CERT_FILE=/Users/user/cacert.pm
# export CURL_CA_BUNDLE=/Users/user/cacert.pm
MYSQL=/usr/local/mysql/bin
export PATH=$PATH:$MYSQL
#export DYLD_LIBRARY_PATH=/usr/local/mysql/lib:$DYLD_LIBRARY_PATH
# Finished adapting your PATH environment variable for use with MacPorts.

#PATH Vairables dor Go
export GOPATH=$HOME/go
export PATH=$PATH:$GOPATH/bin
#End

export PYTHONPATH=/usr/local/lib/python2.7/site-packages:$PYTHONPATH
##END OF ALL PATHS
[[ -s "$HOME/.rvm/scripts/rvm" ]] && source "$HOME/.rvm/scripts/rvm" # Load RVM into a shell session *as a function*
if which rbenv > /dev/null; then eval "$(rbenv init -)"; fi
alias e=emacs

# You may need to manually set your language environment
# export LANG=en_US.UTF-8

#Preferred editor for local and remote sessions
if [[ -n $SSH_CONNECTION ]]; then
  export EDITOR='emacs'
else
  export EDITOR='emacs'
fi

# Compilation flags
# export ARCHFLAGS="-arch x86_64"

# ssh
# export SSH_KEY_PATH="~/.ssh/dsa_id"

# Set personal aliases, overriding those provided by oh-my-zsh libs,
# plugins, and themes. Aliases can be placed here, though oh-my-zsh
# users are encouraged to define aliases within the ZSH_CUSTOM folder.
# For a full list of active aliases, run `alias`.
#
# Example aliases
# alias zshconfig="mate ~/.zshrc"
# alias ohmyzsh="mate ~/.oh-my-zsh"
export HISTSIZE=100000 SAVEHIST=100000
export HISTFILE=~/.zsh_history
##
# zsh configuration
#
# shell options
setopt autocd # assume "cd" when a command is a directory
setopt clobber
setopt histignorealldups # Substitute commands in the prompt
#setopt sharehistory # Share the same history between all shells
setopt promptsubst # required for git plugin
unsetopt beep
unsetopt hist_beep
unsetopt list_beep
unsetopt clobber
unsetopt ignore_eof
unsetopt rm_star_silent
setopt correct
setopt nullglob
unsetopt list_ambiguous
setopt auto_remove_slash
unsetopt glob_dots
setopt chase_links
setopt hist_verify
setopt auto_pushd
setopt pushd_ignore_dups
setopt pushd_silent
setopt pushd_to_home
unsetopt bg_nice
unsetopt hup
#setopt APPEND_HISTORY # adds history
setopt SHARE_HISTORY
setopt HIST_REDUCE_BLANKS

# setopt extendedglob
# Extended glob syntax, eg ^ to negate, <x-y> for range, (foo|bar) etc.
# Backwards-incompatible with bash, so disabled by default.

# Colors!

# 256 color mode
#0;95;cexport TERM="xterm-16color"

# Color aliases
if command -V dircolors >/dev/null 2>&1; then
	eval "$(dircolors -b)"
	# Only alias ls colors if dircolors is installed
	alias ls="ls -F --color=auto"
	alias dir="dir --color=auto"
	alias vdir="vdir --color=auto"
fi

alias grep="grep --color=auto"
alias fgrep="fgrep --color=auto"
alias egrep="egrep --color=auto"
alias dmesg="dmesg --color=auto"
# make less accept color codes and re-output them
alias less="less -R"

#MySql Aliases
# alias mysql /usr/local/mysql/bin/mysql
# alias mysqladmin /usr/local/mysql/bin/mysqladmin
# alias mysql-server="/usr/local/mysql/support-files/mysql.server"
##
# Completion system
#

autoload -Uz compinit
compinit

zstyle ":completion:*" auto-description "specify: %d"
zstyle ":completion:*" completer _expand _complete _correct _approximate
zstyle ":completion:*" format "Completing %d"
zstyle ":completion:*" group-name ""
zstyle ":completion:*" menu select=2
zstyle ":completion:*:default" list-colors ${(s.:.)LS_COLORS}
zstyle ":completion:*" list-colors ""
zstyle ":completion:*" list-prompt %SAt %p: Hit TAB for more, or the character to insert%s
zstyle ":completion:*" matcher-list "" "m:{a-z}={A-Z}" "m:{a-zA-Z}={A-Za-z}" "r:|[._-]=* r:|=* l:|=*"
zstyle ":completion:*" menu select=long
zstyle ":completion:*" select-prompt %SScrolling active: current selection at %p%s
zstyle ":completion:*" use-compctl false
zstyle ":completion:*" verbose true

zstyle ":completion:*:*:kill:*:processes" list-colors "=(#b) #([0-9]#)*=0=01;31"
zstyle ":completion:*:kill:*" command "ps -u $USER -o pid,%cpu,tty,cputime,cmd"
zstyle ':completion:*' rehash true

#Local history for each prompt.
# bindkey "${key[Up]}" up-line-or-local-history
# bindkey "${key[Down]}" down-line-or-local-history

# up-line-or-local-history() {
#     zle set-local-history 1
#     zle up-line-or-history
#     zle set-local-history 0
# }
# zle -N up-line-or-local-history
# down-line-or-local-history() {
#     zle set-local-history 1
#     zle down-line-or-history
#     zle set-local-history 0
# }
# zle -N down-line-or-local-history
#End local history

#other keycode for up arrow "^[[1;5A"
bindkey "^[OA" up-line-or-local-history
bindkey "^[OB" down-line-or-local-history

up-line-or-local-history() {
    zle set-local-history 1
    zle up-line-or-history
    zle set-local-history 0
}
zle -N up-line-or-local-history
down-line-or-local-history() {
    zle set-local-history 1
    zle down-line-or-history
    zle set-local-history 0
}
zle -N down-line-or-local-history
