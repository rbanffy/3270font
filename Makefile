SHELL = /bin/sh
UNAME = $(shell uname)
MKDIR_P = mkdir -p
BUILD_DIR = build

ifeq ($(UNAME),Linux)
	DESTFOLDER=~/.local/share/fonts
endif
ifeq ($(UNAME),Darwin)
	DESTFOLDER=~/Library/Fonts
endif

.SUFFIXES:

all: derived sample

font: derived

derived: 3270_HQ.sfd
	@$(MKDIR_P) ${BUILD_DIR}
	@./generate_derived.pe
	@cp fonts-3270.metainfo.xml ${BUILD_DIR}

sample: derived
	@./generate_sample_image.py

help:
	@echo "Please use \`make <target>' where <target> is one of:"
	@echo "  all        Generates the TrueType, OpenType, Type-1, WebFont files and sample image."
	@echo "  font       Generates the font, as with 'all', without the sample image"
	@echo "  install    Copies the generated OTF fonts into the system-appropriate folder (Ubuntu, Fedora, OSX)."
	@echo "  uninstall  Uninstalls the generated OTF fonts."
	@echo "  zip        Creates the ZIP archive to be sent to S3 (the 'binary build')."
	@echo "  sample     Generate a sample image."
	@echo "  test       Generates and checks font files."
	@echo "  fulltest   Also ensures the .zip file is valid and available on S3."
	@echo "  upload     Uploads the generated .zip file to S3."
	@echo "  clean      Deletes all automatically generated files."
	@echo "  help       Displays this message."

install: derived
	@install -d $(DESTFOLDER)
	@install ${BUILD_DIR}/3270Condensed-Regular.ttf ${BUILD_DIR}/3270-Regular.ttf ${BUILD_DIR}/3270SemiCondensed-Regular.ttf $(DESTFOLDER)

uninstall:
	@$(RM) $(DESTFOLDER)/3270Condensed-Regular.ttf $(DESTFOLDER)/3270-Regular.ttf $(DESTFOLDER)/3270SemiCondensed-Regular.ttf

zip: derived
	@zip -j ${BUILD_DIR}/3270_fonts_$(shell git rev-parse --short HEAD).zip ${BUILD_DIR}/3270-Regular.* ${BUILD_DIR}/3270SemiCondensed-Regular.* ${BUILD_DIR}/3270Condensed-Regular.* LICENSE.txt fonts-3270.metainfo.xml

fbchecks: derived
	./fontbakery_checks.sh

skimpytest: derived fbchecks
	fontlint ${BUILD_DIR}/3270-Regular.otf
	fontlint ${BUILD_DIR}/3270-Regular.ttf
	fontlint ${BUILD_DIR}/3270-Regular.woff
	fontlint ${BUILD_DIR}/3270SemiCondensed-Regular.ttf
	fontlint ${BUILD_DIR}/3270Condensed-Regular.ttf

test: skimpytest fbchecks
# These are tests that fail on Travis (because their fontlint can't ignore stuff).
# Yes. This is "works on my computer".
	fontlint -i 98 ${BUILD_DIR}/3270SemiCondensed-Regular.otf
	fontlint -i 98 ${BUILD_DIR}/3270SemiCondensed-Regular.pfm
	fontlint -i 98 ${BUILD_DIR}/3270SemiCondensed-Regular.woff
	fontlint -i 98 ${BUILD_DIR}/3270Condensed-Regular.otf
	fontlint -i 98 ${BUILD_DIR}/3270Condensed-Regular.woff

travistest: zip skimpytest

fulltest: zip test
	@zip -T ${BUILD_DIR}/3270_fonts_*.zip
	@wget --spider $(shell grep -Eo 'https://3270font.s3.amazonaws.com/3270_fonts_[^/"]+\.zip' README.md)

upload: zip
	aws s3 cp ${BUILD_DIR}/3270_fonts_$(shell git rev-parse --short HEAD).zip s3://3270font/ --acl public-read --storage-class REDUCED_REDUNDANCY

clean:
	@$(RM) -rf ${BUILD_DIR}
	@$(RM) -rf gfonts_files/*/DESCRIPTION.*.html
	@$(RM) -rf gfonts_files/*/LICENSE.txt
	@$(RM) -rf gfonts_files/*/3270*.ttf
	@$(RM) -rf gfonts_files/*/3270*.ttf.xml
	@$(RM) -rf Fontbakery-check-results.md
