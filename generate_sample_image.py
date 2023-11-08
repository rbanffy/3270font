#!/usr/bin/env python3
"""
Generate sample renderings of the 3270 font

The sample rendering is an animated GIF with all the different
formats and styles of the font shown in sequence.

The metrics rendering shows the font compared to the original,
with the original at the default 14 points (set in x3270) and
the SemiCondensed TrueType font at size 17.
"""

from PIL import Image, ImageColor, ImageDraw, ImageFont

SAMPLE_TEXT = (
    "ABCDEFHIJKLMNOP1234567890abcdefghijklmnop\"'$#!@{}[]()<>çéáÁÑÃÏ¡²³¤€¼½¾¥×"
    "÷ßø«»®␀␍␊␌▶⚓⯒✘✔✼✎␢…⌘⏎⌫⏻⏼➜●ЯЖ"
)
CONFUSABLES = "bh 5S HX 6G AR kx gy gq Z2 Il 1l 1I OQ CG DO 0O"
LINE_COLOR = ImageColor.getrgb("#88f")
TEXT_COLOR = ImageColor.getrgb("black")

X3270_SAMPLE_TEXT = (
    "ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789"
)

FONT_FILES = (
    "./build/3270-Regular.ttf",
    "./build/3270-Regular.otf",
    "./build/3270-Regular.woff",
    "./build/3270SemiCondensed-Regular.ttf",
    "./build/3270SemiCondensed-Regular.otf",
    "./build/3270SemiCondensed-Regular.woff",
    "./build/3270Condensed-Regular.ttf",
    "./build/3270Condensed-Regular.otf",
    "./build/3270Condensed-Regular.woff",
)


def draw_sample(font_file):
    HEIGHT = 500
    WIDTH = 800
    background = Image.new("RGBA", (WIDTH, HEIGHT), ImageColor.getrgb("white"))
    foreground = Image.new("RGBA", (WIDTH, HEIGHT), (255, 255, 255, 0))
    draw_b = ImageDraw.Draw(background)
    draw_f = ImageDraw.Draw(foreground)
    label_font = ImageFont.truetype(font_file, size=15)

    y = 0
    for size in range(15, 55, 5):
        sample_font = ImageFont.truetype(font_file, size=size)
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

    draw_f.text((20, 480), font_file, TEXT_COLOR, font=label_font)
    return Image.alpha_composite(background, foreground)


def draw_readability_test(font_file, factor):
    sample_font = ImageFont.truetype(font_file, size=30)

    img = Image.new("RGB", (800, 35), ImageColor.getrgb("white"))
    draw = ImageDraw.Draw(img)
    draw.text((25, 5), CONFUSABLES, TEXT_COLOR, font=sample_font)
    img = img.resize((800 // factor, 35 // factor))
    img = img.resize((800, 35), Image.Dither.NONE)

    return img


def metrics_sample(size):
    img = Image.open("x3270_sample.png")
    font = ImageFont.truetype("build/3270SemiCondensed-Regular.ttf", size=17)
    draw = ImageDraw.Draw(img)
    draw.text((5, 15), X3270_SAMPLE_TEXT, fill="black", font=font)
    return img


if __name__ == "__main__":
    # Generate samples
    samples = []
    for font in FONT_FILES:
        sample = draw_sample(font)
        for factor in range(1, 6):
            rt = draw_readability_test(font, factor)
            sample.paste(rt, (0, 250 + 35 * factor))
        samples.append(sample)
    sample.save(
        "build/3270_sample.gif",
        format="GIF",
        append_images=samples,
        save_all=True,
        duration=1000,
        loop=0,
    )

    # Generate metrics sample
    metrics_sample(17).save("build/3270_metrics.png")
