#! /bin/bash

sessions=$(tmux list-sessions -F "#{session_name}" 2>/dev/null)

[ -z "$sessions" ] && exit 0

choice=$(echo "$sessions" | dmenu -i -nf "#ffffff" -nb "#000000" -fn "Input Mono:size=12" -p "Kill Session:")

[ -z "$choice" ] && exit 0

tmux kill-session -t "$choice"
