# General makefile for factorio mods.
#
# Presumes the development work is done in a <factoriodir>/dev/<modname>/
# directory where this makefile resides.  This directory must be parallel to
# the <factoriodir>/mods/ directory where mods are installed. Run `make
# install` from dev/<modname> to install the mod as a zip file. That zip file
# should also be ready to upload to the mod portal

.PHONY: copy lint-changelog install

libdir = "../bzlib"
libfiles = $(shell ls $(libdir)/*.lua | grep -o '[^/]*.lua')
pwd = $(shell pwd)
v = $(shell basename "$(pwd)")_$(shell jq -r .version info.json)

link:
	for f in $(libfiles) ; do \
		echo "using $(libdir)/$$f" ;\
		cp $(libdir)/$$f .; \
	done; 

copy: link
	rm -rf ../$(v)
	mkdir -p ../$(v)
	cp -rf * ../$(v)
	rm -f ../$(v).zip
	cd ..; zip -9 -r -y $(v).zip $(v) -x "*.xcf" -x "*.git*" -x "*.bak" -x "*.blend*"

install: lint-changelog copy
	cp -f ../$(v).zip ../../mods/

lint-changelog: copy
	python3 ../da-changelog-tools_0.0.14/changelog-checker.py --changelog ../$(v).zip

zorro:
	python3 ../da-changelog-tools_0.0.14/changelog-checker.py --zorro --changelog ../$(v).zip

