#!/usr/bin/env python3

import argparse
import sys

parser = argparse.ArgumentParser(description="Generate a grid for 3270font.")

UNITS_PER_EM = 1000

parser.add_argument("origin_x", type=float, default=0, help="Origin X")
parser.add_argument("origin_y", type=float, default=0, help="Origin Y")
parser.add_argument("bottom", type=float, help="Bottom Y")
parser.add_argument("top", type=float, help="Top Y")
parser.add_argument("left", type=float, help="Leftmost X")
parser.add_argument("right", type=float, help="Rightmost X")
parser.add_argument("delta_x", type=float, help="Division width")
parser.add_argument("delta_y", type=float, help="Division height")

args = parser.parse_args()

if __name__ == "__main__":
    print("Grid")

    # Draw the origins
    print(
        '{:d} {:d} m 0\n{:d} {:d} l 1024\n  Named: "Origin X"'.format(
            args.origin_x, 2 * UNITS_PER_EM, args.origin_x, -UNITS_PER_EM
        )
    )
    print(
        '{:d} {:d} m 0\n{:d} {:.0f} l 1024\n  Named: "Origin Y"'.format(
            -UNITS_PER_EM, args.origin_y, 2 * UNITS_PER_EM, args.origin_y
        )
    )

    # Draw horizontals above zero.
    y = args.origin_y + args.delta_y
    while y < args.top + args.delta_y:
        print("-1000 {:.0f} m 0\n2000 {:.0f} l 1024".format(round(y, 0), round(y, 0)))
        y += args.delta_y

    # Draw horizontals below zero.
    y = args.origin_y - args.delta_y
    while y > args.bottom:
        print("-1000 {:.0f} m 0\n2000 {:.0f} l 1024".format(round(y, 0), round(y, 0)))
        y -= args.delta_y

    # Draw verticals to the right of the origin
    x = args.origin_x + args.delta_x
    while x < args.right + args.delta_x:
        print("{:.0f} 1300 m 0\n{:.0f} -700 l 1024".format(round(x, 0), round(x, 0)))
        x += args.delta_x

    # And to the left
    x = args.origin_x - args.delta_x
    while x > args.left:
        print("{:.0f} 1300 m 0\n{:.0f} -700 l 1024".format(round(x, 0), round(x, 0)))
        x -= args.delta_x

    print("EndSplineSet")
