#!/bin/bash

## Author : Aditya Shakya (adi1090x)
## Mail : adi1090x@gmail.com
## Github : @adi1090x
## Reddit : @adi1090x

# Available Styles
# >> Styles Below Only Works With "rofi-git(AUR)", Current Version: 1.5.4-76-gca067234
# full     full_circle     full_rounded     full_alt
# card     card_circle     column     column_circle
# row     row_alt     row_circle
# single     single_circle     single_full     single_full_circle     single_rounded     single_text

style="power"
#rofi_command="rofi -theme ~/.local/share/rofi/themes/squared-mY-poweroff.rasi"
#rofi_command="rofi -theme ~/.local/share/rofi/themes/squared-nord.rasi"
#rofi_command="rofi -theme ~/.local/share/rofi/themes/nord-oneline-my-poweroff.rasi"
rofi_command="rofi -theme ~/.local/share/rofi/themes/my-spotlight-dark.rasi"
#rofi_command="rofi -theme ~/.local/share/rofi/themes/spotlight-power.rasi"
#rofi_command="rofi -theme ~/.local/share/rofi/themes/z3.rasi"
#rofi_command="rofi -theme ~/.local/share/rofi/themes/z2.rasi"

#uptime=$(uptime -p)
#my_hostname=$(hostname)

## options
#shutdown="  shutdown"
#reboot="   reboot"
#logout="   logout"
#lock="    lock"

# options
#shutdown="  "
#reboot="  "
#logout="  "
#lock="  "

### options
#shutdown="       poweroff"
#reboot="       reboot"
#logout="       logout"
#lock="       lock"


## options
shutdown=" poweroff"
reboot="  reboot"
logout="  logout"
lock="   lock"

# Variable passed to rofi
options="$shutdown\n$reboot\n$logout\n$lock"
#options="$lock\n$reboot\n$shutdown\n$logout"

#chosen="$(echo -e "$options" | $rofi_command -p " Select " -dmenu -selected-row 2)"
#chosen="$(echo -e "$options" | $rofi_command -p " " -dmenu -selected-row )"
chosen="$(echo -e "$options" | $rofi_command -p " " -dmenu -selected-row )"

case $chosen in

    $lock)   i3lock -c 000000 ;;
    $shutdown) /sbin/poweroff ;;
    $reboot)   /sbin/reboot ;;
    $logout)   pkill -KILL -u $USER ;;
esac
