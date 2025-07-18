#!/bin/bash

# Caminho completo para o rofimoji
ROFIMOJI_BIN=$(command -v rofimoji)

# Verifica se o rofimoji está instalado
if [ -z "$ROFIMOJI_BIN" ]; then
    notify-send "Erro" "rofimoji não encontrado no PATH."
    exit 1
fi

# Preferência por xclip (X11) ou wl-copy (Wayland)
if command -v wl-copy &> /dev/null; then
    CLIP="--clipboarder wl-copy"
elif command -v xclip &> /dev/null; then
    CLIP="--clipboarder xclip"
else
    notify-send "Erro" "Nenhum clipboarder encontrado (xclip ou wl-copy)."
    exit 1
fi

# Executa o rofimoji com rofi como seletor e cópia para clipboard
$ROFIMOJI_BIN --selector rofi --action copy $CLIP
