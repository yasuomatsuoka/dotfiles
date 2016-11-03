## 最初に
自動化したいけど、時間がないのであとでやる

## 導入備忘録
- このリポジトリを git clone する
- homebrew をインストールする
```
/usr/bin/ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"
```

- tmux をインストールする
```
$ brew install tmux
```

- macvim をインストールする
    - https://github.com/splhack/macvim-kaoriya

- login sh を zsh にする

```
$ brew install zsh
$ sudo sh -c "echo '/usr/local/bin/zsh' >> /etc/shells"
Password:
$ cat /etc/shells
1:[shells]
# List of acceptable shells for chpass(1).
# Ftpd will not allow users to connect who are not using
# one of these shells.

/bin/bash
/bin/csh
/bin/ksh
/bin/sh
/bin/tcsh
/bin/zsh
/usr/local/bin/zsh

$ chsh -s /usr/local/bin/zsh
```

- .zsh と gitconfig にシンボリックリンクして terminal をリスタート
```
$ ln -s /Users/yasuo/dotfiles/zsh /Users/yasuo/.zsh
$ ln -s /Users/yasuo/dotfiles/zshrc /Users/yasuo/.zshrc
$ ln -s /Users/yasuo/dotfiles/gitconfig /Users/yasuo/.gitconfig
```

- ghq/Go スタイルの設定をして、dotfiles を ghq で管理する
    - http://qiita.com/itkrt2y/items/0671d1f48e66f21241e2 を参考
```
$ brew install ghq
$ brew install peco
$ brew install hub
$ ghq get git@github.com:yasuomatsuoka/dotfiles.git

```
- zgen をインストール
    - https://github.com/tarjoilija/zgen#example-zshrc を参考
```
$ cd
$ git clone https://github.com/tarjoilija/zgen.git .zgen
```

- 他の dotfiles のシンボリックリンクを作成してリスタート
```
$ ln -s /Users/yasuo/src/github.com/yasuomatsuoka/dotfiles/zshrc /Users/yasuo/.zshrc
$ ln -s /Users/yasuo/src/github.com/yasuomatsuoka/dotfiles/zsh /Users/yasuo/.zsh
$ ln -s /Users/yasuo/src/github.com/yasuomatsuoka/dotfiles/vimrc /Users/yasuo/.vimrc
$ ln -s /Users/yasuo/src/github.com/yasuomatsuoka/dotfiles/vimrc.mac /Users/yasuo/.vimrc.mac
$ ln -s /Users/yasuo/src/github.com/yasuomatsuoka/dotfiles/gvimrc /Users/yasuo/.gvimrc
$ ln -s /Users/yasuo/src/github.com/yasuomatsuoka/dotfiles/tmxu.conf /Users/yasuo/.tmux.conf
$ ln -s /Users/yasuo/dotfiles/gitignore /Users/yasuo/.gitignore
$ exit
```
