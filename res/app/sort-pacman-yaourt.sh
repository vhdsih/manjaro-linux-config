#!/bin/bash

sort -bu pacman > pacman.tmp
sort -bu yaourt > yaourt.tmp
sort -bu pacman-i3wm > pacman-i3wm.tmp
sort -bu yaourt-i3wm > yaourt-i3wm.tmp

mv pacman.tmp pacman
mv yaourt.tmp yaourt
mv pacman-i3wm.tmp pacman-i3wm
mv yaourt-i3wm.tmp yaourt-i3wm

rm -rf pacman.tmp
rm -rf yaourt.tmp
rm -rf pacman-i3wm.tmp
rm -rf yaourt-i3wm.tmp

echo 'done'


