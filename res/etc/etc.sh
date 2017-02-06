#!/bin/bash

relative_location=`dirname $0`

sudo mv /etc/pacman.conf /etc/pacman.conf.bak
sudo cp $relative_location/pacman.conf /etc/

sudo mv /etc/pacman-mirrors.conf /etc/pacman-mirrors.conf.bak
sudo cp $relative_location/pacman-mirrors.conf /etc/

sudo mv /etc/locale.gen /etc/locale.gen.bak
sudo cp $relative_location/locale.gen /etc/

sudo locale-gen
 