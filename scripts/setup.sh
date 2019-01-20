if [ -d "$HOME/.manjaro-linux-config" ];
then
    mv $HOME/.manjaro-linux-config $HOME/.manjaro-linux-config.bak
fi

git clone https://github.com/dongchangzhang/manjaro-linux-config $HOME/.manjaro-linux-config

cd $HOME/.manjaro-linux-config

./scripts/start.sh

echo 'Done'
