SHELL = /bin/sh

.SUFFIXES:

all: 3270Medium_HQ.sfd
	./generate_derived.pe

install: all
	cp 3270Narrow.otf 3270Medium.otf ~/.fonts

clean:
	rm *.otf *.ttf *.afm *.pfm 3270Medium_HQ_Narrow.sfd
