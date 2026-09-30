#!/bin/bash

# dmenu_man.sh — busca de man pages

DMENU_OPTS=(-nb "#000000" -nf "#ffffff" -fn "Input Mono:size=12")
TERM_CMD="alacritty -e"  # troque pelo seu terminal

# Lista todos os man pages disponíveis no sistema
page=$(man -k . 2>/dev/null \
    | awk '{print $1, $2, "-", substr($0, index($0,$3))}' \
    | dmenu "${DMENU_OPTS[@]}" -p "Man page:")

[[ -z "$page" ]] && exit 0

# Extrai nome e seção (ex: "ls (1)" → ls 1)
name=$(echo "$page" | awk '{print $1}')
section=$(echo "$page" | awk '{print $2}' | tr -d '()')

exec $TERM_CMD man "$section" "$name"
