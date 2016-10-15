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

img = Image.new("RGBA", (WIDTH, HEIGHT), (255, 255, 255))
draw = ImageDraw.Draw(img)
y = 0

for size in range(10, 50, 5):
    font = ImageFont.truetype('./3270Medium.otf', size=size)
    y += size * .7
    draw.line(((0, y-3), (WIDTH, y-3)), (100, 100, 255, 128), 1)
    draw.text((0, y), SAMPLE_TEXT, (0, 0, 0, 255), font=font)

img.save("3270Medium_sample.png")
