#!/bin/bash

sort pacman > pacman.tmp
sort yaourt > yaourt.tmp

mv pacman.tmp pacman
mv yaourt.tmp yaourt

rm -rf pacman.tmp
rm -rf yaourt.tmp

echo 'done'


