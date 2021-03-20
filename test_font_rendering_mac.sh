#!/bin/sh

# Commented out for now
# cd %PWD%

reset
/Users/ricardo/projects/3270font/test_font_rendering.py
# Take a screenshot of the currently active window
screencapture -o -l$(osascript -e 'tell app "Terminal" to id of window 1')  /Users/ricardo/projects/3270font/build/terminal-app.png

