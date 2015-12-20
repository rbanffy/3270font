SHELL = /bin/sh

.SUFFIXES:

help:
	@echo "Please use \`make <target>' where <target> is one of:"
	@echo "  all        Generates the TrueType, OpenType, Type-1 and WebFont files."
	@echo "  install    Copies the generated fonts into ~/.local/share/fonts"
	@echo "  uninstall  Removes the generated files from ~/.local/share/fonts"
	@echo "  zip        Creates the ZIP archive to be sent to S3 (the "binary build")"
	@echo "  test       Generates and checks font files"
	@echo "  clean      Deletes all automatically generated files."

all: 3270Medium_HQ.sfd
	@./generate_derived.pe

install: all
	@cp 3270Narrow.otf 3270Medium.otf ~/.local/share/fonts

uninstall:
	@rm -f ~/.local/share/fonts/3270Narrow.otf ~/.local/share/fonts/3270Medium.otf

zip: all
	@zip 3270_fonts_$(shell git rev-parse --short HEAD).zip 3270Medium.* 3270Narrow.*

test: zip
	@fontlint 3270Medium.otf 3270Medium.pfm 3270Medium.ttf 3270Medium.woff
	@zip -T 3270_fonts_*.zip
	@wget --spider $(shell grep -Eo 'http://s3.amazonaws.com/rbanffy/3270_fonts_[^/"]+' README.md)

clean:
	@find . -name '*.otf' -delete -o -name '*.ttf' -delete -o -name '*.afm' -delete -o -name '*.pfm' -delete -o -name '*.woff' -delete -o -name '*.g2n' -delete
	@rm -f 3270_fonts_*.zip 3270Medium_HQ_Narrow.sfd
