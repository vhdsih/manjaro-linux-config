#!/bin/bash

exec_location=`pwd`
relative_location=`dirname $0`

is_i3wm=0
do_link=0
LOG=$relative_location/log

# print log
print_log() {
    echo -e  "\033[0;31;1m==> $1\033[0m"
    echo $1 >> $LOG
}
# check software
check_software() {
    echo "-> checking app $1..."
    which $1 >> /dev/null
    if [ $? = 0 ]; then
        echo "-> $1 had been installed"
    else
        echo "-> $1 has not been installed, installing now"
        sudo $2 $1
    fi
}
# update system
update_system() {
    clear
    print_log "update system..."
    check_software wget "pacman -S --noconfirm"
    sudo pacman -Syyu --noconfirm
    print_log "done"
}
# install software
install_software() {
    clear
    print_log 'install software...'
    chmod +x $relative_location/res/app/install.sh
    $relative_location/res/app/install.sh
    print_log "done"
}
# config etc files
config_etc() {
    clear
    print_log "config etc..."
    chmod +x $relative_location/res/etc/etc_conf_apply.sh
    $relative_location/res/etc/etc_conf_apply.sh
    print_log "done"

}
# config ssh for github
config_ssh() {
    clear
    print_log "config ssh for github..."
    chmod +x $relative_location/res/ssh/ssh.sh
    $relative_location/res/ssh/ssh.sh
    print_log "done"

}
# config mirrors list
config_mirrors() {
    clear
    print_log "config mirrors list"
    sudo pacman-mirrors -g -c China
    print_log "done"

}
# config vim
config_vim() {
    clear
    print_log "do config for vim..."
    # vim had been installed?
    check_software vim 'pacman -S --noconfirm'
    # clang had been installed?
    check_software clang 'pacman -S --noconfirm'
    # cmake had been installed?
    check_software cmake 'pacman -S --noconfirm'
    # powerline-fonts
    check_software powerline-fonts 'pacman -S --noconfirm'
    # for .vimrc
    if [ -f "$HOME/.vimrc" ]; then
        print_log "mv $HOME/.vimrc to $HOME/.vimrc.bak"
        mv $HOME/.vimrc $HOME/.vimrc.bak
    fi
    # for .vim
    if [  -d "$HOME/.vim" ]; then
        print_log "mv $HOME/.vim to $HOME/.vim.bak"
        mv $HOME/.vim $HOME/.vim.bak
    fi
    # do config
    cp $relative_location/res/vim/.vimrc $HOME/
    cp $relative_location/res/vim/.ycm_extra_conf.py $HOME/
    git clone https://github.com/VundleVim/Vundle.vim.git ~/.vim/bundle/Vundle.vim
    cp -r $relative_location/res/vim/colors ~/.vim/
    vim +PluginInstall +qall
    $HOME/.vim/bundle/YouCompleteMe/install.sh  --clang-completer --system-libclang
    print_log "done"
}
# config zsh
config_zsh() {
    clear
    print_log "do config for zsh..."
    check_software zsh 'pacman -S --noconfirm'
    check_software autojump 'pacman -S --noconfirm'
    check_software powerline-fonts 'pacman -S --noconfirm'
    # for .zshrc
    if [ -f "$HOME/.zshrc" ]; then
        print_log "mv $HOME/.zshrc to $HOME/.zshrc.bak"
        mv $HOME/.zshrc $HOME/.zshrc.bak
    fi
    # oh my zsh
    wget https://github.com/robbyrussell/oh-my-zsh/raw/master/tools/install.sh -O - | sh
    cp $relative_location/res/zsh/.zshrc ~/.zshrc
    chsh -s /bin/zsh

    if [ $? = 0 ]
    then print_log "chsh successfully"
    else
        print_log "error when chsh"
    fi
    print_log "done"
}

# vscode
config_vscode() {
    print_log "do for vscode"
    mkdir -p $HOME/.config/Code/User/
    cp $relative_location/res/code/* $HOME/.config/Code/User/
    print_log "done"
}
# i3wm
config_i3() {
    print_log "do for i3wm"
    chmod +x $relative_location/manjaro_i3_conf_apply.sh
    $relative_location/manjaro_i3_conf_apply.sh

    
    echo "done"
}


echo > $LOG
clear

GUI=$(zenity --list --checklist \
  --height="500" \
  --width="1000" \
  --title="Manjaro Linux Tool" \
  --text="Select your operation." \
  --column="Y/N" --column="Code"	--column="description" \
  FALSE "A" "## Are You Ranning the i3wm On your computer? ##" \
  TRUE "B" "## Use Symbolic link ##" \
  TRUE "1" "Configure Your Pacman (add archlinuxcn and run pacman-mirror)"  \
  TRUE "2" "Update Your System" \
  FALSE "3" "Install Softwares (res/app/pacman and res/app/yaourt" \
  FALSE "4" "Configure Vim (my vimrc, vundle, youcompleteme, etc..." \
  FALSE "5" "Configure Zsh (install oh-my-zsh and a new zshrc file)" \
  FALSE "6" "Install Fonts of Windows (clone from my github)" \
  FALSE "7" "Generate SSH-KEYRING (for github or other applications)" \
  --separator=" ");

if [[ $GUI ]]
then
  if [[ $GUI == *"A"* ]]
  then
    clear
  	echo "Your wm is i3wm, some applications for i3wm will be installed and some configuration for i3wm will be applied"
    touch $relative_location/res/app/i3wm.flag
    touch $relative_location/i3wm.flag
    echo 'wait 3s please...'
    sleep 3
  fi

  if [[ $GUI == *"B"* ]]
  then
    clear
  	echo "Link Files..."
    do_link=1
    
      
    echo 'wait 3s please...'
    sleep 3
  fi

  if [[ $GUI == *"1"* ]]
  then
    clear
  	echo "Configure Pacman"
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
    install_software
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
  	git clone https://github.com/dongchangzhang/fonts
    chmod a+x fonts/setup.sh
    ./fonts/setup.sh
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

  if [[ $GUI == *"A"* ]]
  then
    clear
    rm -rf $relative_location/res/app/i3wm.flag
    rm -rf $relative_location/i3wm.flag
    echo "Configure i3wm"
    config_i3
  fi
  clear
  echo "done!!!"
  notify-send -i utilities-terminal manjaro "FINISHED!!!"
fi
