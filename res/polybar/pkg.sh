#!/bin/bash
pac=$(checkupdates | wc -l)
aur=$(cower -u | wc -l)

#echo "%{u#ff9900 +u}%{F#dc322f}$pac %{F-}%{F#5b5b5b}%{F-}%{F#cb4b16} $aur%{F-}%{u-}"
echo "%{u#dc322f +u}$pac %{F#5b5b5b}%{F-} $aur%{u-}"
