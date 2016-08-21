# -*- coding:utf-8 -*-
"""
Generate a sample rendering of the base font.
"""

from PIL import Image, ImageDraw, ImageFont

SAMPLE_TEXT = u'''ABCDEFHI1234567890Oijl1IS5qt"'$#!@{}[]()<>çéáÁÑÃÏ¡²³¤€¼½¾'''\
              u'''‘’¥×÷ßø«»®␀␍␊␌▶⚓⯒✘✔✼✎␢…⌘⏎⌫⏻⏼➜●ЯЖ'''

img = Image.new("RGBA", (800, 200), (255, 255, 255))
draw = ImageDraw.Draw(img)
y = 0

for size in range(10, 50, 5):
    font = ImageFont.truetype('./3270Medium.otf', size=size)
    y += size * .7
    draw.text((0, y), SAMPLE_TEXT, (0, 0, 0), font=font)

img.save("3270Medium_sample.png")
