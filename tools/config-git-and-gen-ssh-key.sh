#!/bin/bash

relative_location=`dirname $0`

echo "Input your git email please: "
read email
git config --global user.email "$email"

echo "Input your user name please: "
read name
git config --global user.name "$name"

echo "Creating ssh key ... "
ssh-keygen -t rsa -C "$email"

echo "Your public key is:"

cat $HOME/.ssh/id_rsa.pub
