#!/bin/bash

# -------------------------------------------------------------------

# created by dongchangzhang == vhdsih
# last update: 2019.07

# -------------------------------------------------------------------

# conf location
CONF=$(cd "$(dirname "$0")"; pwd)
source ${CONF}/conf.sh

# -------------------------------------------------------------------

# print log
print_log() {
    echo -e  "\033[0;31;1m==> $1\033[0m"
}

backup_dotfiles() {
    rm -rf ${BACKUP_TO}
    mkdir -p ${BACKUP_TO}
    cp -r ${ZSHRC_TO} ${BACKUP_TO}/zshrc.bak
    cp -r ${VIMRC_TO} ${BACKUP_TO}/vimrc.bak
    cp -r ${VIM_COLOR_TO} ${BACKUP_TO}/color.bak
    cp -r ${TERMINATOR_TO} ${BACKUP_TO}/terminator.bak
    cp -r ${YCM_TO} ${BACKUP_TO}/ycm_extra_conf.py.bak
    cp -r ${PIP_TO} ${BACKUP_TO}/pip.bak
    cp -r  ${POLYBAR_TO} ${BACKUP_TO}/polybar.bak
    cp -r ${I3WM_TO} ${BACKUP_TO}/i3.bak
    cp -r ${PACMAN_TO} ${BACKUP_TO}/pacman.conf.bak/pacman.conf.bak
}

processbar() {
    local current=$1; local total=$2;
    local maxlen=80; local barlen=62; local barlen1=64; local perclen=14;
    local format="%-${barlen1}s]%$((maxlen-barlen))s"
    local perc="[$current/$total]"
    local progress=$((current*barlen/total))
    local prog=$(for i in `seq 0 $progress`; do printf '#'; done)
    printf "\rProgress: $format" [$prog $perc
    echo ''
}

# check software
check_software() {
    print_log "Checking app $1 ..."
    which $1 >> /dev/null
    if [ $? = 0 ]; then
        echo "-> $1 had been installed"
    else
        echo "-> $1 has not been installed, installing now"
        sudo pacman -S --noconfirm $1
    fi
}

# update system
update_system() {
    sudo pacman -Syyu --noconfirm
    check_software wget
}

# install software
install_software() {
    clear
    install_software ${APP_BASE}
}

config_etc() {
    clear
    print_log "pacman:"
    sudo cp ${PACMAN_FROM} ${PACMAN_TO}
}

config_ssh() {
    clear
    echo "ssh:"

    echo "input your git email"
    read email
    git config --global user.email "$email"

    echo "input your user name"
    read name
    git config --global user.name "$name"

    echo "creating ssh key"
    ssh-keygen -t rsa -C "$email"
}

config_mirrors() {
    clear
    print_log "config mirrors list"
    sudo pacman-mirrors -c China
}

config_vim() {
    clear
    echo "vim..."
    check_software vim
    check_software clang
    check_software cmake
    check_software powerline-fonts

    # link
    ln -sfn ${VIMRC_FROM} ${VIMRC_TO}
    ln -sfn ${YCM_FROM} ${YCM_TO}
    git clone https://github.com/VundleVim/Vundle.vim.git ~/.vim/bundle/Vundle.vim
    ln -sfn ${VIM_COLOR_FROM} ${VIM_COLOR_TO}
    vim +PluginInstall +qall
}

# config zsh
config_zsh() {
    clear
    echo "zsh..."
    check_software zsh
    check_software autojump
    check_software powerline-fonts

    # oh my zsh
    wget https://github.com/robbyrussell/oh-my-zsh/raw/master/tools/install.sh -O - | sh
    ln -sfn ${ZSHRC_FROM} ${ZSHRC_TO}
    chsh -s /bin/zsh

    if [ $? = 0 ]
    then echo "chsh successfully"
    else
        echo "error when chsh"
    fi
}

# i3wm
config_i3() {
    print_log "i3wm..."
    link -sfn ${I3WM_FROM} ${I3WM_TO}
    link -sfn ${POLYBAR_FROM} ${POLYBAR_TO}
    install_software ${APP_EXTEND}
}

# install i3wm
install_i3() {
    print_log "install i3wm" 
    install_software ${APP_I3_BASE}
    install_software ${APP_EXTEND}
    link -sfn ${I3WM_FROM} ${I3WM_TO}
    link -sfn ${POLYBAR_FROM} ${POLYBAR_TO}
}

config_terminator() {
  print_log "do for terminator" 
  ln -sfn ${TERMINATOR_FROM} ${TERMINATOR_TO}
}

config_fonts() {
    print_log "do for fonts" 
    now=`pwd`
    git clone https://github.com/dongchangzhang/fonts
    sudo cp -r fonts/wf /usr/share/fonts/
    cd /usr/share/fonts/wf
    sudo chmod 644 *
    sudo mkfontscale
    sudo mkfontdir
    sudo fc-cache -fv
    cd ${now}
}

install_software() {
    not_be_installed=0
    have_been_installed=0
    linenu=$(cat $1 | wc -l)
    touch error_install.log
    for app in $(cat $1)
    do
        clear
        processbar `expr $have_been_installed + $not_be_installed` $linenu
        print_log "==> Start to install $app"

        # install by pacman
        echo "sudo pacman -S --noconfirm --needed $app"
        sudo pacman -S --noconfirm --need $app
        if [ $? -eq 0 ]
        then
            print_log "Installed:  $app"
            have_been_installed=`expr $have_been_installed + 1`
            continue
        fi
        # install by yay 
        echo "yay -S --noconfirm --needed $app"
        yay -S --noconfirm --needed $app

        if [ $? -eq 0 ]
        then
            print_log "Installed:  $app"
            have_been_installed=`expr $have_been_installed + 1`
            continue
        fi

        notify-send -i 'error' -a "Error Information For Installing" $app 
        not_be_installed=`expr $not_be_installed + 1`
        echo $app >> error_install.log
    done

    clear
    processbar `expr $have_been_installed + $not_be_installed` $linenu
    echo "Information for $1"
    echo ""
    print_log "-> $have_been_installed apps had been installed"
    print_log "-> $not_be_installed apps were not installed"
    echo ""
    echo "Error Installed Apps:"
    cat error_install.log
    sleep 3
}
