.PHONY: build upload docker

build:
	mkdir -p build
	rm -rf build
	mkdir build
	yosys -p "read_verilog main.v ; synth_gowin -json build/main.json"
	nextpnr-himbaechel --json build/main.json --write build/pnrmain.json --device GW1NR-LV9QN88PC6/I5 --vopt family=GW1N-9C --vopt cst=tangnano9k.cst
	gowin_pack -d GW1N-9C -o build/pack.fs build/pnrmain.json

upload:
	openFPGALoader -b tangnano9k build/pack.fs

run:
	docker run -v .:/mnt/app -w /mnt/app -it cbergschneider/gowinc make build
	make upload