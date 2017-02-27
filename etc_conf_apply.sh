#!/bin/bash

relative_location=`dirname $0`

dir=$relative_location/res/etc/

files=(
/etc/locale.gen
/etc/pacman.conf
/etc/pacman-mirrors.conf
/etc/profile
/etc/X11/xorg.conf.d/70-synaptics.conf
)

backup() {
    for file in ${files[@]}
    do
        ls $file.bak
        if [ $? = 0  ]
        then
            echo $file.bak file exist, rm it
            rm -rf $file.bak
        fi
        echo mv $file to $file.bak
        sudo mv $file $file.bak
    done;
}

apply_backup() {
    sudo cp $dir/locale.gen /etc
    sudo cp $dir/pacman.conf /etc
    sudo cp $dir/pacman-mirrors.conf /etc
    sudo cp $dir/70-synaptics.conf /etc/X11/xorg.conf.d/
    sudo cp $dir/profile /etc
}

backup
apply_backup
sudo locale-gen

