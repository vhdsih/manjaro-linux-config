#!/bin/bash

exec_location=`pwd`
relative_location=`dirname $0`

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
    wget http://download.tuxfamily.org/gericom/gericom.asc
    sudo pacman-key --add gericom.asc
    sudo pacman -Syyu
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
    git clone https://github.com/VundleVim/Vundle.vim.git ~/.vim/bundle/Vundle.vim
    cp -r $relative_location/res/vim/colors ~/.vim/
    vim +PluginInstall +qall
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
  --height="400" \
  --width="800" \
  --title="manjaro linux tools" \
  --text="请勾选需要的动作" \
  --column="选择" --column="编码"	--column="操作描述" \
  FALSE "1" "配置pacman - 执行pacman-mirrors并且更换pacman.conf"  \
  FALSE "2" "更新系统并安装gericom库的秘钥（用于安装papirus图标和arc-kde主题）" \
  FALSE "3" "安装需要的软件" \
  FALSE "4" "配置vim" \
  FALSE "5" "配置zsh" \
  FALSE "6" "安装windows字体 - 从github上clone，需要大量时间" \
  --separator=" ");

if [[ $GUI ]]
then

  if [[ $GUI == *"1"* ]]
  then
    clear
  	echo "配置pacman"
    config_etc
    config_mirrors
    echo 'wait 3s please...'
    sleep 3

  fi

   if [[ $GUI == *"2"* ]]
  then
    clear
  	echo "正在更新系统"
    update_system
    echo 'wait 3s please...'
    sleep 3

  fi

   if [[ $GUI == *"3"* ]]
  then
    clear
  	echo "安装软件"
    install_software
    echo 'wait 3s please...'
    sleep 3
  fi

   if [[ $GUI == *"4"* ]]
  then
    clear
  	echo "配置vim"
    config_vim
    echo 'wait 3s please...'
    sleep 3

  fi

   if [[ $GUI == *"5"* ]]
  then
    clear
  	echo "配置zsh"
    config_zsh
    echo 'wait 3s please...'
    sleep 3

  fi

   if [[ $GUI == *"6"* ]]
  then
    clear
  	echo "正在更新系统"
  	git clone https://github.com/dongchangzhang/fonts
    sudo chmod a+x fonts/setup.sh
    sudo ./fonts/setup.sh
    echo 'wait 3s please...'
    sleep3

  fi

  # 完成通知
  clear
  notify-send -i utilities-terminal manjaro "配置完成，部分配置重启后生效。"


fi
