#!/bin/sh

basepath=$(cd $(dirname $0);pwd)

# symlink and copy dotfiles into home dir
files=.*
for file in $files
do
    if [ $file != "." -a $file != ".." -a $file != ".git" -a $file != ".gitconfig-private" -a $file != ".gitconfig-office" ] ; then
        ln -sf $basepath/$file ~
    fi
    if [ $file = ".gitconfig-private" -o $file = ".gitconfig-office" ] ; then
        cp $basepath/$file ~
    fi
done
