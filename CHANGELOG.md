## v3.0.0

- Set version to 3.0.0 because font metrics changed
- Fix WOFF major version
- Remove unnecessary Adobe XUID
- Change width for semi-condensed and condensed versions
- Add sample images for each font variation
- Scale glyphs before making the bounding box narrower
- Generate a ‘PfEd’ table and store glyph comments in the PS font
- Change OTF flags - don't generate glyph map remove PS-related flag
- Added building blocks for Kaypro octants
- Fix ӗ, ⇵, ㄍ, , p, n
- Re-add Ogham bar
- Added a social preview image
- Added note to README on build dependencies
- Added ⋈, ⨝, ⋉, ⋊, Ō, ŕ, ˅, ѐ, ӕ, ⇑, ⇓, ∔, ✙, ⌁
- Added 4-dotted numbers to rendering sample
- Moved  ⃛ and  ⃜ up away from topline
- Add GitHub workflow for testing
- Fix cache clear utility
- Update requirements.txt
- Set version to 2.3.2

## v2.3.1

- Swap ⊓ and ⊔
- Fix ˜ (make it different from ~)
- Fix F, G, L, Ģ, ģ, €, a, Њ, њ, ª, q, r, ă, 𝔾. 𝕗, 𝕣, 𝗮, 𝗾, 𝗿, 🬭, 🬮,
  🬼, 🬽, 🬾, 🬿, 🭀, 🭂, 🭄, 🭆, 🭍, 🭏, 🭐, 🭒, 🭓, 🭕, 🭖, 🯆, 🯇, 🯈,
  ԍ, 🯉, ↉, ⅒, ↩, ↪, ❌
- Point to SIL license using HTTPS URL
- Add ╵, ╷, ╶, ╴, and ⃛
- Use a constant to set which font file to use
- Set version to 2.3.1

## v2.3.0

- Add '⋅'
- Add "╭", "╮", "╰", and "╯". Fixes \#89
- Improve ▴, ►, ▾, ◄
- Add missing glyph ▋, ▽, △
- Version set to 2.3.0

## v2.2.1

- Add a hooks folder with a suggested pre-commit hook
- Add APL and BQN glyphs ⊂, ⊃, ⊆, ⊇, ⊏, ⊐, ⊑, ⊒, ⊔, ⊓, ⊕, ⊖, ⊗, ⊘, ⊙, ⌾,
  ⊝, ⋆, ⌈, ⌉, ⌊, ⌋, ⁼, ⇐, ⇒, ⊸, ⟜, ⟨, ⟩, ⋄, ∧, ∨, ⊢, ⊣, ⊤, ⊥, ≢, ⚇, ⎉,
  ⎊, ◴, ◵, ◶, ◷, ⥊, ⥋, ∾, ‿, ↩, ↪, ≍, 𝕩, 𝕨, 𝕤, 𝕣, 𝕘, 𝕗, 𝕏, 𝕎, 𝕊, 𝔾, 𝔽
- Modify some glyphs to improve consistency in APL and BQN code: ¬, ⌙,
  ⌜, ⌝, ⌞, ⌟, •, ∩, ⌐, ○, ∪, ∘, ⍷
- Fix ●
- Add combining glyphs ̉, ̍, ̎, ̏, ̐, ̑, ̒ , ̓ , ̔ , ̕ , ̖ , ̗ , ̜ , ̘ , ̙ , ̚ , ̛ , ̜ ,ㄍ,
  ̞ , ̟ , ̠ , ̡ , ̢ , ̣ , ̤ , ̥ , ̦ , ̧ , ̨ , ̩ , ̪ , ̫ , ̬ , ̭ , ̮ , ̯ , ̰ , ̱ , ̲ , ̳ , ̴ ,
  ̵ , ̶ , ̷ , ̸ , ̹ , ̺ , ̻ , ̼ , ̽ , ̾ , ̿, ̀ , ́ , ͂ , ̓ , ̈́ , ͅ , ͆ , ͇ , ͈ , ͉ , ͊ , ͋ , ͌ ,
  ͎ , ͍ , ͐ , ͑ , ͒ , ͓ , ͔ , ͕ , ͖ , ͗ , ͘ , ͙ , ͚ , ͛ , ͜ , ͝ , ͞ , ͟ , ͠ , ͡ , ͢ , ͣ , ͤ ,
  ͥ , ͦ , ͧ , ͨ , ͩ , ͪ , ͫ , ͬ , ͭ , ͮ , ͯ .
- Add ँ, ʻ, ꭪, ꭫
- Add composing glyphs to rendering test
- Adjust derived font names
- Simplify cedilla, fix overlap in ç and Ç
- Set version to 2.1.1 (next release)

## v2.1.0

