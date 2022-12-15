#!/usr/bin/env python3
"""
Generate bitmap and run tests on the image generated
"""

import sys

from PIL import Image, ImageColor, ImageDraw, ImageFont

SAMPLE_TEXT = "ABCDEFHIJKLMNOPQRSTUVWZYZ1234567890"
ERROR_COLOR = ImageColor.getrgb("red")
TEXT_COLOR = ImageColor.getrgb("black")

FONT_FILES = (
    "./build/3270-Regular.ttf",
    "./build/3270-Regular.otf",
    "./build/3270-Regular.woff",
)

# (x1, y1, x2, y2)
REGIONS_TO_VERIFY = (
    (20, 23, 290, 23),
    (20, 48, 290, 48),
    (20, 73, 290, 73),
)


def draw_sample(font_files):
    HEIGHT = 120
    WIDTH = 430
    image = Image.new("RGB", (WIDTH, HEIGHT), ImageColor.getrgb("white"))
    draw = ImageDraw.Draw(image)

    for index, font in enumerate(font_files):
        y = 20 + 25 * index

        sample_font = ImageFont.truetype(font, size=20)
        draw.text((20, y), SAMPLE_TEXT, TEXT_COLOR, font=sample_font)
    return image


def highlight_errors(image, regions, color):
    """
    In the image, test the region for dark pixels. Highlight the dark pixels in
    red. If an error was detected, return False. Otherwise, return True.
    """
    # This is a stub

    # draw = ImageDraw.Draw(image)
    for region in regions:
        x1, y1 = region[0], region[1]
        x2, y2 = region[2], region[3]
        # draw.line
        print(((x1, y1), (x2, y2)), color, 1)

        for x in range(x1, x2):
            for y in range(y1, y2):
                image.putpixel((x, y), color)

        image.show()

    return True


if __name__ == "__main__":
    sample = draw_sample(FONT_FILES)

    result = highlight_errors(sample, REGIONS_TO_VERIFY, ERROR_COLOR)

    sample.save("build/3270_rendering_test.png", format="PNG")

    if result is True:
        sys.exit(0)
    else:
        sys.exit(1)
