#!/usr/bin/env python
# -*- coding:utf-8 -*-
"""
Generate a sample rendering of the base font.
"""

from PIL import Image, ImageDraw, ImageFont

SAMPLE_TEXT = u'''ABCDEFHI1234567890Oijl1IS5qt"'$#!@{}[]()<>çéáÁÑÃÏ¡²³¤€¼½¾'''\
              u'''‘’¥×÷ßø«»®␀␍␊␌▶⚓⯒✘✔✼✎␢…⌘⏎⌫⏻⏼➜●ЯЖ'''

HEIGHT = 200
WIDTH = 800

background = Image.new("RGBA", (WIDTH, HEIGHT), (255, 255, 255))
foreground = Image.new("RGBA", (WIDTH, HEIGHT), (255, 255, 255, 0))
draw_b = ImageDraw.Draw(background)
draw_f = ImageDraw.Draw(foreground)
size_font = ImageFont.truetype('./3270Medium.otf', size=15)
y = 0

for size in range(15, 55, 5):
    sample_font = ImageFont.truetype('./3270Medium.otf', size=size)
    offset = size * .7
    y += offset
    # Draw the background reference lines.
    draw_b.line(((0, y+size*.2), (WIDTH, y+size*.2)), (100, 100, 255, 255), 1)
    draw_b.line(((0, y+offset), (WIDTH, y+offset)), (100, 100, 255, 255), 1)
    # Draw the sample text.
    draw_f.text((0, y), str(size), (0, 0, 0, 255), font=size_font)
    draw_f.text((20, y), SAMPLE_TEXT, (0, 0, 0, 255), font=sample_font)

img = Image.alpha_composite(background, foreground)

img.save("3270Medium_sample.png")
