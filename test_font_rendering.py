#!/usr/bin/env python3
# -*- coding:utf-8 -*-

boxes = """
┌─┬┐╔═╦╗╓─╥╖╒═╤╕
├─┼┤╠═╬╣╟─╫╢╞═╪╡
│ ││║ ║║║ ║║│ ││
└─┴┘╚═╩╝╙─╨╜╘═╧╛
"""

misc_glyphs = """
Other miscellaneous glyphs: ™●⌘⏎⬇⬆✔✼✎✘‘’◢◣◤◥▮◆
"""

apl_set = """
The APL set: ⌶⌷⌸⌹⌺⌻⌼⌽⌾⌿⍀⍁⍂⍃⍄⍅⍆⍇⍈⍉⍊⍋⍌⍍⍎⍏⍐⍑⍒⍓⍔⍕⍖⍗⍘⍙⍚⍛⍜⍝⍞⍟⍠⍡⍢⍣⍤⍥⍦⍧⍨⍩⍪⍫⍬⍭⍮⍯⍰⍱⍲⍳⍴⍵⍶⍷
⍸⍹⍺
"""

BOLD = "\x1b[1m"
ITALIC = "\x1b[3m"
UNDERLINE = "\x1b[4m"
RESET = "\x1b[0m"

if __name__ == '__main__':
    print(boxes)
    print(misc_glyphs)
    print(apl_set)
    print(BOLD, "BOLD", ITALIC, "BOLD ITALIC", RESET, ITALIC, "ITALIC", RESET, UNDERLINE, "UNDERLINE", RESET, "NORMAL")
