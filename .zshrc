#android
#export PATH=~/android-sdk-mac/tools:~/android-sdk-mac/platform-tools:/usr/local/bin:/opt/local/bin:/opt/local/sbin/:$PATH

#python
#export WORKON_HOME=$HOME/.virtualenvs
#source /usr/local/bin/virtualenvwrapper.sh 

#export PATH=/usr/local/bin:/opt/local/bin:/opt/local/sbin/:$PATH
#export MANPATH=/opt/local/man:$MANPATH

## Environment variable configuration
#
# LANG
#
export LANG=ja_JP.UTF-8

## Default shell configuration
#
# set prompt
#
autoload colors
colors
case ${UID} in
0)
  PROMPT="%B%{${fg[red]}%}%/#%{${reset_color}%}%b "
  PROMPT2="%B%{${fg[red]}%}%_#%{${reset_color}%}%b "
  SPROMPT="%B%{${fg[red]}%}%r is correct? [n,y,a,e]:%{${reset_color}%}%b "
  [ -n "${REMOTEHOST}${SSH_CONNECTION}" ] &&
    PROMPT="%{${fg[white]}%}${HOST%%.*} ${PROMPT}"
  ;;
*)
  #PROMPT="%{${fg[red]}%}%/%%%{${reset_color}%} "
  #PROMPT="%m:%n%% "
  PROMPT="%m%% " 
   
  #PROMPT2="%{${fg[red]}%}%_%%%{${reset_color}%} "
  RPROMPT="[%~]"
  SPROMPT="%r is correct? [n,y,a,e]:%{${reset_color}%} "
  [ -n "${REMOTEHOST}${SSH_CONNECTION}" ] &&
    PROMPT="%{${fg[white]}%}${HOST%%.*} ${PROMPT}"
  ;;
esac

#PROMPT="%m:%n%% "
#RPROMPT="[%~]"
#SPROMPT="correct: %R -> %r ? " 

# auto change directory
#
setopt auto_cd

# auto directory pushd that you can get dirs list by cd -[tab]
#
setopt auto_pushd

# command correct edition before each completion attempt
#
setopt correct

# compacked complete list display
#
setopt list_packed

# no remove postfix slash of command line
#
setopt noautoremoveslash

# no beep sound when complete list displayed
#
setopt nolistbeep

## Keybind configuration
#
# emacs like keybind (e.x. Ctrl-a goes to head of a line and Ctrl-e goes
# to end of it)
#
bindkey -e

# historical backward/forward search with linehead string binded to ^P/^N
#
autoload history-search-end
zle -N history-beginning-search-backward-end history-search-end
zle -N history-beginning-search-forward-end history-search-end
bindkey "^p" history-beginning-search-backward-end
bindkey "^n" history-beginning-search-forward-end
bindkey "\\ep" history-beginning-search-backward-end
bindkey "\\en" history-beginning-search-forward-end

## Command history configuration
#
HISTFILE=~/.zsh_history
HISTSIZE=10000
SAVEHIST=10000
setopt hist_ignore_dups # ignore duplication command history list
setopt share_history # share command history data

## Completion configuration
#
autoload -U compinit
compinit

## Alias configuration
#
# expand aliases before completing
#
setopt complete_aliases # aliased ls needs if file/dir completions work

# cd をしたときにlsを実行する
# 
chpwd() { ls }

# aliases
#
alias where="command -v"
alias j="jobs -l"
alias la="ls -a"
alias ll="ls -l"
alias du="du -h"
alias df="df -h"
alias su="su -l"
alias rm="rm -i"
#alias mysql="/Applications/MAMP/Library/bin/mysql"
#alias myssh="ssh ysomtok.mydns.jp"
alias mysqlstart="mysql.server start"
alias mysqlstop="mysql.server stop"

case "${OSTYPE}" in
freebsd*|darwin*)
  alias ls="ls -G -w -F"
  function vim() {command /Applications/MacVim.app/Contents/MacOS/MacVim --remote-tab-silent $@ & }
  ;;
linux*)
  alias ls="ls --color -F"
  ;;
esac

## terminal configuration
#
case "${TERM}" in
screen)
    TERM=xterm
    ;;
esac


unset LSCOLORS
case "${TERM}" in
xterm)
  export TERM=xterm-color
  ;;
kterm)
  export TERM=kterm-color
  # set BackSpace control character
  stty erase
  ;;
cons25)
  unset LANG
  export LSCOLORS=HxFxCxdxBxegedabagacad
  export LS_COLORS='di=39:ln=01;35:so=01;32:ex=01;31:bd=46;34:cd=43;34:su=41;30:sg=46;30:tw=42;30:ow=43;30'
  zstyle ':completion:*' list-colors \
    'di=;37;1' 'ln=;35;1' 'so=;32;1' 'ex=31;1' 'bd=46;34' 'cd=43;34'
  ;;
esac

# set terminal title including current directory
#
case "${TERM}" in
kterm*|xterm*)
  precmd() {
    echo -ne "\033]0;${USER}@${HOST%%.*}:${PWD}\007"
  }
  export LSCOLORS=Hxfxcxdxbxegedabagacad #mac bsd
  export LS_COLORS='di=39:ln=35:so=32:pi=33:ex=31:bd=46;34:cd=43;34:su=41;30:sg=46;30:tw=42;30:ow=43;30'
  zstyle ':completion:*' list-colors \
    'di=37;1' 'ln=35' 'so=32' 'ex=31' 'bd=46;34' 'cd=43;34' #tab 保管時の挙動
  ;;
esac

preexec () {
  [ ${STY} ] && echo -ne "\ek${1%% *}\e\\"  
}

## load user .zshrc configuration file
#
[ -f ~/.zshrc.mine ] && source ~/.zshrc.mine
