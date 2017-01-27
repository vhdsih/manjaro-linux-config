#!/bin/bash

exec_location=`pwd`
relative_location=`dirname $0`

LOG=$relative_location/log

# print log
print_log() {
    echo -e  "\033[0;31;1m INSTALL-LOGS: $1  \033[0m"
    echo LOGS: $1 >> $LOG
}
# update system
update_system() {
    sudo pacman -Syyu
}
# install software
install_software() {
    print_log "do install softwares..."
    chmod +x $relative_location/res/app/install.sh
    $relative_location/res/app/install.sh
    print_log "done"
}
# config vim
config_vim() {
    print_log "do config for vim..."
    pacman -Qs vim
    status=$?
    if [ $status = 0 ]; then
        print_log "vim had been installed"
    else
        print_log "vim not be installed, install now"
        sudo pacman -S vim
    fi
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
    
    cp $relative_location/res/vim/.vimrc $HOME/.vimrc
    git clone https://github.com/VundleVim/Vundle.vim.git ~/.vim/bundle/Vundle.vim
    vim +PluginInstall +qall
    print_log "done"
}
# config zsh
config_zsh() {
    print_log "do config for zsh..."
    pacman -Qs zsh
    status=$?
    if [ $status = 0 ]; then
        print_log "zsh had been installed"
    else
        sudo pacman -S zsh
    fi

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
# config monaco-yahei
config_monaco() {
    print_log "add monaco-yahei font"
    sudo cp -r $relative_location/res/font/Monaco /usr/share/fonts/
    cd /usr/share/fonts/Monaco
    sudo chmod 755 *
    sudo mkfontscale
    sudo mkfontdir
    sudo fc-cache -fv
    cd $exec_location
    print_log "done"
}
# vscode 
config_vscode() {
    print_log "do for vscode"
    mkdir -p $HOME/.config/Code/User/
    cp $relative_location/res/vscode/* $HOME/.config/Code/User/ 
    print_log "done"
}