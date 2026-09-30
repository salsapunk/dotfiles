#!/bin/bash 
query="$( echo "" | dmenu -nb "#000000" -nf "#ffffff" -fn "Input Mono:size=12" -p "Search:" <&- )" 
[ -n "${query}" ] && firefox https://www.duckduckgo.com/search?q="${query}" &
