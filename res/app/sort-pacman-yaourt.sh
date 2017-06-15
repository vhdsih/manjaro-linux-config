#!/bin/bash

sort -bu pacman > pacman.tmp
sort -bu yaourt > yaourt.tmp

mv pacman.tmp pacman
mv yaourt.tmp yaourt

rm -rf pacman.tmp
rm -rf yaourt.tmp

echo 'done'


