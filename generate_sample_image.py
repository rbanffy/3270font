#!/usr/bin/env python3
"""
Generate a sample rendering of the base font.
"""

from PIL import Image, ImageDraw, ImageFont

SAMPLE_TEXT = (
    """ABCDEFHI1234567890Oijl1IS5qt"'$#!@{}[]()<>çéáÁÑÃÏ¡²³¤€¼½¾"""
    """¥×÷ßø«»®␀␍␊␌▶⚓⯒✘✔✼✎␢…⌘⏎⌫⏻⏼➜●ЯЖ"""
)

HEIGHT = 200
WIDTH = 800
LINE_COLOR = (220, 220, 255, 255)
TEXT_COLOR = (0, 0, 0, 255)
background = Image.new("RGBA", (WIDTH, HEIGHT), (255, 255, 255))
foreground = Image.new("RGBA", (WIDTH, HEIGHT), (255, 255, 255, 0))
draw_b = ImageDraw.Draw(background)
draw_f = ImageDraw.Draw(foreground)
size_font = ImageFont.truetype("./build/3270-Regular.ttf", size=15)

y = 0

for size in range(15, 55, 5):
    sample_font = ImageFont.truetype("./build/3270-Regular.ttf", size=size)
    offset = size * 0.7
    y += offset
    # Draw the background reference lines. Upper for the alpha ascender
    draw_b.line(
        ((0, y + size * 0.2), (WIDTH, y + size * 0.2)), LINE_COLOR, 1
    )
    # Lower line for the baseline
    draw_b.line(
        ((0, y + offset), (WIDTH, y + offset)), LINE_COLOR, 1
    )
    # Draw the point size we are using for the text.
    draw_f.text((0, y), str(size), TEXT_COLOR, font=size_font)
    # Draw the text itself
    draw_f.text((20, y), SAMPLE_TEXT, TEXT_COLOR, font=sample_font)

img = Image.alpha_composite(background, foreground)

img.save("build/3270_sample.png")
