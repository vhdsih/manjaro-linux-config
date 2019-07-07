# Author: Vhdsih

export ZSH=$HOME/.oh-my-zsh

ZSH_THEME="steeef"

plugins=(autojump sudo)

source $ZSH/oh-my-zsh.sh

# add sudo
sudo-command-line() {
    [[ -z $BUFFER ]] && zle up-history
    [[ $BUFFER != sudo\ * ]] && BUFFER="sudo $BUFFER"
    zle end-of-line 
}
zle -N sudo-command-line
bindkey "\e\e" sudo-command-line

# replace rm command to avoid 'error delete'
# when rm something, mv them into $HOME/.delete
# mkdir ~/.delete, when rm somethings ,mv them to here
#
if [ ! -d $HOME/.delete ]
then
    mkdir $HOME/.delete
fi

unDoRm() {
    echo '---------------->>' >> ~/.delete/delete.log
    echo 'UnDoRmFromThere:' $dir_name To $last_do_backup_dir >> ~/.delete/delete.log
    mv -i $HOME/.delete/$dir_name/* $last_do_backup_dir
    /bin/rm -rf $HOME/.delete/$dir_name
    echo '<<----------------' >> ~/.delete/delete.log
}

movetowhere() {
    echo $dir_name
}

toBackup()
{
    dir_name=`date`
    mkdir -p $HOME/.delete/$dir_name
    last=$@
    last_do_backup_dir=`pwd`
    echo '----------------->>' >> ~/.delete/delete.log
    echo BackupToThere: $dir_name >> ~/.delete/delete.log
    for thing in $@
    do
        echo $thing | grep '^-' > /dev/null
        if [ ! $? = 0 ]
        then
            mv $thing $HOME/.delete/$dir_name
            echo mv $thing to ~/.delete/$dir_name, you can backup them
            echo '' >> ~/.delete/delete.log
            echo Name: $thing >> ~/.delete/delete.log
            echo FromWhere: `pwd`/$thing >> ~/.delete/delete.log
            echo MoveTo: $dir_name >> ~/.delete/delete.log
        fi
    done
    echo '<<------------------' >> $HOME/.delete/delete.log

}

cleanDelete()
{
    echo 'clear backup files?[y/N]'
    read confirm
    [ $confirm = 'y' ] || [ $confirm = 'Y' ]  && /bin/rm -rf $HOME/.delete/*
}

# rm somethings
alias rm=toBackup

# see what in~/.delete now
alias lsdel='ls $HOME/.delete'
# undo
alias unrm=unDoRm

alias lastrmtowhere=movetowhere

# clean ~/.delete
alias cleandel=cleanDelete

alias 'opencv'='g++ `pkg-config --cflags --libs opencv`'

# activing anaconda env by 'Anaconda'
alias 'Anaconda'='source /home/z/anaconda3/bin/activate root'
alias 'Anaconda-close'='source /home/z/anaconda3/bin/deactivate root'
