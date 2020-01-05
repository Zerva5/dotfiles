#!/bin/bash

RAW="$(xrandr --current --verbose | grep -m 1 Brightness)"

STR=${RAW:13}

echo "$STR * 100" | bc

