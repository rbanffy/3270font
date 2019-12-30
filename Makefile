.PHONY: clean help all font test fbchecks upload
.DEFAULT_GOAL := help

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

define PRINT_HELP_PYSCRIPT
import re, sys

for line in sys.stdin:
	match = re.match(r'^([a-zA-Z_-]+):.*?## (.*)$$', line)
	if match:
		target, help = match.groups()
		print("%-10s %s" % (target, help))
endef
export PRINT_HELP_PYSCRIPT

help: ## Displays this message.
	@echo "Please use \`make <target>' where <target> is one of:"
	@python -c "$$PRINT_HELP_PYSCRIPT" < $(MAKEFILE_LIST)

all: font sample ## Generates the TrueType, OpenType, Type-1, WebFont files and sample image."

font: 3270_HQ.sfd fonts-3270.metainfo.xml ## Generates the font files from the SFD
	@$(MKDIR_P) ${BUILD_DIR}
	@./generate_derived.pe 2> /dev/null >&2
	@cp fonts-3270.metainfo.xml ${BUILD_DIR}

sample: font ## Generate a sample image
	@./generate_sample_image.py

install: font ## Copies the generated OTF fonts into the system-appropriate folder (Ubuntu, Fedora, OSX).
	@install -d $(DESTFOLDER)
	@install ${BUILD_DIR}/3270Condensed-Regular.ttf ${BUILD_DIR}/3270-Regular.ttf ${BUILD_DIR}/3270SemiCondensed-Regular.ttf $(DESTFOLDER)

uninstall: ## Uninstalls the generated fonts
	@$(RM) $(DESTFOLDER)/3270Condensed-Regular.ttf $(DESTFOLDER)/3270-Regular.ttf $(DESTFOLDER)/3270SemiCondensed-Regular.ttf

zip: font ## Creates the ZIP archive to be sent to S3 (the 'binary build')
	@zip -j ${BUILD_DIR}/3270_fonts_$(shell git rev-parse --short HEAD).zip ${BUILD_DIR}/3270-Regular.* ${BUILD_DIR}/3270SemiCondensed-Regular.* ${BUILD_DIR}/3270Condensed-Regular.* LICENSE.txt fonts-3270.metainfo.xml

fbchecks: font ## Runs the Font Bakery set of tests required by Google Fonts
	@./fontbakery_checks.sh

skimpytest: font ## Runs the minimal tests
	@fontlint ${BUILD_DIR}/3270-Regular.otf
	@fontlint ${BUILD_DIR}/3270-Regular.ttf
	@fontlint ${BUILD_DIR}/3270-Regular.woff
	@fontlint ${BUILD_DIR}/3270SemiCondensed-Regular.ttf
	@fontlint ${BUILD_DIR}/3270Condensed-Regular.ttf

test: skimpytest ## Generates and checks font files
# These are tests that fail on Travis (because their fontlint can't ignore stuff).
# Yes. This is "works on my computer".
	@fontlint -i 98 ${BUILD_DIR}/3270SemiCondensed-Regular.otf
	@fontlint -i 98 ${BUILD_DIR}/3270SemiCondensed-Regular.ttf
	@fontlint -i 98 ${BUILD_DIR}/3270SemiCondensed-Regular.woff
	@fontlint -i 98 ${BUILD_DIR}/3270Condensed-Regular.otf
	@fontlint -i 98 ${BUILD_DIR}/3270Condensed-Regular.ttf
	@fontlint -i 98 ${BUILD_DIR}/3270Condensed-Regular.woff

travistest: zip skimpytest ## Runs the Travis CI set of tests

fulltest: zip test fbchecks ## Runs the full set of tests and verifies the ZIP file mentioned in the README is present.
	@zip -T ${BUILD_DIR}/3270_fonts_*.zip
	@wget --spider $(shell grep -Eo 'https://3270font.s3.amazonaws.com/3270_fonts_[^/"]+\.zip' README.md)

upload: zip ## Uploads the generated .zip file to S3
	aws s3 cp ${BUILD_DIR}/3270_fonts_$(shell git rev-parse --short HEAD).zip s3://3270font/ --acl public-read --storage-class REDUCED_REDUNDANCY

clean: ## Deletes all automatically generated files
	@$(RM) -rf ${BUILD_DIR}
	@$(RM) -rf gfonts_files/*/DESCRIPTION.*.html
	@$(RM) -rf gfonts_files/*/LICENSE.txt
	@$(RM) -rf gfonts_files/*/3270*.ttf
	@$(RM) -rf gfonts_files/*/3270*.ttf.xml
	@$(RM) -rf Fontbakery-check-results.md
