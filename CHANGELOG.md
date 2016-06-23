v1.2.15
-------

- Added ⏻, ⏼, ⭘, ⏽, ⏾ and ⯒
- Added Ў, ў, Џ, џ, Ћ and ћ
- Added Ž, ž, Ơ, Ư, ơ, ư, Š, š, Э, э, ё, м, щ and ы
- Fixed u
- Made ‘ and ’ more distinctive
- Added 'upload' target to Makefile
- Added К, Л, М, Н, О, П, Р, С, Т, У, Ф, Х, Ц, Ш, Щ, Ь, Ю, Я, Ч, Ъ, Ы,
  а, б, в, г, д
- Added ▶, ✱, ❯, ◼
- Added А, Б, В, Г, Д, Е, Ж, З, И and Й
- Added ✓
- Added Ǝ, и and ˚
- Added ✖ glyph

v1.2.14
-------
- Added ⚓ glyph
- Added ‘ and ’ (quoteleft and quoteright)
- Added ✘ (used by Homebrew)
- Add help target to help message
- Fix the help message
- Add upped case delta glyph
- `make install` now installs on OSX

v1.2.13
-------
- Corrected codepoint for single beer, added two-beer glyph

v1.2.12
-------
- Add a beer mug (used by Homebrew)
- Fix regex in Makefile test target
- Make the powerline up arrow taller

v1.2.11
-------
- Add missing dotted Irish alphabet chars
- Add shorter f and t for easier accent composition
- Use wider traces for ✎
- Added a SemiNarrow variant 492 units wide

v1.2.10
-------
- Small fixes to a and e
- Remove StdHW and StemSnapH PostScript private dicts
- Redo and simplify 0-9, maybe fix #6
- Added a lambda, ⬇, ⬇, ✔, ✼, ✎, u1F394 and uni21AF
- Adjustments to <U+2753>, ?, | and ¦

v1.2.9
------
- No longer remove Debian logo on font generation
- Add Debian logo copyright and license terms to LICENSE.txt

v1.2.8
------
- Resized various glyphs so that they have more consistent widths
- Simplified multiple accented chars, adjusted borders

v1.2.7
------
Add more border drawing chars
Add hints/counterhints
Redo $
Simplify @
Realign vertexes on apl_topsolid
Realign vertexes on CR glyph

v1.2.6
------
- Get the S3 URL from the README file
- Added a check to make sure the zip file was uploaded and is accessible
- Add a simple programn to show some "Unicode art"
- Added miscellaneous glyphs
- Add ltshade, shade and dkshade glyphs (useful for progress bars)
- Add a test for the created zip file
- Added travis support
- Added ⌘ and ⏎ glyphs

v1.2.5
------
- Changing the Windows font viewer screencap to a more recent Windows
- Attempting to fix hinting issues on C, Q and S observed on Windows
- ● glyph (used by systemctl)

v1.2.4
------
- Updated download link, added Windows XP screenshot, removed Windows
  compatibility message
- Removed uniFFFF, which caused the Windows compatibility issues
- Add an  at U+f8ff
- Add note about anti-aliasing

v1.2.3
------
- Make the T in ™ symmetrical
- Make ™ skinnier
- Make … more boldface-friendly
- Added ™ glyph
- Added double-line box-drawing glyphs used in Midnight Commander
- Add missing line drawing chars, (┬ and ┴), solve alingment issues with
  others
- Added << and >>
- Added you-should-reboot glyph

v1.2.1
------
- Fix self-intersect on composite Ccedilla (caused problems with ttf)

v1.2
----
- Merge branch 'kilobyte-master'

v1.1
----
- Adjusting a, e, p, w for smaller point sizes
- Added uninstall target

v1 - Initial release
--------------------
- Added "zip" target to Makefile
