.PHONY: clean help all font test fbchecks upload sample cask
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
	FONTCASKER="$(shell brew --repository)/Library/Taps/homebrew/homebrew-cask-fonts/developer/bin/font_casker"
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
	@python3 -c "$$PRINT_HELP_PYSCRIPT" < $(MAKEFILE_LIST)

all: font sample ## Generates the TrueType, OpenType, Type-1, WebFont files and sample image."

${BUILD_DIR}/3270_HQ_unencumbered.sfd ${BUILD_DIR}/3270-Regular.otf ${BUILD_DIR}/3270-Regular.g2n ${BUILD_DIR}/3270-Regular.ttf ${BUILD_DIR}/3270-Regular.pfm ${BUILD_DIR}/3270-Regular.woff ${BUILD_DIR}/3270-Regular.woff2 ${BUILD_DIR}/3270-Regular.svg ${BUILD_DIR}/3270SemiCondensed-Regular.otf ${BUILD_DIR}/3270SemiCondensed-Regular.g2n ${BUILD_DIR}/3270SemiCondensed-Regular.ttf ${BUILD_DIR}/3270SemiCondensed-Regular.pfm ${BUILD_DIR}/3270SemiCondensed-Regular.woff ${BUILD_DIR}/3270SemiCondensed-Regular.woff2 ${BUILD_DIR}/3270SemiCondensed-Regular.svg ${BUILD_DIR}/3270_HQ_SemiCondensed.sfd ${BUILD_DIR}/3270Condensed-Regular.otf ${BUILD_DIR}/3270Condensed-Regular.g2n ${BUILD_DIR}/3270Condensed-Regular.ttf ${BUILD_DIR}/3270Condensed-Regular.pfm ${BUILD_DIR}/3270Condensed-Regular.woff ${BUILD_DIR}/3270Condensed-Regular.woff2 ${BUILD_DIR}/3270Condensed-Regular.svg ${BUILD_DIR}/3270_HQ_Condensed.sfd: 3270_HQ.sfd
	@$(MKDIR_P) ${BUILD_DIR}
	@./generate_derived.pe 2> /dev/null >&2

font: ${BUILD_DIR}/3270_HQ_unencumbered.sfd ${BUILD_DIR}/3270-Regular.otf ${BUILD_DIR}/3270-Regular.g2n ${BUILD_DIR}/3270-Regular.ttf ${BUILD_DIR}/3270-Regular.pfm ${BUILD_DIR}/3270-Regular.woff ${BUILD_DIR}/3270-Regular.woff2 ${BUILD_DIR}/3270-Regular.svg ${BUILD_DIR}/3270SemiCondensed-Regular.otf ${BUILD_DIR}/3270SemiCondensed-Regular.g2n ${BUILD_DIR}/3270SemiCondensed-Regular.ttf ${BUILD_DIR}/3270SemiCondensed-Regular.pfm ${BUILD_DIR}/3270SemiCondensed-Regular.woff ${BUILD_DIR}/3270SemiCondensed-Regular.woff2 ${BUILD_DIR}/3270SemiCondensed-Regular.svg ${BUILD_DIR}/3270_HQ_SemiCondensed.sfd ${BUILD_DIR}/3270Condensed-Regular.otf ${BUILD_DIR}/3270Condensed-Regular.g2n ${BUILD_DIR}/3270Condensed-Regular.ttf ${BUILD_DIR}/3270Condensed-Regular.pfm ${BUILD_DIR}/3270Condensed-Regular.woff ${BUILD_DIR}/3270Condensed-Regular.woff2 ${BUILD_DIR}/3270Condensed-Regular.svg ${BUILD_DIR}/3270_HQ_Condensed.sfd ## Generates the font files from the SFD
	@cp fonts-3270.metainfo.xml ${BUILD_DIR}

${BUILD_DIR}/3270_sample.gif: ${BUILD_DIR}/3270_HQ_unencumbered.sfd ${BUILD_DIR}/3270-Regular.otf ${BUILD_DIR}/3270-Regular.g2n ${BUILD_DIR}/3270-Regular.ttf ${BUILD_DIR}/3270-Regular.pfm ${BUILD_DIR}/3270-Regular.woff ${BUILD_DIR}/3270-Regular.woff2 ${BUILD_DIR}/3270-Regular.svg ${BUILD_DIR}/3270SemiCondensed-Regular.otf ${BUILD_DIR}/3270SemiCondensed-Regular.g2n ${BUILD_DIR}/3270SemiCondensed-Regular.ttf ${BUILD_DIR}/3270SemiCondensed-Regular.pfm ${BUILD_DIR}/3270SemiCondensed-Regular.woff ${BUILD_DIR}/3270SemiCondensed-Regular.woff2 ${BUILD_DIR}/3270SemiCondensed-Regular.svg ${BUILD_DIR}/3270_HQ_SemiCondensed.sfd ${BUILD_DIR}/3270Condensed-Regular.otf ${BUILD_DIR}/3270Condensed-Regular.g2n ${BUILD_DIR}/3270Condensed-Regular.ttf ${BUILD_DIR}/3270Condensed-Regular.pfm ${BUILD_DIR}/3270Condensed-Regular.woff ${BUILD_DIR}/3270Condensed-Regular.woff2 ${BUILD_DIR}/3270Condensed-Regular.svg
	@./generate_sample_image.py

