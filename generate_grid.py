#!/usr/bin/env python3

import argparse
import sys

parser = argparse.ArgumentParser(description="Generate a grid for 3270font.")

# Character is within a rectangle (0, -400) to (1080, 1600)

GUIDE_XMIN = -200
GUIDE_XMAX = 1280

GUIDE_YMIN = -600
GUIDE_YMAX = 1800

parser.add_argument("origin_x", type=float, default=122, help="Origin X")
parser.add_argument("origin_y", type=float, default=98, help="Origin Y")
parser.add_argument("bottom", type=float, default=-400, help="Bottom Y")
parser.add_argument("top", type=float, default=1600, help="Top Y")
parser.add_argument("left", type=float, default=0, help="Leftmost X")
parser.add_argument("right", type=float, default=540, help="Rightmost X")
parser.add_argument("delta_x", type=float, default=68, help="Division width")
parser.add_argument("delta_y", type=float, default=250, help="Division height")

args = parser.parse_args()

if __name__ == "__main__":

    print("#", " ".join(sys.argv))

    print("Grid")

    # Each guide line is described by a point (x y m 0) and a line
    # (x y l 1024). It can optionally be named.

    # Draw the origin lines.
    print(
        '{:.0f} {:.0f} m 0 {:.0f} {:.0f} l 1024 Named: "Origin X"'.format(
            args.origin_x, GUIDE_YMIN, args.origin_x, GUIDE_YMAX
        )
    )
    print(
        '{:.0f} {:.0f} m 0 {:.0f} {:.0f} l 1024 Named: "Origin Y"'.format(
            GUIDE_XMIN, args.origin_y, GUIDE_XMAX, args.origin_y
        )
    )

    # Draw horizontals above the origin.
    y = args.origin_y + args.delta_y
    while y < args.top + args.delta_y:
        print(
            '{:.0f} {:.0f} m 0 {:.0f} {:.0f} l 1024 Named: "{:.0f}"'.format(
                GUIDE_XMIN, round(y, 0), GUIDE_XMAX, round(y, 0), y
            )
        )
        y += args.delta_y

    # Draw horizontals below the origin.
    y = args.origin_y - args.delta_y
    while y > args.bottom:
        print(
            '{:.0f} {:.0f} m 0 {:.0f} {:.0f} l 1024 Named: "{:.0f}"'.format(
                GUIDE_XMIN, round(y, 0), GUIDE_XMAX, round(y, 0), y
            )
        )
        y -= args.delta_y

    # Draw verticals to the right of the origin.
    x = args.origin_x + args.delta_x
    while x < args.right + args.delta_x:
        print(
            '{:.0f} {:.0f} m 0 {:.0f} {:.0f} l 1024 Named: "{:.0f}"'.format(
                round(x, 0), GUIDE_YMIN, round(x, 0), GUIDE_YMAX, x
            )
        )
        x += args.delta_x

    # And to the left.
    x = args.origin_x - args.delta_x
    while x > args.left:
        print(
            '{:.0f} {:.0f} m 0 {:.0f} {:.0f} l 1024 Named: "{:.0f}"'.format(
                round(x, 0), GUIDE_XMIN, round(x, 0), GUIDE_XMAX, x
            )
        )
        x -= args.delta_x

    print("EndSplineSet")
