all: build simulate

build:
	verilator -Wno-lint +incdir+../../../../../../rtl/verilog/axi4/pkg --cc -f system.vc --top-module mpsoc_mpram_testbench

simulate:

clean:
	rm -rf obj_dir
