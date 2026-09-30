#!/bin/bash

# dmenu_power.sh — gerenciador de energia

DMENU_OPTS=(-nb "#000000" -nf "#ffffff" -fn "Input Mono:size=12")

choice=$(printf "Desligar\nReiniciar\nSuspender\nHibernar\nBloquear tela" \
    | dmenu "${DMENU_OPTS[@]}" -p "Energia:")

case "$choice" in
    *"Desligar")    systemctl poweroff ;;
    *"Reiniciar")   systemctl reboot ;;
    *"Suspender")   systemctl suspend ;;
    *"Hibernar")    systemctl hibernate ;;
    *"Bloquear"*)   i3lock -c 000000 ;;  # troque por loginctl lock-session se preferir
esac
