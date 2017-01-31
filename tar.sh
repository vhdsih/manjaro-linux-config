
#!/bin/bash
tar \
--use-compress-program=pigz \
--exclude=/home/dongchangzhang/.cache \
--exclude=/home/dongchangzhang/.android \
--exclude=/home/dongchangzhang/Android \
--exclude=/home/dongchangzhang/Desktop \
--exclude=/home/dongchangzhang/Documents \
--exclude=/home/dongchangzhang/Downloads \
--exclude=/home/dongchangzhang/GitHub \
--exclude=/home/dongchangzhang/MEGA \
--exclude=/home/dongchangzhang/Music \
--exclude=/home/dongchangzhang/Pictures \
--exclude=/home/dongchangzhang/Public \
--exclude=/home/dongchangzhang/Templates \
--exclude=/home/dongchangzhang/tmp \
--exclude=/home/dongchangzhang/Videos \
-cvpf backup.tar /home/dongchangzhang -C backup-files
