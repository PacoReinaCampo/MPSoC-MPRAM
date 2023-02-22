all: build simulate

build:
	if [ ! -e work ]; then vlib work; fi
	vlog -sv +incdir+../../../../../../rtl/verilog/pkg/ahb3 -f system.vc

simulate:
	vsim -c -do run.do work.peripheral_mpram_testbench

clean:
	rm -rf work transcript
