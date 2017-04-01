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

derived: 3270Medium_HQ.sfd
	@ ${MKDIR_P} ${BUILD_DIR}
	@./generate_derived.pe

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
	@install ${BUILD_DIR}/3270Narrow.otf ${BUILD_DIR}/3270Medium.otf ${BUILD_DIR}/3270SemiNarrow.otf $(DESTFOLDER)

uninstall:
	@$(RM) $(DESTFOLDER)/3270Narrow.otf $(DESTFOLDER)/3270Medium.otf $(DESTFOLDER)/3270SemiNarrow.otf

zip: all
	@zip -j ${BUILD_DIR}/3270_fonts_$(shell git rev-parse --short HEAD).zip ${BUILD_DIR}/3270Medium.* ${BUILD_DIR}/3270SemiNarrow.* ${BUILD_DIR}/3270Narrow.* LICENSE.txt

test: derived
	@fontlint ${BUILD_DIR}/3270Medium.otf
	@fontlint ${BUILD_DIR}/3270Medium.pfm
	@fontlint ${BUILD_DIR}/3270Medium.ttf
	@fontlint ${BUILD_DIR}/3270Medium.woff
	@fontlint ${BUILD_DIR}/3270SemiNarrow.otf
	@fontlint ${BUILD_DIR}/3270SemiNarrow.ttf
	@fontlint ${BUILD_DIR}/3270SemiNarrow.pfm
	@fontlint ${BUILD_DIR}/3270SemiNarrow.woff
	@fontlint ${BUILD_DIR}/3270Narrow.otf
	@fontlint ${BUILD_DIR}/3270Narrow.ttf
	@fontlint ${BUILD_DIR}/3270Narrow.pfm
	@fontlint ${BUILD_DIR}/3270Narrow.woff

fulltest: zip test
	@zip -T ${BUILD_DIR}/3270_fonts_*.zip
	@wget --spider $(shell grep -Eo 'http://s3.amazonaws.com/3270font/3270_fonts_[^/"]+\.zip' README.md)

upload: zip
	aws s3 cp ${BUILD_DIR}/3270_fonts_$(shell git rev-parse --short HEAD).zip s3://3270font/ --acl public-read --storage-class REDUCED_REDUNDANCY

clean:
	@$(RM) -rf ${BUILD_DIR}
