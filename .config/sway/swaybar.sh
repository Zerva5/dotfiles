#!/bin/sh

DATE=$(date +'%a, %b %d %Y - %l:%M %p')

BAT=$(acpi | grep 'Battery 0:' | grep -o '[0-9]\{1,3\}%')
# BAT=$(acpi | grep "Battery: 0" -o '[0-9]\{1,3\}%' | sed 's/%//')

echo Bat: $BAT "|" $DATE
# echo "hi"
