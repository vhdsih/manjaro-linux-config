* [English](README.md)

manjaro-linux-config是一个系统配置脚本，其中包括对i3wm、polybar、terminator、vim、zsh、字体、pacman等常用软件的配置，也包括对常用软件的安装脚本，能够节约使用者的配置时间。另外，系统使用符号链接管理配置文件，方便后续的备份和恢复。

##### 安装
```shell
# 在终端中运行下面的命令
sh -c "$(curl -fsSL https://raw.github.com/dongchangzhang/manjaro-linux-config/master/scripts/setup.sh)"
# 之后在弹出的UI窗口总选择你需要的动作
```

*注意
> 所有文件将保存在家目录的.manjaro-linux-config
> 
> 当你修改了配置文件
>
> 如： .zshrc, .vimrc
>
> 你做出的改变也会应用到 .manjaro-linux-config中对应的文件
> 
> 你可以保存$HOME/.manjaro-linux-config这个文件夹来保存你的配置

![ui](preview/ui.png)

