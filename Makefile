SHELL = /bin/sh

.SUFFIXES:

all: 3270Medium_HQ.sfd
	./generate_derived.pe

install: all
	cp 3270Narrow.otf 3270Medium.otf ~/.local/share/fonts

clean:
	@find . -iname '*.otf' -delete -o -iname '*.ttf' -delete -o -iname '*.afm' -delete -o -iname '*.pfm' -delete -o -iname '*.woff' -delete
