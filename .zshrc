# .zshrc
# configs and shit

# settings {{{

SAVEHIST=1000000
HISTSIZE=1000000
HISTFILE=~/.zsh_history
PROMPT='%3~ > '
zstyle :compinstall filename "$HOME/.zshrc"
autoload -Uz compinit
compinit
# emacs mode
bindkey -e

# fuck crazy cds
unsetopt autocd
unsetopt cdablevars

# }}}
# plugins {{{

source /usr/share/zsh/plugins/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh
ZSH_HIGHLIGHT_HIGHLIGHTERS=(main brackets pattern cursor)

# }}}
# zsh highlighting {{{

# typeset -A ZSH_HIGHLIGHT_STYLES
# ZSH_HIGHLIGHT_STYLES[unknown-token]='fg=05'

# }}}
# window title {{{

# sets window title
function wname() { echo -en "\033]0;$@\007" };

# Set window title to command just before running it.
function preexec() { printf "\x1b]0;%s\x07" "$1"; }

# Set window title to current working directory after returning from a command.
function precmd() { printf "\x1b]0;%s\x07" "$PWD" }


# }}}
# aliases {{{

# alias powertop="sudo powertop"
alias vim="nvim"
alias dl="aria2c -x 15"
alias ssh="TERM=xterm-256color ssh"
alias rn="react-native"
alias sstart="sudo systemctl start"
alias sstop="sudo systemctl stop"
alias srestart="sudo systemctl restart"
alias ssuspend="systemctl suspend"
alias spotify="spotify --force-device-scale-factor=1.3"
alias ls="ls --color=auto"

# }}}
# exports {{{

export XDG_CONFIG_HOME=$HOME/.config
export EDITOR=nvim
export GOPATH=$HOME/.go
# export NVM_LAZY_LOAD=true
export PATH=$HOME/bin:$HOME/.yarn/bin:$PATH
# pip
export PATH=$HOME/.local/bin:$PATH
export BOOT_HOME=$HOME/.boot
export FZF_DEFAULT_OPTS='
--color fg:#b7bec9,bg:#262729,hl:#5ebaa5,fg+:#b7bec9,bg+:#262729,hl+:#5ebaa5
--color info:#a1bf78,prompt:#a1bf78,pointer:#5ebaa5,marker:#5ebaa5,header:#a1bf78'
# source /usr/share/nvm/init-nvm.sh
# java font fix
export JAVA_HOME=/usr/lib/jvm/default
export JRE_HOME=/usr/lib/jvm/default
export JAVA_FONTS=/usr/share/fonts/TTF
export _JAVA_OPTIONS="-Dswing.aatext=true -Dawt.useSystemAAFontSettings=on"

# }}}
# fzf {{{

[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh
export FZF_ALT_C_COMMAND="fd --type d"
export FZF_CTRL_T_COMMAND="fd --type f"

# }}}
# nvm {{{

# [ -f /usr/share/nvm/init-nvm.sh ] && source /usr/share/nvm/init-nvm.sh
# export NVM_DIR=$HOME/.nvm
# export NVM_LATEST_VERSION="$(ls -1 $NVM_DIR/versions/node | tail -1)"
# export PATH=$NVM_DIR/versions/node/$NVM_LATEST_VERSION/bin:$PATH
# export MANPATH=$NVM_DIR/versions/node/$NVM_LATEST_VERSION/share/man:$MANPATH

# }}}
# asdf {{{

. $HOME/.asdf/asdf.sh
. $HOME/.asdf/completions/asdf.bash

# }}}
