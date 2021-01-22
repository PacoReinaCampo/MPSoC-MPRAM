all: build simulate

build:
	ghdl -a --std=08 ../../../../../rtl/vhdl/wb/pkg/mpsoc_mpram_wb_pkg.vhd
	ghdl -a --std=08 ../../../../../rtl/vhdl/wb/core/mpsoc_wb_ram_generic.vhd
	ghdl -a --std=08 ../../../../../rtl/vhdl/wb/core/mpsoc_wb_mpram.vhd
	ghdl -a --std=08 ../../../../../bench/vhdl/tests/wb/mpsoc_mpram_testbench.vhd

simulate:
	ghdl -m --std=08 mpsoc_mpram_testbench
	ghdl -r --std=08 mpsoc_mpram_testbench --ieee-asserts=disable-at-0 --disp-tree=inst > mpsoc_mpram_testbench.tree

clean:
	rm -f *.cf *.tree
