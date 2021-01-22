all: build simulate

build:
	ghdl -a --std=08 ../../../../../../rtl/vhdl/ahb3/pkg/mpsoc_mpram_ahb3_pkg.vhd
	ghdl -a --std=08 ../../../../../../rtl/vhdl/ahb3/core/mpsoc_ahb3_mpram.vhd
	ghdl -a --std=08 ../../../../../../rtl/vhdl/ahb3/core/mpsoc_ram_1r1w.vhd
	ghdl -a --std=08 ../../../../../../rtl/vhdl/ahb3/core/mpsoc_ram_1r1w_generic.vhd
	ghdl -a --std=08 ../../../../../../bench/vhdl/tests/core/ahb3/mpsoc_mpram_testbench.vhd

simulate:
	ghdl -m --std=08 mpsoc_mpram_testbench
	ghdl -r --std=08 mpsoc_mpram_testbench --ieee-asserts=disable-at-0 --disp-tree=inst > mpsoc_mpram_testbench.tree

clean:
	rm -f *.cf *.tree
