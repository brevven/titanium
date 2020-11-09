.PHONY: copy install

v = bztitanium_$(shell jq -r .version info.json)

copy:
	rm -rf ../$(v)
	mkdir -p ../$(v)
	cp -rf * ../$(v)
	rm -f ../$(v).zip
	cd ..; zip -9 -r -y $(v).zip $(v) -x "*.xcf" -x "*.git*" -x "*.bak" 


install: copy
	cp -f ../$(v).zip ../../mods/

