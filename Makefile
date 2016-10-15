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
	@./generate_sample_image.py

help:
	@echo "Please use \`make <target>' where <target> is one of:"
	@echo "  all        Generates the TrueType, OpenType, Type-1, WebFont files and sample image."
	@echo "  install    Copies the generated OTF fonts into the system-appropriate folder (Ubuntu, Fedora, OSX)."
	@echo "  uninstall  Uninstalls the generated OTF fonts."
	@echo "  zip        Creates the ZIP archive to be sent to S3 (the 'binary build')."
	@echo "  sample     Generate a sample image."
	@echo "  test       Generates and checks font files."
	@echo "  fulltest   Also ensures the .zip file is valid and available on S3."
	@echo "  upload     Uploads the generated .zip file to S3."
	@echo "  clean      Deletes all automatically generated files."
	@echo "  help       Displays this message."

install: all
	@install -d $(DESTFOLDER)
	@install 3270Narrow.otf 3270Medium.otf 3270SemiNarrow.otf $(DESTFOLDER)

uninstall:
	@$(RM) $(DESTFOLDER)/3270Narrow.otf $(DESTFOLDER)/3270Medium.otf $(DESTFOLDER)/3270SemiNarrow.otf

zip: all
	@zip 3270_fonts_$(shell git rev-parse --short HEAD).zip 3270Medium.* 3270SemiNarrow.* 3270Narrow.*

sample: all
	@python generate_sample_image.py

test: all
	@fontlint 3270Medium.otf
	@fontlint 3270Medium.pfm
	@fontlint 3270Medium.ttf
	@fontlint 3270Medium.woff
	@fontlint 3270SemiNarrow.otf
	@fontlint 3270SemiNarrow.ttf
	@fontlint 3270SemiNarrow.pfm
	@fontlint 3270SemiNarrow.woff
	@fontlint 3270Narrow.otf
	@fontlint 3270Narrow.ttf
	@fontlint 3270Narrow.pfm
	@fontlint 3270Narrow.woff

fulltest: zip test
	@zip -T 3270_fonts_*.zip
	@wget --spider $(shell grep -Eo 'http://s3.amazonaws.com/3270font/3270_fonts_[^/"]+\.zip' README.md)

upload: zip
	aws s3 cp 3270_fonts_$(shell git rev-parse --short HEAD).zip s3://3270font/ --acl public-read --storage-class REDUCED_REDUNDANCY

clean:
	@find . -name '*.otf' -delete -o -name '*.ttf' -delete -o -name '*.afm' -delete -o -name '*.pfm' -delete -o -name '*.woff' -delete -o -name '*.g2n' -delete -o -name '*.png' -delete
	@$(RM) 3270_fonts_*.zip 3270Medium_HQ_Narrow.sfd, 3270Medium_HQ_SemiNarrow.sfd
