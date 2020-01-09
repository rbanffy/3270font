#!/usr/bin/env python3
# -*- coding:utf-8 -*-

import string

printable = ''.join([c for c in string.printable if c not in string.whitespace])

boxes = """
┌─┬┐╔═╦╗╓─╥╖╒═╤╕
├─┼┤╠═╬╣╟─╫╢╞═╪╡
│ ││║ ║║║ ║║│ ││
└─┴┘╚═╩╝╙─╨╜╘═╧╛
"""

misc_glyphs = "Other miscellaneous glyphs: ™●⌘⏎⬇⬆✔✼✎✘‘’◢◣◤◥▮◆\n"

apl_set = "The APL set: ⌶⌷⌸⌹⌺⌻⌼⌽⌾⌿⍀⍁⍂⍃⍄⍅⍆⍇⍈⍉⍊⍋⍌⍍⍎⍏⍐⍑⍒⍓⍔⍕⍖⍗⍘⍙⍚⍛⍜⍝⍞⍟⍠⍡⍢⍣⍤⍥⍦⍧⍨⍩⍪⍫⍬⍭⍮⍯⍰⍱⍲⍳⍴⍵⍶⍷⍸⍹⍺\n"

BOLD = "\x1b[1m"
ITALIC = "\x1b[3m"
UNDERLINE = "\x1b[4m"
OVERLINE = "\x1b[53m"
RESET = "\x1b[0m"

if __name__ == "__main__":
    print("ASCII:", printable)
    print(boxes)
    print(misc_glyphs)
    print(apl_set)
    print(
        BOLD
        + "BOLD "
        + ITALIC
        + "BOLD+ITALIC "
        + RESET
        + ITALIC
        + "ITALIC "
        + RESET
        + UNDERLINE
        + "UNDERLINE"
        + RESET
        + " "
        + OVERLINE
        + "OVERLINE"
        + RESET
        + " "
        + "NORMAL"
    )
