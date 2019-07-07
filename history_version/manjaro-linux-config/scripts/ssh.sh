#!/bin/bash

relative_location=`dirname $0`

echo "input your git email"
read email
git config --global user.email "$email"

echo "input your user name"
read name
git config --global user.name "$name"

echo "create ssh key"
ssh-keygen -t rsa -C "$email"

echo "your public key:"
cat $HOME/.ssh/id_rsa.pub
cat $HOME/.ssh/id_rsa.pub >> $relative_location/../../ssh.key

