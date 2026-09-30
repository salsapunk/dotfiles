#!/bin/sh

# Lista sessões existentes
sessions=$(tmux list-sessions -F "#{session_name}" 2>/dev/null)

# Opção para criar nova sessão
new_option="[nova sessão]"

# Monta a lista com a opção de nova sessão no topo
choice=$(printf '%s\n%s' "$new_option" "$sessions" | dmenu -i -nf "#ffffff" -nb "#000000" -fn "Input Mono:size=12" -p "Tmux Session:")

# Nenhuma seleção (ESC pressionado)
[ -z "$choice" ] && exit 0

if [ "$choice" = "$new_option" ]; then
    # Pede o nome da nova sessão
    name=$(printf '' | dmenu -nf "#ffffff" -nb "#000000" -fn "Input Mono:size=12" -p 'Nome da nova sessão:')
    [ -z "$name" ] && exit 0

    if [ -n "$TMUX" ]; then
        alacritty -e tmux new-session -d -s "$name" && tmux switch-client -t "$name"
    else
        alacritty -e tmux new-session -s "$name"
    fi
else
    # Entra na sessão escolhida
    if [ -n "$TMUX" ]; then
        alacritty -e tmux switch-client -t "$choice"
    else
        alacritty -e tmux attach-session -t "$choice"
    fi
fi
