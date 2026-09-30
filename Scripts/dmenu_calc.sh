#!/bin/bash

# dmenu_calc.sh — calculadora com histórico via bc

DMENU_OPTS=(-nb "#000000" -nf "#ffffff" -fn "Input Mono:size=12")
HISTORY_FILE="$HOME/.dmenu_calc_history"

touch "$HISTORY_FILE"

# Monta lista: histórico (mais recente primeiro) + prompt vazio
options=$(tac "$HISTORY_FILE" | head -20)

expr=$(printf "%s" "$options" \
    | dmenu "${DMENU_OPTS[@]}" -p "Calcular:")

[[ -z "$expr" ]] && exit 0

# Avalia com bc (suporta funções como sqrt, ^, etc.)
result=$(echo "scale=10; $expr" | bc -l 2>&1)

if [[ $? -ne 0 ]] || [[ -z "$result" ]]; then
    echo "Erro na expressão" | dmenu "${DMENU_OPTS[@]}" -p "Erro:" <&-
    exit 1
fi

# Remove zeros à direita (ex: 1.50000 → 1.5)
result=$(echo "$result" | sed 's/\.0*$//;s/\(\.[0-9]*[1-9]\)0*$/\1/')

# Exibe resultado e copia pro clipboard
echo "$expr = $result" | dmenu "${DMENU_OPTS[@]}" -p "Resultado:" \
    && echo -n "$result" | xclip -selection clipboard

# Salva no histórico (sem duplicatas)
grep -qxF "$expr = $result" "$HISTORY_FILE" || \
    echo "$expr = $result" >> "$HISTORY_FILE"