- Update spline format to 3.2
- Fixed "🬉" (U+1fb09 - BLOCK SEXTANT-24) \#71
- PEP-8 improvements to generate\_sample\_image.py
- Interim fix for pinned Pillow in gftools
- Update Travis environment to Ubuntu Focal and Python 3.8
- Set version to 2.1.0 (next release)

## v2.0.4

- Fixes to all half, quarter and eights blocks, ░, ▒, ▓, ⍲, X, Ò, Ó, Ô,
  Õ, Ö, Ō, ō, Ŏ, ￩, ￪, ￫, ￬
- Make APL chars look nicer
- Adjust OS/2 metrics
- Set vertical advance to 0
- Added vertical metrics
  (https://fontforge.org/fontinfo.html\#PS-General)
- Removed 🍺, 🍻, 💖, 💡, 😪
- Added ➥, ➦, Unicode 13 Symbols for Legacy Computing
- Sample rendering now includes blurred easily confused pairs
- Added sample generation using actual terminal software (on Linux) so
  that the README file shows a current version of the font.
- Branch cleanup (back to master/develop)
- Set version to 2.0.4 (next release)

## v2.0.3

- Skipping FontBakery tests on TravisCI for now
- Makefile now defaults to `help` target instead of `font`
- Build script and Makefile fixes
- Glyph simplification and composition improvements
- Adjust unitsPerEm to 2000, update `generate_derived.pe`
- Added correct foundry identifier (3270)
- Renamed base font
- Added ⁴, −
- Removed slots below 0x1f
- Set version to 2.0.3 (next release)

## v2.0.2

- Add ★, ⚑, ✚
- Instal .ttf files by default
- Set grid fit and anti-alias to all sizes
- Added SIL license to the font file
- Adjusted font name, family name and derived font names
- Force width to 540 units when building derived fonts
- Set ΤεΧ space to 540 (normal glyph width)
- Set Italic Angle to 0
- Set OS/2 Style Map to Regular
- Update copyright notice
- Sorted symbols in the SFD file
- Set version to 2.0.2 (next release)

## v2.0.1

- Added ◢, ◣, ◤, ◥, ▮, and ◆
- Use new AWS S3 vhost-based names, add HTTPS where applicable
- Set version to 2.0.1 (next release)
- New implementation for ℅, add ℆
- New implementation for ‘, ’, “, and ”

## v2.0.0

- Added ˎ, qqˏ, ː, ˑ, ˤ, ˬ, ̀, ̂, ̃, ̄, ̅, ̆, ̇, ̈, ̊, ̋, ̌, Ͱ, ͱ, Ͳ, ͳ, Ϳ, Ϗ, ϐ, ϑ,
  ϒ, ϓ, ϔ, ϖ, Ϟ, Ϸ, ϸ, Ҕ, ҕ, Җ, җ, Ҙ, ҙ, Қ, қ, Ҝ, ҝ, ҟ, Ҡ, ҡ, Ң, ң, Ҥ, ҥ,
  Ҧ, ҧ, Ҩ, ҩ, ү, Ұ, ұ, Ҳ, ҳ, Ҵ, ҵ, Ҷ, ҷ, Ҹ, ҹ, Һ, һ, Ҽ, ҽ, Ҿ, ҿ, Ӏ, ӏ, ӓ,
  Ә, ә, Ӛ, ӛ, Ӝ, ӝ, Ӟ, ӟ, Ӡ, ӡ, Ӣ, ӣ, Ӥ, ӥ, Ӧ, ӧ, Ө, ө, Ӫ, ӫ, Ӭ, ӭ, Ӯ, ӯ,
  Ӱ, ӱ, Ӳ, ӳ, Ӵ, ӵ, Ӷ, ӷ, Ӹ, ӹ, Ӻ, ӻ, Ӽ, ӽ, Ӿ, ӿ, Ԁ, ԁ, Ԅ, ԅ, Ԇ, Ԇ, ԇ, Ԉ,
  ԉ, Ԋ, ԋ, Ԍ, ԍ, Ԏ, ԏ, ※, ☮, ✕, ❌,
- Added missing Powerline symbols at the right places
- Adjust default width to 540 to better reflect underlying bitmaps
- Generated bitmap glyphs
- Added acutecomb glyph
- Fixed 𝗗, Ő, —, Ò, Ÿ
- Added math alphabets and digit ranges
- Changed default underline position
- Fixed proportions on 3x2 graphic block (not mapped yet)
- Fixed some overlap and rounding issues
- Add missing glyph slots up to uni04CF

## v1.2.23

- Simplify tilde
- Added ⎇ and ⎈
- Added APL symbols (tentative set)
- Change zip target dependency to derived instead of all (doesn't
  require PIL)

## v1.2.22

- Removed unused Hangul characters
- Added Ogham symbols
- Add missing trademark notice
- Added SIL Open Font License option
- Fix line drawing discontiuities

## v1.2.21

- Build process now uses a build folder
- Added 💖, 😪, ⇤, ⇥, 𝖠-𝟿 (math symbols), ѝ, Ѝ, ∓, ∛, ∜, ∝, ∀, ∁, ∃, ∄, ∅,
  ⏏, ↚, ↛, ∈, ∉, ∊, ∋, ∌, ∍, ∐
- Added placeholders for Ogham

## v1.2.20

- Force extension of 4 and 6 to properly render on Linux
- Added "￼", "�", "⋮", "⅟", U+e16c, "⁋", "⁎", "⁑", "Ⅰ", "Ⅴ", "Ⅹ", "Ⅼ",
  "Ⅽ", "Ⅾ", "Ⅿ", "℗", "⋎"
- Fixed "❮" and "❯"

## v1.2.19

- Added normal "⸨" and "⸩", full-width "｟" and "｠", ❮, ♡, ♢, ♤, ♧, ♁,
  ⅐, ⅑, ⅒, ⅓, ⅔, ⅕, ⅖, ⅗, ⅘, ⅙, ⅚
- Fixed "⌚", "w", "4", "6"

## v1.2.18

- Improved sample image generation (rendering can be now tested!)
- Sample image is generated in CI
- Added missing WGL4 glyphs
- Rendering fixes for "p" and "8" for lower resolution screens
- Numerous fixes (git log is your friend)

## v1.2.17

- Added glyps for ␀, ␁, ␂, ␃, ␄, ␅, ␆, ␇, ␈, ␉, ␊, ␋, ␌, ␍, ␎, ␏, ␐, ␑,
  ␒, ␓, ␔, ␕, ␖, ␗, ␘, ␙, ␚, ␛, ␜, ␝, ␞, ␟, ␠, ␡, ∇, ⏨, ⌦, ⌧ and ⌫
- Added ➜

## v1.2.16

- Added ⧻, ␢, №, Ё and ъ

## v1.2.15

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

## v1.2.14

- Added ⚓ glyph
- Added ‘ and ’ (quoteleft and quoteright)
- Added ✘ (used by Homebrew)
- Add help target to help message
- Fix the help message
- Add upped case delta glyph
- `make install` now installs on OSX

## v1.2.13

- Corrected codepoint for single beer, added two-beer glyph

## v1.2.12

- Add a beer mug (used by Homebrew)
- Fix regex in Makefile test target
- Make the powerline up arrow taller

## v1.2.11

- Add missing dotted Irish alphabet chars
- Add shorter f and t for easier accent composition
- Use wider traces for ✎
- Added a SemiNarrow variant 492 units wide

## v1.2.10

- Small fixes to a and e
- Remove StdHW and StemSnapH PostScript private dicts
- Redo and simplify 0-9, maybe fix \#6
- Added a lambda, ⬇, ⬇, ✔, ✼, ✎, u1F394 and uni21AF
- Adjustments to \<U+2753\>, ?, | and ¦

## v1.2.9

- No longer remove Debian logo on font generation
- Add Debian logo copyright and license terms to LICENSE.txt

## v1.2.8

- Resized various glyphs so that they have more consistent widths
- Simplified multiple accented chars, adjusted borders

## v1.2.7

- Add more border drawing chars
- Add hints/counterhints
- Redo $
- Simplify @
- Realign vertexes on apl\_topsolid
- Realign vertexes on CR glyph

## v1.2.6

- Get the S3 URL from the README file
- Added a check to make sure the zip file was uploaded and is accessible
- Add a simple programn to show some "Unicode art"
- Added miscellaneous glyphs
- Add ltshade, shade and dkshade glyphs (useful for progress bars)
- Add a test for the created zip file
- Added travis support
- Added ⌘ and ⏎ glyphs

## v1.2.5

- Changing the Windows font viewer screencap to a more recent Windows
- Attempting to fix hinting issues on C, Q and S observed on Windows
- ● glyph (used by systemctl)

## v1.2.4

- Updated download link, added Windows XP screenshot, removed Windows
  compatibility message
- Removed uniFFFF, which caused the Windows compatibility issues
- Add an  at U+f8ff
- Add note about anti-aliasing

## v1.2.3

- Make the T in ™ symmetrical
- Make ™ skinnier
- Make … more boldface-friendly
- Added ™ glyph
- Added double-line box-drawing glyphs used in Midnight Commander
- Add missing line drawing chars, (┬ and ┴), solve alingment issues with
  others
- Added \<\< and \>\>
- Added you-should-reboot glyph

## v1.2.1

- Fix self-intersect on composite Ccedilla (caused problems with ttf)

## v1.2

- Merge branch 'kilobyte-master'

## v1.1

- Adjusting a, e, p, w for smaller point sizes
- Added uninstall target

## v1 - Initial release

- Added "zip" target to Makefile
