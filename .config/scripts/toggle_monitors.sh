#!/bin/bash

# Verifica se a tela do notebook está ativa
if xrandr | grep "eDP-1 connected" | grep -v "disconnected" | grep -q "1366x768"; then
    # Alterna para modo com tela do notebook desligada
    xrandr --output DP-1 --primary --mode 2560x1440 --rate 75 --pos 0x0 --rotate normal --output eDP-1 --off
else
    # Alterna para modo com tela do notebook ativa
    xrandr --output DP-1 --primary --mode 2560x1440 --rate 75 --pos 0x0 --rotate normal --output eDP-1 --mode 1366x768 --pos 536x1440 --rotate normal --output HDMI-1 --off --output DP-2 --off --output DP-3 --off --output DP-4 --off
fi
