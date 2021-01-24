# General makefile for factorio mods.
#
# Presumes the development work is done in a <factoriodir>/dev/<modname>/
# directory where this makefile resides.  This directory must be parallel to
# the <factoriodir>/mods/ directory where mods are installed. Run `make
# install` from dev/<modname> to install the mod as a zip file. That zip file
# should also be ready to upload to the mod portal

.PHONY: copy install

pwd = $(shell pwd)
v = $(shell basename "$(pwd)")_$(shell jq -r .version info.json)

copy:
	rm -rf ../$(v)
	mkdir -p ../$(v)
	cp -rf * ../$(v)
	rm -f ../$(v).zip
	cd ..; zip -9 -r -y $(v).zip $(v) -x "*.xcf" -x "*.git*" -x "*.bak" 


install: copy
	cp -f ../$(v).zip ../../mods/

