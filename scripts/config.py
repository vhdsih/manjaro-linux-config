import os
import sys
import logging

# path
BASE = os.path.dirname(os.path.abspath(__file__))

ETC = '/etc'
HOME = '$HOME'

DATA = 'data'
DOTFILES = 'dotfiles'

EDITORS = ['vim', 'vi', 'gedit', 'kate', 'nano', 'mousepad', 'haha']

# applications
TOOL = 'pacman'
AUR_TOOL = 'yay'
UARGS = ['-Syyu', '--noconfirm']
IARGS = ['-S', '--needed', '--noconfirm']
REL_APP_FILES = ['base.txt', 'extend.txt']
ABS_APP_FILES = [os.path.join(BASE, DATA, f) for f in REL_APP_FILES]

# etc files
PACMAN_FILES = ['pacman.conf']
PROXYCHAINS_FILES = ['proxychains.conf']

# dotfiles
I3_FILES = ['config', 'polybar']
VIM_FILES = ['.vimrc', '.vim', '.vim_user']
ZSH_FILES = ['.zshrc', '.oh-my-zsh', '.zshrc_user']

# constants
LOGFORMAT = '%(levelname)s - %(message)s'
logging.basicConfig(level=logging.INFO, format=LOGFORMAT)


if __name__ == '__main__':
    print(APPLICATIONS)
