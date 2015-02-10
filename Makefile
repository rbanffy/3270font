SHELL = /bin/sh

.SUFFIXES:

all: 3270Medium_HQ.sfd
	./generate_derived.pe

install: all
	cp 3270Narrow.otf 3270Medium.otf ~/.local/share/fonts

uninstall:
	rm -f ~/.local/share/fonts/3270Narrow.otf ~/.local/share/fonts/3270Medium.otf

zip: all
	zip 3270_fonts_$(shell git rev-parse --short HEAD).zip 3270Medium.* 3270Narrow.*

clean:
	@find . -iname '*.otf' -delete -o -iname '*.ttf' -delete -o -iname '*.afm' -delete -o -iname '*.pfm' -delete -o -iname '*.woff' -delete
	@rm -f 3270_fonts_*.zip
