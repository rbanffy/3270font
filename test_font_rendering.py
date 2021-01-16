#!/usr/bin/env python3

import string

printable = "".join(c for c in string.printable if c not in string.whitespace)

boxes = """
┌─┬┐╔═╦╗╓─╥╖╒═╤╕
├─┼┤╠═╬╣╟─╫╢╞═╪╡
│ ││║ ║║║ ║║│ ││
└─┴┘╚═╩╝╙─╨╜╘═╧╛
"""

misc_glyphs = "Misc glyphs: ™●⌘⏎⬇⬆✔✼✎✘‘’◢◣◤◥▮◆▒░▓"

composed_glyphs = "Composed glyphs: ÀÉI͂o̓N̈́AͅB̊͆Ȍ͇U͈D̈ẢB̊A̋ĎA̍J̎Ȁ\n"

apl_set = (
    "The APL set: ⌶⌷⌸⌹⌺⌻⌼⌽⌾⌿⍀⍁⍂⍃⍄⍅⍆⍇⍈⍉⍊⍋⍌⍍⍎⍏⍐⍑⍒⍓⍔⍕⍖⍗⍘⍙⍚⍛⍜⍝⍞⍟⍠⍡⍢⍣⍤⍥⍦⍧⍨⍩⍪⍫⍬⍭⍮⍯⍰⍱"
    "⍲⍳⍴⍵⍶⍷⍸⍹⍺⊂⊃⊆⊇⊏⊐⊑⊒⊔⊓⊕⊖⊗⊘⊙⌾⊝⋆⌈⌉⌊⌋⁼⇐⇒⊸⟜⟨⟩⋄∧∨⊢⊣⊤⊥≢⚇⎉⎊◴◵◶◷⥊⥋∾‿↩↪≍𝕩𝕨𝕤𝕣𝕘𝕗𝕏𝕎𝕊𝔾𝔽\n"
)

confusables = (
    "Easily confused pairs: bh 5S HX 6G AR kx gy gq Z2 Il 1l 1I OQ CG DO 0O\n"
)

ladder = "Vttest's ladder: ⎺⎻─⎼⎽\n"

u1fb0_symbols = (
    "U+1FB00 symbols 🬀🬁🬅🬊🬍🬒🬗🬛🬥🭄🭆🭈🭋🭍🭂🭬🭭🭮🭯🮌🮏🮒🮚🮛🮜 " "🮰🮲🮳🯁🯂🯃🮹🮺🯄🯅🯆🯇🯈🯉🯰🯱🯲🯳🯴🯵🯶🯷🯸🯹\n"
)

patterns = "U+1FB00 Patterns: 🮘🮘🮘🮘 🮙🮙🮙🮙 🮕🮕🮕🮕 🮖🮖🮖🮖\n"

BOLD = "\x1b[1m"
ITALIC = "\x1b[3m"
UNDERLINE = "\x1b[4m"
OVERLINE = "\x1b[53m"
RESET = "\x1b[0m"

if __name__ == "__main__":
    print("ASCII:", printable)
    print(boxes)
    print(misc_glyphs, composed_glyphs)
    print(apl_set)
    print(confusables)
    print(ladder)
    print(u1fb0_symbols)
    print(patterns)
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
