#!/usr/bin/env python3

import unittest

from fontTools.pens.boundsPen import BoundsPen
from fontTools.ttLib import TTFont

EXPECTED_LIGATURES = {
    ("hyphen", "greater"): "lig_arrowright",
    ("less", "hyphen"): "lig_arrowleft",
    ("equal", "greater"): "lig_implies",
    ("less", "hyphen", "greater"): "lig_arrowboth",
    ("less", "equal", "greater"): "lig_iff",
    ("exclam", "equal"): "lig_notequal",
    ("less", "equal"): "lig_lessequal",
    ("greater", "equal"): "lig_greaterequal",
    ("equal", "equal", "equal"): "lig_equiv",
    ("equal", "equal"): "lig_equal",
    ("less", "less"): "lig_shiftleft",
    ("greater", "greater"): "lig_shiftright",
    ("period", "period", "period"): "lig_ellipsis",
    ("period", "period"): "lig_range",
    ("question", "question"): "lig_nullish",
    ("question", "period"): "lig_optional",
    ("question", "colon"): "lig_ternary",
    ("asterisk", "asterisk"): "lig_power",
    ("colon", "equal"): "lig_assign",
    ("bar", "bar"): "lig_or",
    ("colon", "colon"): "lig_scope",
    ("slash", "slash"): "lig_linecomment",
    ("slash", "asterisk"): "lig_commentstart",
    ("asterisk", "slash"): "lig_commentend",
    ("plus", "plus"): "lig_increment",
    ("hyphen", "hyphen"): "lig_decrement",
    ("exclam", "exclam"): "lig_doubleexclamation",
}

SOURCE_GLYPHS = (
    "hyphen",
    "greater",
    "less",
    "equal",
    "exclam",
    "notequal",
    "lessequal",
    "greaterequal",
    "equivalence",
    "arrowleft",
    "arrowright",
    "arrowboth",
    "arrowdblright",
)

FONT_FILES = tuple(
    f"build/{family}-Regular.{extension}"
    for family in ("3270", "3270SemiCondensed", "3270Condensed")
    for extension in ("otf", "ttf", "woff")
)


def ligature_substitutions(font):
    result = {}
    gsub = font["GSUB"].table
    feature_records = gsub.FeatureList.FeatureRecord
    lookup_list = gsub.LookupList.Lookup

    for feature in feature_records:
        if feature.FeatureTag != "liga":
            continue
        for lookup_index in feature.Feature.LookupListIndex:
            lookup = lookup_list[lookup_index]
            if lookup.LookupType != 4:
                continue
            for subtable in lookup.SubTable:
                if hasattr(subtable, "ligatures"):
                    ligature_sets = subtable.ligatures.items()
                else:
                    ligature_sets = zip(
                        subtable.Coverage.glyphs, subtable.LigatureSet
                    )
                for first, ligature_set in ligature_sets:
                    ligatures = getattr(ligature_set, "Ligature", ligature_set)
                    for ligature in ligatures:
                        components = (first, *ligature.Component)
                        result[components] = ligature.LigGlyph

    return result


class LigatureFontTest(unittest.TestCase):
    def test_generated_fonts_have_expected_ligatures(self):
        for filename in FONT_FILES:
            with self.subTest(font=filename):
                font = TTFont(filename)
                substitutions = ligature_substitutions(font)
                glyph_order = font.getGlyphOrder()
                advances = font["hmtx"].metrics
                cell_width = advances["hyphen"][0]
                for sequence, glyph in EXPECTED_LIGATURES.items():
                    self.assertEqual(substitutions.get(sequence), glyph)
                    self.assertIn(glyph, glyph_order)
                    self.assertEqual(
                        advances[glyph][0],
                        cell_width * len(sequence),
                        f"{glyph} must preserve the input text width",
                    )
                for glyph in SOURCE_GLYPHS:
                    self.assertIn(glyph, glyph_order)
                self.assertNotIn("lig_and", glyph_order)
                self.assertNotIn(("ampersand", "ampersand"), substitutions)
                glyph_set = font.getGlyphSet()
                reference_pen = BoundsPen(glyph_set)
                glyph_set["lig_implies"].draw(reference_pen)
                reference_width = (
                    reference_pen.bounds[2] - reference_pen.bounds[0]
                )
                for glyph in ("lig_arrowboth", "lig_iff"):
                    pen = BoundsPen(glyph_set)
                    glyph_set[glyph].draw(pen)
                    glyph_width = pen.bounds[2] - pen.bounds[0]
                    self.assertLessEqual(
                        abs(glyph_width - reference_width),
                        reference_width * 0.05,
                        f"{glyph} width should match lig_implies",
                    )
                font.close()


if __name__ == "__main__":
    unittest.main()
