## manjaro linux configuration

manjaro linux是基于arch linux的一个发行版本。

### 功能

1. 对于新安装的manjaro linux，可以运行该脚本以配置pacman以及mirrors-list。更新并升级系统软件，安装常用的软件，安装monaco字体以及monaco-yahei字体以及powerline字体，配置vim、zsh以及vscode，配置git并且生成github需要的ssh-key
2. 对于其他用户以上各个功能已经被拆分，可以根据需要选择使用。
3. 根目录下的backups.sh用来备份用户目录，可以根据需要保留个人的配置。

### 开始

克隆仓库到本地

```shell
git clone git@github.com:dongchangzhang/manjaro-linux-config.git
cd manjaro-linux-config
```

查看setup.sh支持的功能

```shell
chmod +x setup.sh
./setup.sh -q
```

选择你需要的功能运行

```
./setup.sh -选项1选项2...
```

**INFO**

根目录下的log文件记录了setup.sh的执行日志；res/app/log记录了安装的软件的日志；你可以到res/app/pacman以及yaourt文件中编辑你需要的软件，其中pacman文件使用pacman安装，yaourt中的使用yaourt命令安装

查看backups.sh支持的功能

```shell
chmod +x backups.sh
./backups.sh -q
```

选择你需要的功能

```shell
./backups.sh -选项1选项2...
```

**INFO**

备份home目录将生成backup.tar，该文件使用pigz进行打包压缩，由于pigz支持多线程可以提高压缩速度。解压时请保证backup.tar和脚本文件在同一个目录下。在备份home目录时将生成tar.sh这个脚本是将执行的备份命令，默认不备份非隐藏文件，在备份过程中你有机会使用vim编辑该文件来备份你需要的文件。