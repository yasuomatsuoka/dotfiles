# LANG
export LANG=ja_JP.UTF-8

# 色
autoload -U colors; colors

# プロンプトが表示されるたびにプロンプト文字列を評価、置換する
setopt prompt_subst

# enter で ls と git status
function do_enter() {
    if [ -n "$BUFFER" ]; then
        zle accept-line
        return 0
    fi
    echo
    ls
    # おすすめ
    # ls_abbrev
    if [ "$(git rev-parse --is-inside-work-tree 2> /dev/null)" = 'true' ]; then
        echo
        echo -e "\e[0;33m--- git status ---\e[0m"
        git status -sb
    fi
    zle reset-prompt
    return 0
}
zle -N do_enter
bindkey '^m' do_enter

# 大文字・小文字を区別しないで補完出来るようにするが、大文字を入力した場合は区別する
zstyle ':completion:*' matcher-list 'm:{a-z}={A-Z}'

# ファイル名だけで展開
function extract() {
  case $1 in
    *.tar.gz|*.tgz) tar xzvf $1;;
    *.tar.xz) tar Jxvf $1;;
    *.zip) unzip $1;;
    *.lzh) lha e $1;;
    *.tar.bz2|*.tbz) tar xjvf $1;;
    *.tar.Z) tar zxvf $1;;
    *.gz) gzip -dc $1;;
    *.bz2) bzip2 -dc $1;;
    *.Z) uncompress $1;;
    *.tar) tar xvf $1;;
    *.arj) unarj $1;;
  esac
}
alias -s {gz,tgz,zip,lzh,bz2,tbz,Z,tar,arj,xz}=extract

# ディレクトリ名でcd
setopt auto_cd

# cd -[tab] で補完
setopt auto_pushd

# command補正
setopt correct

# 補完を候補を小さく
setopt list_packed

# パス補完時にスラッシュをつける
setopt noautoremoveslash

# リストを出し終わったあとにビープ音を鳴らさない
setopt nolistbeep

# emacsっぽいkeybind
bindkey -e

# ヒストリー関連
autoload history-search-end
zle -N history-beginning-search-backward-end history-search-end
zle -N history-beginning-search-forward-end history-search-end
bindkey "^p" history-beginning-search-backward-end
bindkey "^n" history-beginning-search-forward-end
bindkey "\\ep" history-beginning-search-backward-end
bindkey "\\en" history-beginning-search-forward-end

HISTFILE=~/.zsh_history
HISTSIZE=10000
SAVEHIST=10000
setopt hist_ignore_dups # ignore duplication command history list
setopt share_history # share command history data

# zshの補完を強化
# https://github.com/zsh-users/zsh-completions
fpath=(/usr/local/share/zsh-completions $fpath)

autoload -Uz compinit
compinit -u

# alias でも補完が効くようにする
setopt complete_aliases

# alias
alias where="command -v"
alias j="jobs -l"
alias la="ls -a"
alias ll="ls -l"
alias du="du -h"
alias df="df -h"
alias su="su -l"
alias rm="rm -i"
alias mysqlstart="mysql.server start"
alias mysqlstop="mysql.server stop"
alias svn="/usr/local/bin/svn"

case "${OSTYPE}" in
freebsd*|darwin*)
  alias ls="ls -G -w -F"
  alias vi='env LANG=ja_JP.UTF-8 /Applications/MacVim.app/Contents/MacOS/Vim "$@"'
  alias vim='env LANG=ja_JP.UTF-8 /Applications/MacVim.app/Contents/MacOS/Vim "$@"'
  ;;
linux*)
  alias ls="ls --color -F"
  ;;
esac

alias docker-login='(){ docker exec -it $1 bash -lc "su - $2" }'

# cd をしたときにlsを実行する
chpwd() { ls }

# terminal 設定
# 見直しの必要あり
case "${TERM}" in
screen)
    TERM=xterm
    ;;
esac


# load zgen
source "${HOME}/.zgen/zgen.zsh"

# if the init scipt doesn't exist
if ! zgen saved; then
    echo "Creating a zgen save"

    zgen oh-my-zsh

    # plugins
    zgen oh-my-zsh plugins/git
    zgen oh-my-zsh plugins/command-not-found

    zgen load zsh-users/zsh-syntax-highlighting
    zgen load zsh-users/zsh-completions src

    # theme
    zgen oh-my-zsh themes/miloshadzic

    # save all to init script
    zgen save
fi

# 分割した設定ファイルの読み込む
[ -f ~/.zsh/mac ] && source ~/.zsh/mac
[ -f ~/.zsh/tmux ] && source ~/.zsh/tmux
[ -f ~/.zsh/ghq ] && source ~/.zsh/ghq
[ -f ~/.zsh/mine ] && source ~/.zsh/mine
