#!/usr/bin/env python3

import argparse
import sys

parser = argparse.ArgumentParser(description='Generate a grid for 3270font.')

parser.add_argument('bottom', type=float, help='Bottom Y')
parser.add_argument('top', type=float, help='Top Y')
parser.add_argument('left', type=float, help='Leftmost X')
parser.add_argument('right', type=float, help='Rightmost X')
parser.add_argument('divx', type=int, help='Horizontal divisions')
parser.add_argument('divy', type=int, help='Vertical divisions')

args = parser.parse_args()

if __name__ == '__main__':
    print('Grid')

    delta = (args.top - args.bottom) / args.divy
    y = args.bottom
    while y < args.top + delta:
        print('-1000 {:.0f} m 0\n2000 {:.0f} l 1024'.format(round(y, 0), round(y, 0)))
        y += delta

    delta = (args.right - args.left) / args.divx
    x = args.left
    while x < args.right + delta:
        print('{:.0f} 1300 m 0\n{:.0f} -700 l 1024'.format(round(x, 0), round(x, 0)))
        x += delta

    print('EndSplineSet')
