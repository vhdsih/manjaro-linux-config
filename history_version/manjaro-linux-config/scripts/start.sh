#!/bin/bash

# created by dongchangzhang

# 执行该脚本时所在路径
exec_location=`pwd`
# 脚本所在的路径
relative_location=$(cd "$(dirname "$0")"; pwd)
# log file
LOG=$relative_location/../log

# load functions
. $relative_location/utils.sh

# install software
install_software() {
    clear
    print_log 'install software...' $LOG
    chmod +x $relative_location/app.sh
    $relative_location/app.sh
    print_log "done" $LOG
}

# config etc files
config_etc() {
    clear
    print_log "config etc..." $LOG
    chmod +x $relative_location/etc_conf_apply.sh
    $relative_location/etc_conf_apply.sh
    print_log "done" $LOG
}

# config ssh for github
config_ssh() {
    clear
    print_log "config ssh for github..." $LOG
    chmod +x $relative_location/ssh.sh
    $relative_location/ssh.sh
    print_log "done" $LOG
}

# config mirrors list
config_mirrors() {
    clear
    print_log "config mirrors list" $LOG
    sudo pacman-mirrors -c China
    print_log "done" $LOG

}
# config vim
config_vim() {
    clear
    print_log "do config for vim..." $LOG
    # vim had been installed?
    check_software vim 'pacman -S --noconfirm'
    # clang had been installed?
    check_software clang 'pacman -S --noconfirm'
    # cmake had been installed?
    check_software cmake 'pacman -S --noconfirm'
    # powerline-fonts
    check_software powerline-fonts 'pacman -S --noconfirm'
    # backup
    backup_file $HOME/.vimrc
    backup_file $HOME/.vim
    # link
    link $relative_location/../res/vim/.vimrc $HOME/
    link $relative_location/../res/vim/.ycm_extra_conf.py $HOME/
    git clone https://github.com/VundleVim/Vundle.vim.git ~/.vim/bundle/Vundle.vim
    link $relative_location/../res/vim/colors $HOME/.vim/colors
    vim +PluginInstall +qall
    $HOME/.vim/bundle/YouCompleteMe/install.sh  --clang-completer --system-libclang
    print_log "done" $LOG
}

# config zsh
config_zsh() {
    clear
    print_log "do config for zsh..." $LOG
    check_software zsh 'pacman -S --noconfirm'
    check_software autojump 'pacman -S --noconfirm'
    check_software powerline-fonts 'pacman -S --noconfirm'
    backup_file $HOME/.zshrc
    # oh my zsh
    wget https://github.com/robbyrussell/oh-my-zsh/raw/master/tools/install.sh -O - | sh
    link $relative_location/../res/zsh/.zshrc $HOME/.zshrc
    chsh -s /bin/zsh

    if [ $? = 0 ]
    then print_log "chsh successfully" $LOG
    else
        print_log "error when chsh" $LOG
    fi
    print_log "done" $LOG
}

# i3wm
config_i3() {
    print_log "do for i3wm" $LOG
    backup_file $HOME/.i3
    backup_file $HOME/.config/polybar
    
    link $relative_location/../res/i3wm $HOME/.i3
    link $relative_location/../res/polybar $HOME/.config/polybar
    print_log "done" $LOG
}

# install i3wm
install_i3() {
    print_log "install i3wm" $LOG
    # for .i3
    backup_file $HOME/.config/i3
    # for polybar
    backup_file $HOME/.config/polybar
    $relative_location/install-i3wm.sh
    link $relative_location/../res/i3wm $HOME/.config/i3
    link $relative_location/../res/polybar $HOME/.config/polybar
    # fonts for polybar
    sudo cp -r $relative_location/../res/fonts /usr/share/fonts/polybar-fonts
    cd /usr/share/fonts/polybar-fonts
    sudo chmod 644 *
    sudo mkfontscale
    sudo mkfontdir
    sudo fc-cache -fv
    cd $exec_location
    print_log "done" $LOG
}

config_terminator() {
  print_log "do for terminator" $LOG
  backup_file $HOME/.config/terminator
  link $relative_location/../res/terminator $HOME/.config/terminator
  print_log "done" $LOG
  
}

config_fonts() {
  print_log "do for fonts" $LOG
  now=`pwd`
  git clone https://github.com/dongchangzhang/fonts
  sudo cp -r fonts/wf /usr/share/fonts/
  cd /usr/share/fonts/wf
  pwd 
  sleep 10
  sudo chmod 644 *
  sudo mkfontscale
  sudo mkfontdir
  sudo fc-cache -fv
  cd $now
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
  TRUE "1" "Configure Your Pacman (add archlinuxcn and run pacman-mirror)"  \
  TRUE "2" "Update Your System" \
  FALSE "3" "Install Softwares (res/app/pacman and res/app/yaourt" \
  FALSE "4" "Configure Vim (my vimrc, vundle, youcompleteme, etc..." \
  FALSE "5" "Configure Zsh (install oh-my-zsh and a new zshrc file)" \
  FALSE "6" "Install Fonts of Windows (clone from my github)" \
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
    touch $relative_location/../res/app/i3wm.flag
    touch $relative_location/../i3wm.flag
    config_i3
    echo 'wait 3s please...'
    sleep i3
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
    rm -rf $relative_location/../res/app/i3wm.flag
    rm -rf $relative_location/../i3wm.flag
    echo "Configure i3wm"
  fi

  clear
  echo "done!!!"
  notify-send -i manjaro "configuration of manjaro is done!"
fi
