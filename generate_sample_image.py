#!/usr/bin/env python3
"""
Generate a sample rendering of the base font.
"""

from PIL import Image, ImageColor, ImageDraw, ImageFilter, ImageFont

SAMPLE_TEXT = (
    "ABCDEFHI1234567890Oijl1IS5qt\"'$#!@{}[]()<>çéáÁÑÃÏ¡²³¤€¼½¾¥×÷ßø«»®␀␍␊"
    "␌▶⚓⯒✘✔✼✎␢…⌘⏎⌫⏻⏼➜●ЯЖ"
)
CONFUSABLES = "bh 5S HX 6G AR kx gy gq Z2 Il 1l 1I OQ CG DO 0O"
LINE_COLOR = ImageColor.getrgb("#88f")
TEXT_COLOR = ImageColor.getrgb("black")


def draw_sample():

    HEIGHT = 500
    WIDTH = 800
    background = Image.new("RGBA", (WIDTH, HEIGHT), ImageColor.getrgb("white"))
    foreground = Image.new("RGBA", (WIDTH, HEIGHT), (255, 255, 255, 0))
    draw_b = ImageDraw.Draw(background)
    draw_f = ImageDraw.Draw(foreground)
    label_font = ImageFont.truetype("./build/3270-Regular.ttf", size=15)

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
        draw_b.line(((0, y + offset), (WIDTH, y + offset)), LINE_COLOR, 1)
        # Draw the point size we are using for the text.
        draw_f.text((0, y), str(size), TEXT_COLOR, font=label_font)
        # Draw the text itself
        draw_f.text((20, y), SAMPLE_TEXT, TEXT_COLOR, font=sample_font)

    img = Image.alpha_composite(background, foreground)
    return img


def draw_readability_test(blur_radius):
    sample_font = ImageFont.truetype("./build/3270-Regular.ttf", size=30)

    img = Image.new("RGB", (800, 35), ImageColor.getrgb("white"))
    draw = ImageDraw.Draw(img)
    draw.text(
        (25, 5), CONFUSABLES, TEXT_COLOR, font=sample_font,
    )
    img = img.filter(ImageFilter.GaussianBlur(blur_radius))
    return img


if __name__ == "__main__":
    sample = draw_sample()
    for radius in range(0, 6):
        rt = draw_readability_test(radius)
        sample.paste(rt, (0, 250 + 35 * radius))
    sample.save("build/3270_sample.png")
