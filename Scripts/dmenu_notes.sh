#! /bin/bash

# default file type = .txt

notes=$(ls $HOME/Notes/ 2>/dev/null)
newnote="[nova nota]"

note=$(printf '%s\n%s' "$newnote" "$notes" | dmenu -nb "#000000" -nf "#ffffff" -fn "Input Mono:size=12" -p "Selecione a anotação:")

[[ -z "$note" ]] && exit 0

if [ "$note" = "$newnote" ]; then
    name=$(printf '' | dmenu -nf "#ffffff" -nb "#000000" -fn "Input Mono:size=12" -p 'Nome da nova anotação:')
    [ -z "$name" ] && exit 0
    
    notepath="$HOME/Notes/$name"

    touch "$notepath.txt"
    exec alacritty -e nvim "$notepath.txt"
else
    exec alacritty -e nvim "$note"
fi
