#!/bin/bash

repos=$(ls -1d $HOME/Workspace/*/ 2>/dev/null)

language=$(echo "$repos" | dmenu -i -nf "#ffffff" -nb "#000000" -fn "Input Mono:size=12" -p "Workspaces:")

[ -z "$language" ] && exit 0

projects=$(ls -1d "$language"*/ 2>/dev/null)

project=$(echo "$projects" | dmenu -i -nf "#ffffff" -nb "#000000" -fn "Input Mono:size=12" -p "Project:")

[ -z "$project" ] && exit 0

pkill -x alacritty 2>/dev/null || true
sleep 0.1

session=$(basename "$project")

exec alacritty -e tmux new-session -As "$session" -c "$project"
