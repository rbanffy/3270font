SHELL = /bin/sh

.SUFFIXES:

all: 3270Medium_HQ.sfd
	./generate_derived.pe

install: 3270Narrow.otf 3270Medium.otf
	cp 3270Narrow.otf 3270Medium.otf ~/.fonts

clean:
	rm *.otf *.ttf *.afm *.pfm