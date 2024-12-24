run: vbuild

prepare:
	mkdir -p build

vbuild: prepare
	yosys -p "synth_gowin -top counter -json build/counter.json" counter.v
	nextpnr-gowin --json build/counter.json --freq 27 --write build/counter_pnr.json --device GW1NR-LV9QN88PC6/I5 --family GW1N-9C --cst tangnano9k.cst
	gowin_pack -d GW1N-9C -o build/counter.fs build/counter_pnr.json
	