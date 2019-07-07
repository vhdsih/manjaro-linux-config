#!/bin/bash

# created by dongchangzhang/vhdsih
# last update: 2019.07


FUNCS=$(cd "$(dirname "$0")"; pwd)
source ${FUNCS}/funcs.sh

clear

GUI=$(zenity --list --checklist \
  --height="600" \
  --width="1000" \
  --title="Manjaro Linux Config Tool" \
  --text="Select Your Operations Please:" \
  --column="Y/N" --column="Code"	--column="Description" \
  FALSE "A" "! ARE YOU RANNING THE I3WM ON YOUR COMPUTER?" \
  FALSE "B" "! CHOISE APPLICATIONS TO BE INSTALLED BY VIM?" \
  TRUE  "C" "! BACKUP YOUR DOTFILES? OR I WILL DELETE THEM!" \
  TRUE  "1" "Configure Pacman (add archlinuxcn and run pacman-mirror)"  \
  TRUE  "2" "Update Your System" \
  FALSE "3" "Install Softwares (res/app/pacman and res/app/yaourt" \
  FALSE "4" "Configure Vim (vimrc, vundle, etc" \
  FALSE "5" "Configure Zsh (install oh-my-zsh)" \
  FALSE "6" "Install Fonts of Windows (clone from dongchangzhang's github)" \
  FALSE "7" "Generate SSH-KEYRING (for github or other applications)" \
  FALSE "8" "Configure Terminator" \
  FALSE "9" "Install I3wm If You Don't Have It In Your System" \
  --separator=" ");

if [[ $GUI ]]
then
  if [[ $GUI == *"A"* ]]
  then
    clear
  	echo "Your wm is i3wm, some applications for i3wm will be installed and some configuration for i3wm will be applied"
    touch ${IN_PATH}/i3wm.flag
    config_i3
    echo 'wait 3s please...'
    sleep i3
  fi

  if [[ $GUI == *"B"* ]]
  then
    clear

    echo 'wait 3s to edit applications to be installed by vim'
    sleep 3
    vim ${APP_BASE}
  fi

  if [[ $GUI == *"C"* ]]
  then
    clear
  	echo "backup"
    backup_dotfiles
    echo 'wait 3s please...'
    sleep 3
  fi

  if [[ $GUI == *"1"* ]]
  then
    clear
  	echo "configure pacman"
    config_etc
    config_mirrors
    echo 'wait 3s please...'
    sleep 3
  fi

   if [[ $GUI == *"2"* ]]
  then
    clear
  	echo "Update System"
    update_system
    echo 'wait 3s please...'
    sleep 3
  fi

   if [[ $GUI == *"3"* ]]
  then
    clear
  	echo "Install Applications"
    install_software ${APP_BASE}
    echo 'wait 3s please...'
    sleep 3
  fi

   if [[ $GUI == *"4"* ]]
  then
    clear
  	echo "Configure Vim"
    config_vim
    echo 'wait 3s please...'
    sleep 3
  fi

   if [[ $GUI == *"5"* ]]
  then
    clear
  	echo "Configure Zsh"
    config_zsh
    echo 'wait 3s please...'
    sleep 3
  fi

   if [[ $GUI == *"6"* ]]
  then
    clear
  	echo "Install Windows Fonts"
  	config_fonts
    echo 'wait 3s please...'
    sleep 3
  fi

  if [[ $GUI == *"7"* ]]
  then
    clear
  	echo "Configure SSH-KEY"
  	config_ssh
    echo 'wait 3s please...'
    sleep 3
  fi

  if [[ $GUI == *"8"* ]]
  then
    clear
  	echo "Configure SSH-KEY"
  	config_terminator
    echo 'wait 3s please...'
    sleep 3
  fi

  if [[ $GUI == *"9"* ]]
  then
    clear
  	echo "Installing I3wm..."
    install_i3
    echo 'wait 3s please...'
    sleep 3
  fi

  if [[ $GUI == *"A"* ]]
  then
    clear
    rm -rf ${IN_PATH}/i3wm.flag
  fi
  if [[ $GUI == *"C"* ]]
  then
    clear
    rm -rf ${IN_PATH}/edit.flag
  fi

  clear
  echo "done!!!"
  notify-send -i manjaro "configuration of manjaro is done!"
fi
