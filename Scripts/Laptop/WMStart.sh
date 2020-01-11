
#!/bin/bash

compton --config ~/.config/compton/compton.conf &
nm-applet &
xrandr --output eDP1 --gamma .75:.75:.75

