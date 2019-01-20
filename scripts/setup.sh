if [ -d "$HOME/.manjaro-linux-config" ];
then
    mv $HOME/.manjaro-linux-config $HOME/.manjaro-linux-config.bak
fi

mv $HOME/.manjaro-linux-config $HOME/.manjaro-linux-config.bak

git clone https://github.com/dongchangzhang/manjaro-linux-config $HOME/.manjaro-linux-config

cd $HOME/.manjaro-linux-config

./scripts/start.sh

echo 'Done'
