SHELL = /bin/sh
UNAME = $(shell uname)

ifeq ($(UNAME),Linux)
	DESTFOLDER=~/.local/share/fonts
endif
ifeq ($(UNAME),Darwin)
	DESTFOLDER=~/Library/Fonts
endif

.SUFFIXES:

all: 3270Medium_HQ.sfd
	@./generate_derived.pe

help:
	@echo "Please use \`make <target>' where <target> is one of:"
	@echo "  all        Generates the TrueType, OpenType, Type-1 and WebFont files."
	@echo "  install    Copies the generated OTF fonts into the system-appropriate folder (Ubuntu, Fedora, OSX)."
	@echo "  uninstall  Uninstalls the generated OTF fonts."
	@echo "  zip        Creates the ZIP archive to be sent to S3 (the 'binary build')."
	@echo "  test       Generates and checks font files."
	@echo "  fulltest   Also ensures the .zip file is valid and available on S3."
	@echo "  clean      Deletes all automatically generated files."
	@echo "  help       Displays this message."

install: all
	@install -d $(DESTFOLDER)
	@install 3270Narrow.otf 3270Medium.otf 3270SemiNarrow.otf $(DESTFOLDER)

uninstall:
	@$(RM) $(DESTFOLDER)/3270Narrow.otf $(DESTFOLDER)/3270Medium.otf $(DESTFOLDER)/3270SemiNarrow.otf

zip: all
	@zip 3270_fonts_$(shell git rev-parse --short HEAD).zip 3270Medium.* 3270SemiNarrow.* 3270Narrow.*

test: all
	fontlint 3270Medium.otf
	fontlint 3270Medium.pfm
	fontlint 3270Medium.ttf
	fontlint 3270Medium.woff
	fontlint 3270SemiNarrow.otf
	fontlint 3270SemiNarrow.ttf
	fontlint 3270SemiNarrow.pfm
	fontlint 3270SemiNarrow.woff
	fontlint 3270Narrow.otf
	fontlint 3270Narrow.ttf
	fontlint 3270Narrow.pfm
	fontlint 3270Narrow.woff

fulltest: zip test
	@zip -T 3270_fonts_*.zip
	@wget --spider $(shell grep -Eo 'http://s3.amazonaws.com/rbanffy/3270_fonts_[^/"]+\.zip' README.md)

clean:
	@find . -name '*.otf' -delete -o -name '*.ttf' -delete -o -name '*.afm' -delete -o -name '*.pfm' -delete -o -name '*.woff' -delete -o -name '*.g2n' -delete
	@$(RM) 3270_fonts_*.zip 3270Medium_HQ_Narrow.sfd, 3270Medium_HQ_SemiNarrow.sfd
