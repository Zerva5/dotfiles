#!/bin/sh
# FROM https://github.com/victoneux/hyprland_dotfiles/blob/main/scripts/set_hyprland_workspace.sh
#current_mon=$(cat /tmp/hypr/$HYPRLAND_INSTANCE_SIGNATURE/active_monitor)
current_mon=$(hyprctl activewindow | grep -oP 'monitor: \s*\K\d+')
current_work=$(hyprctl activewindow | grep -oP 'monitor: \s*\K\d+')

current_mon_plus=$(($current_mon))
hyprctl dispatch workspace ${current_mon_plus}${1}
echo ${current_mon_plus}${1}
