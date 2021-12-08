# .zshrc

# settings {{{
HISTFILE=~/.histfile
HISTSIZE=100000
SAVEHIST=100000
bindkey -e

# save history immediately
setopt sharehistory
setopt incappendhistory

PROMPT='%3~ > '
zstyle :compinstall filename "$HOME/.zshrc"
autoload -Uz compinit
compinit
# }}}
# autocomplete {{{
source /usr/share/zsh/plugins/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh
ZSH_HIGHLIGHT_HIGHLIGHTERS=(main brackets pattern cursor)

autoload -U +X bashcompinit && bashcompinit
complete -o nospace -C /usr/bin/terraform terraform
# }}}
# window fns {{{
# sets window title
function wname() { echo -en "\033]0;$@\007" };

# Set window title to command just before running it.
function preexec() { printf "\x1b]0;%s\x07" "$1"; }

# Set window title to current working directory after returning from a command.
function precmd() { printf "\x1b]0;%s\x07" "$PWD" }
# }}}
# aliases {{{
alias vim="nvim"
alias dl="aria2c -x 15"
alias ssh="TERM=xterm-256color ssh"
alias rn="react-native"
alias sstart="sudo systemctl start"
alias sstop="sudo systemctl stop"
alias srestart="sudo systemctl restart"
alias ssuspend="systemctl suspend"
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
export FZF_DEFAULT_OPTS='--color fg:#b7bec9,bg:#262729,hl:#5ebaa5,fg+:#b7bec9,bg+:#262729,hl+:#5ebaa5 --color info:#a1bf78,prompt:#a1bf78,pointer:#5ebaa5,marker:#5ebaa5,header:#a1bf78'
# source /usr/share/nvm/init-nvm.sh
# java font fix
export JAVA_HOME=/usr/lib/jvm/default
export JRE_HOME=/usr/lib/jvm/default
export JAVA_FONTS=/usr/share/fonts/TTF
export _JAVA_OPTIONS="-Dswing.aatext=true -Dawt.useSystemAAFontSettings=on"

# [ -f ~/.fzf.zsh ] && source ~/.fzf.zsh
source /usr/share/fzf/key-bindings.zsh
source /usr/share/fzf/completion.zsh
export FZF_ALT_C_COMMAND="fd --type d"
export FZF_CTRL_T_COMMAND="fd --type f"
# }}}
