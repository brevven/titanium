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

