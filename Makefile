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
	@find . -name '*.otf' -delete -o -name '*.ttf' -delete -o -name '*.afm' -delete -o -name '*.pfm' -delete -o -name '*.woff' -delete -o -name '*.g2n' -delete
	@rm -f 3270_fonts_*.zip 3270Medium_HQ_Narrow.sfd
