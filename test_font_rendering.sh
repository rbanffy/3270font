#!/bin/sh

./test_font_rendering.py
sleep 1  # Needed by Konsole to clear the window size
# Take a screenshot of the currently active window
gnome-screenshot -w -f ./build/$1.png -e shadow
sleep 3  # So we don't end up with a second window starting up before
	 # we can sccreenshot the previous one
