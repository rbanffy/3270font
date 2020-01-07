#!/bin/sh

./test_font_rendering.py
sleep 2  # Needed by Konsole to clear the window size  
# Take a screenshot of the currently active window
gnome-screenshot -w -f $1.png
