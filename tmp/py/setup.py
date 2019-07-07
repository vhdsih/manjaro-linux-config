#!/usr/bin/python3

import os
import sys
import logging
import argparse
from config import LOGFORMAT

def init():
    logging.basicConfig(level=logging.INFO, format=LOGFORMAT)

def set_parser():
    description = 'Manjaro Linux Config Tool'
    parser = argparse.ArgumentParser(description=description)

    help_info = 'install applications'
    parser.add_argument('-a', '--enable-app', 
            action='store_true', default=False, help=help_info)

    help_info = 'install fonts of windows'
    parser.add_argument('-f', '--enable-fonts', 
            action='store_true', default=False, help=help_info)

    help_info = 'config git and ssh'
    parser.add_argument('-gs', '--enable-git-ssh', 
            action='store_true', default=False, help=help_info)

    help_info = 'use gui to config system, if not set it, use cli'
    parser.add_argument('-g', '--enable-gui', 
            action='store_true', default=False, help=help_info)

    help_info = 'config i3wm'
    parser.add_argument('-i2', '--enable-i3wm', 
            action='store_true', default=False, help=help_info)

    help_info = 'install i3wm'
    parser.add_argument('-i1', '--enable-i3wm_install', 
            action='store_true', default=False, help=help_info)

    help_info = 'write config log into file'
    parser.add_argument('-l', '--enable-log', 
            action='store_true', default=False, help=help_info)

    help_info = 'config pacman: add aur and config mirrors'
    parser.add_argument('-p', '--enable-pacman', 
            action='store_true', default=False, help=help_info)

    help_info = 'config terminator'
    parser.add_argument('-t', '--enable-terminator', 
            action='store_true', default=False, help=help_info)

    help_info = 'config vim'
    parser.add_argument('-v', '--enable-vim', 
            action='store_true', default=False, help=help_info)

    help_info = 'config zsh'
    parser.add_argument('-z', '--enable-zsh',
            action='store_true', default=False, help=help_info)

    return parser


if __name__ == '__main__':
    init()
    parser = set_parser()
    args = parser.parse_args()
    opts = vars(args)




