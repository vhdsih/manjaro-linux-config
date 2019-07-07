#!/bin/bash

IN_PATH=`pwd`
SCRIPTS=$(cd "$(dirname "$0")"; pwd)
LOG=${IN_PATH}/setup.log
DOTFILES=${SCRIPTS}/../dotfiles

ZSHRC_FROM=${DOTFILES}/zsh/.zshrc
ZSHRC_TO=${HOME}/.zshrc

VIMRC_FROM=${DOTFILES}/vim/.vimrc
VIMRC_TO=${HOME}/.vimrc

VIM_COLOR_FROM=${DOTFILES}/vim/colors
VIM_COLOR_TO=${HOME}/.vim/colors

YCM_FROM=${DOTFILES}/vim/.ycm_extra_conf.py
YCM_TO=${HOME}/.ycm_extra_conf.py

TERMINATOR_FROM=${DOTFILES}/terminator
TERMINATOR_TO=${HOME}/.config/terminator

ROFI_FROM=${DOTFILES}/rofi
ROFI_TO=$HOME/.config/rofi

POLYBAR_FROM=${DOTFILES}/polybar
POLYBAR_TO=${HOME}/.config/polybar

PIP_FROM=${DOTFILES}/pip
PIP_TO=${HOME}/.pip

I3WM_FROM=${DOTFILES}/i3wm
I3WM_TO=${HOME}/.i3

PACMAN_FROM=${DOTFILES}/etc/pacman.conf
PACMAN_TO=/etc/pacman.conf

APP_BASE=${SCRIPTS}/res/base.txt
APP_I3_BASE=${SCRIPTS}/res/i3base.txt
APP_EXTEND=${SCRIPTS}/res/extend.txt

BACKUP_TO=${SCRIPTS}/../tmp/bak

