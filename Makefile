SHELL = /bin/sh

.SUFFIXES:

all: 3270Medium_HQ.sfd
	./generate_derived.pe

install: all
	cp 3270Narrow.otf 3270Medium.otf ~/.local/share/fonts

uninstall:
	rm ~/.local/share/fonts/3270Narrow.otf ~/.local/share/fonts/3270Medium.otf

zip: all
	zip 3270_fonts.zip 3270Medium.* 3270Narrow.*

clean:
	@find . -iname '*.otf' -delete -o -iname '*.ttf' -delete -o -iname '*.afm' -delete -o -iname '*.pfm' -delete -o -iname '*.woff' -delete
