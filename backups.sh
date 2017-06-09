#!/bin/bash

relative_location=`dirname $0`
commands_location=$relative_location/tar.sh

install_pigz() {
    which pigz >> /dev/null
    if [ $? = 0 ]; then
        echo "pigz had been installed"
    else
        sudo pacman -S --noconfirm pigz
    fi
}

backup_home() {
    chmod +x $commands_location
    $commands_location
}


backup_vim_zsh() {
    rm -rf $relative_location/res/zsh/.zshrc.bak
    rm -rf $relative_location/res/vim/.vimrc.bak
    rm -rf $relative_location/res/vim/colors.bak

    mv $relative_location/res/zsh/.zshrc $relative_location/res/zsh/.zshrc.bak
    mv $relative_location/res/vim/.vimrc $relative_location/res/vim/.vimrc.bak
    mv $relative_location/res/vim/colors $relative_location/res/vim/colors.bak

    rm -rf $relative_location/res/zsh/.zshrc
    rm -rf $relative_location/res/vim/.vimrc
    rm -rf $relative_location/res/vim/colors

    cp $HOME/.zshrc $relative_location/res/zsh/
    cp $HOME/.vimrc $relative_location/res/vim/
    cp -r $HOME/.vim/colors $relative_location/res/vim/
}

create_backup_command() {
    echo > $commands_location
    echo "#!/bin/bash" >> $commands_location
    echo "tar --use-compress-program=pigz \\" >> $commands_location
    echo "--exclude=$HOME/.cache \\" >> $commands_location
    echo "--exclude=$HOME/.android \\" >> $commands_location
    for dir in $(ls $HOME); do
        echo "--exclude=$HOME/$dir \\" >> $commands_location
    done;
    echo "-cvpf backup.tar $HOME" >> $commands_location
}

extract_backups() {
    tar --use-compress-program=pigz \
        -xvpf backup.tar
}

while getopts 0123 option
do
    case "$option" in
        0)
            echo "back up home files"
            install_pigz
            create_backup_command
            echo "-------------------    backups command    -------------------"
            cat $commands_location
            echo "-------------------------------------------------------------"
            echo "Edit backups command(Y/n)"
            read command
            if [ $command = 'Y' -o $command = 'y' ]; then
                which vim > /dev/null
                if [ !$? = 0 ]; then
                    sudo pacman -S vim
                fi
                vim $commands_location
            else
                echo "use default commands"
            fi
            sleep 1
            backup_home
            echo "done";;

        1)
            echo "extract backup.tar"
            install_pigz
            extract_backups
            echo "done";;
        2)
            echo "back vimrc and zshrc"
            backup_vim_zsh
            echo "done";;

        \?)
            echo "------------------------------HELP------------------------------------"
            echo "|-0  backup home files to backup.tar                                 |"
            echo "|-1  extract backup.tar to there                                     |"
            echo "|-2  backup vim and zsh                                              |"
            echo "----------------------------------------------------------------------"
            echo "bye";;
    esac
done