sample: font ${BUILD_DIR}/3270_sample.gif

${BUILD_DIR}/urxvt.png: ${BUILD_DIR}/3270-Regular.ttf
ifeq ($(UNAME),Linux)
	@urxvt -fn "xft:IBM3270:size=12" --geometry 80x25 -fg white \
		-bg black -e ./test_font_rendering.sh urxvt
endif

${BUILD_DIR}/terminator.png: ${BUILD_DIR}/3270-Regular.ttf
ifeq ($(UNAME),Linux)
	@terminator -p 3270font -e './test_font_rendering.sh terminator'
endif

${BUILD_DIR}/xterm.png: ${BUILD_DIR}/3270-Regular.ttf
ifeq ($(UNAME),Linux)
	@xterm -fa 'IBM3270' -fs 12 -geometry 80x25 -e \
		'./test_font_rendering.sh xterm'
endif

${BUILD_DIR}/konsole.png: ${BUILD_DIR}/3270-Regular.ttf
ifeq ($(UNAME),Linux)
	@konsole -p font='IBM3270, 12' -e './test_font_rendering.sh konsole'
endif

${BUILD_DIR}/gnome-terminal.png: ${BUILD_DIR}/3270-Regular.ttf
ifeq ($(UNAME),Linux)
	@gnome-terminal --profile='3270font-test' -q --geometry=80x25 \
		-- sh -c './test_font_rendering.sh gnome-terminal'
endif

install: ${BUILD_DIR}/3270Condensed-Regular.ttf ${BUILD_DIR}/3270-Regular.ttf ${BUILD_DIR}/3270SemiCondensed-Regular.ttf ## Copies the generated OTF fonts into the system-appropriate folder (Ubuntu, Fedora, OSX).
	@install -d $(DESTFOLDER)
	@install ${BUILD_DIR}/3270Condensed-Regular.ttf \
		${BUILD_DIR}/3270-Regular.ttf \
		${BUILD_DIR}/3270SemiCondensed-Regular.ttf $(DESTFOLDER)

uninstall: ## Uninstalls the generated fonts
	@$(RM) $(DESTFOLDER)/3270Condensed-Regular.ttf \
		$(DESTFOLDER)/3270-Regular.ttf \
		$(DESTFOLDER)/3270SemiCondensed-Regular.ttf

zip: ${BUILD_DIR}/3270_HQ_unencumbered.sfd ${BUILD_DIR}/3270-Regular.otf ${BUILD_DIR}/3270-Regular.g2n ${BUILD_DIR}/3270-Regular.ttf ${BUILD_DIR}/3270-Regular.pfm ${BUILD_DIR}/3270-Regular.woff ${BUILD_DIR}/3270-Regular.woff2 ${BUILD_DIR}/3270-Regular.svg ${BUILD_DIR}/3270SemiCondensed-Regular.otf ${BUILD_DIR}/3270SemiCondensed-Regular.g2n ${BUILD_DIR}/3270SemiCondensed-Regular.ttf ${BUILD_DIR}/3270SemiCondensed-Regular.pfm ${BUILD_DIR}/3270SemiCondensed-Regular.woff ${BUILD_DIR}/3270SemiCondensed-Regular.woff2 ${BUILD_DIR}/3270SemiCondensed-Regular.svg ${BUILD_DIR}/3270_HQ_SemiCondensed.sfd ${BUILD_DIR}/3270Condensed-Regular.otf ${BUILD_DIR}/3270Condensed-Regular.g2n ${BUILD_DIR}/3270Condensed-Regular.ttf ${BUILD_DIR}/3270Condensed-Regular.pfm ${BUILD_DIR}/3270Condensed-Regular.woff ${BUILD_DIR}/3270Condensed-Regular.woff2 ${BUILD_DIR}/3270Condensed-Regular.svg ${BUILD_DIR}/3270_HQ_Condensed.sfd ## Creates the ZIP archive to be sent to S3 (the 'binary build')
	@zip -j ${BUILD_DIR}/3270_fonts_$(shell \
		git rev-parse --short HEAD).zip \
		${BUILD_DIR}/3270-Regular.* \
		${BUILD_DIR}/3270SemiCondensed-Regular.* \
		${BUILD_DIR}/3270Condensed-Regular.* \
		LICENSE.txt \
		fonts-3270.metainfo.xml

fbchecks: font ## Runs the Font Bakery set of tests required by Google Fonts
	@./fontbakery_checks.sh

