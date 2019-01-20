* [中文](README.cn.md)

manjaro-linux-config is a tool for configuring manjaro linux（including i3wm, terminator, vim, zsh, fonts of windows, pacman and installing applications, etc.）, which uses symbolic link to manage the files of configuration.

##### Installation

```shell
# run this cmd in your terminal
sh -c "$(curl -fsSL https://raw.github.com/dongchangzhang/manjaro-linux-config/master/scripts/setup.sh)"
# then select your operation as follows
```

* NOTICE

> All files will be saved into $HOME/.manjaro-linux-config
> 
> Once you update your files
> 
> Such as .zshrc, .vimrc
> 
> Your change will also be applied in .manjaro-linux-config
> 
> You can backup this dir to save your configration

![ui](preview/ui.png)

##### Features

1. applications

   you can add or delete your applications at ~/.manjaro-linux-config/res/app/{pacman, pacman-i3wm, yay, yay-i3wm}.

   applications in *-i3wm wil be installed if you select operation A above.

2. zsh

   add new "rm" cmd, alias rm to a function, the function backup the files you want to delete into ~/.delete, you can input "unrm" undo the delete, input "lastrmtowhere" see the location of last delete, and input cleandel to clean all the backup files.

   ~/.delete/log record what you have deleted and where they are now.

3. vim

   vundle, airline, youcompleteme, etc.

   * shortcuts：

     leader: ","

     Space: ":"

     leader w : "w!"

     leader q : ":q"

     leader q1: ":q!"

     leader wq / WQ: ":wq"

     leader y: ' “+y  (copy into system clipboard)

     leader p : ' ”+p' （paste from system clipboard）

     Ctrl l: clear highlight after searching

     leader Tab: shift files

     leader tb: open tagbar

     leader nt: open nerdtree

     leader cc: quick comments

     leader cu: delete comments

     leader jd: jump to definition

     F5: check the grammar

     F9: run code

     other - please read .vimrc files

4. pacman

   add archlinuxcn, use pacman-mirror change the source.

5. i3wm

   use polybar rather than i3 status bar.

   ![polybar](preview/polybar.png)

   ![i3wm](preview/i3wm.png)

##### Tools

1. sort the applications of {pacman, pacman-i3wm, yaourt, yaourt-i3wm}

   you can run res/app/sort-pacman-yaourt.sh after you add or delete the applications.

2. backup files

   use pigz to backup the files of home, the runable file is ~/.manjaro-linux-config/tools/backup.sh

##### Licence
   MIT

