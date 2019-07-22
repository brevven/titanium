
.PHONY: zip install

v = bztitanium_$(shell jq -r .version info.json)
copy:
	mkdir -p ../$(v)
	cp -rf * ../$(v)
	rm ../$(v).zip
	cd ..; zip -9 -r -y $(v).zip $(v) -x "*.xcf" -x "*.git*"


install: copy
	cp -f ../$(v).zip ../../mods/