ttftest: ${BUILD_DIR}/3270-Regular.ttf ${BUILD_DIR}/3270Condensed-Regular.ttf ${BUILD_DIR}/3270SemiCondensed-Regular.ttf ## Runs the minimal tests and verifies the ZIP file mentioned in the README is present.
	@flake8 *.py
	@isort --check-only *.py
	@black --check -l79 *.py
	@shellcheck *.sh
# Checks we may need to ignore
# 2 Self-intersecting glyph
# 5 Missing points at extrema
# 23 Overlapping hints in a glyph
# 34 Bad 'CFF ' table
# 98 Self-intersecting glyph (issue #2) when FontForge is able to correct this
	fontlint ${BUILD_DIR}/3270-Regular.ttf
	fontlint -w 2 -w 98 ${BUILD_DIR}/3270Condensed-Regular.ttf
	fontlint -w 2 -w 5 ${BUILD_DIR}/3270SemiCondensed-Regular.ttf

# Verify if the README points to an existing ZIP file
	@wget --spider $(shell grep -Eo \
		'https://3270font.s3.amazonaws.com/3270_fonts_[^/"]+\.zip' \
		README.md)

travistest: help zip ttftest ## Runs the Travis CI set of tests

test: zip ttftest ## Runs more extensive tests
# Checks we may need to ignore
# 2 Self-intersecting glyph
# 5 Missing points at extrema
# 23 Overlapping hints in a glyph
# 34 Bad 'CFF ' table
# 98 Self-intersecting glyph (issue #2) when FontForge is able to correct this
	fontlint -w 2 -w 98 ${BUILD_DIR}/3270-Regular.otf
	fontlint -w 2 -w 98 ${BUILD_DIR}/3270-Regular.woff
	fontlint -w 2 -w 98 ${BUILD_DIR}/3270-Regular.woff2
	fontlint -w 2 -w 5 -w 98 ${BUILD_DIR}/3270SemiCondensed-Regular.otf
	fontlint -w 2 -w 5 -w 98 ${BUILD_DIR}/3270SemiCondensed-Regular.woff
	fontlint -w 2 -w 5 -w 98 ${BUILD_DIR}/3270SemiCondensed-Regular.woff2
	fontlint -w 2 -w 98 ${BUILD_DIR}/3270Condensed-Regular.otf
	fontlint -w 2 -w 98 ${BUILD_DIR}/3270Condensed-Regular.woff
	fontlint -w 2 -w 98 ${BUILD_DIR}/3270Condensed-Regular.woff2

fulltest: test fbchecks ## Runs the full set of tests
	@zip -T ${BUILD_DIR}/3270_fonts_*.zip

upload: zip ${BUILD_DIR}/3270_sample.gif ${BUILD_DIR}/urxvt.png ${BUILD_DIR}/terminator.png ${BUILD_DIR}/xterm.png ${BUILD_DIR}/konsole.png ${BUILD_DIR}/gnome-terminal.png ## Uploads the generated .zip and sample files to S3
	@aws s3 cp ${BUILD_DIR}/3270_fonts_$(shell \
		git rev-parse --short HEAD).zip \
		s3://3270font/ \
		--acl public-read \
		--storage-class REDUCED_REDUNDANCY
	@aws s3 cp ${BUILD_DIR}/3270_sample.gif s3://3270font/ --acl public-read \
		--storage-class REDUCED_REDUNDANCY
ifeq ($(UNAME),Linux)
	@aws s3 cp ${BUILD_DIR}/gnome-terminal.png s3://3270font/ --acl public-read \
		--storage-class REDUCED_REDUNDANCY
	@aws s3 cp ${BUILD_DIR}/konsole.png s3://3270font/ --acl public-read \
		--storage-class REDUCED_REDUNDANCY
	@aws s3 cp ${BUILD_DIR}/terminator.png s3://3270font/ --acl public-read \
		--storage-class REDUCED_REDUNDANCY
	@aws s3 cp ${BUILD_DIR}/xterm.png s3://3270font/ --acl public-read \
		--storage-class REDUCED_REDUNDANCY
	@aws s3 cp ${BUILD_DIR}/urxvt.png s3://3270font/ --acl public-read \
		--storage-class REDUCED_REDUNDANCY
endif
	@./clean_camo_cache.sh

clean: ## Deletes all automatically generated files
	@$(RM) -rfv ${BUILD_DIR}
	@$(RM) -rfv gfonts_files/3270/*.ttf gfonts_files/3270/*.html \
		gfonts_files/3270/*.txt
	@$(RM) -rfv gfonts_files/3270condensed/*
	@$(RM) -rfv gfonts_files/3270semicondensed/*

cask: zip ## Generate the font cask file (requires Homebrew)
ifeq ($(UNAME),Darwin)
	@${FONTCASKER} ${BUILD_DIR}/3270_fonts_$(shell git rev-parse --short HEAD).zip
endif

image: ## Builds the container image
	docker build -t 3270font:latest .

generate: ## Generates the fonts using the container image
	docker run --rm -v ${PWD}:/opt:Z 3270font:latest make font
