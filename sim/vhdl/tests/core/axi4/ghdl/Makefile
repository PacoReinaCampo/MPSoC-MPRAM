all: build simulate

build:
	ghdl -a --std=08 ../../../../../../rtl/vhdl/axi4/core/mpsoc_axi4_mpram.vhd
	ghdl -a --std=08 ../../../../../../bench/vhdl/tests/core/axi4/mpsoc_mpram_testbench.vhd

simulate:
	ghdl -m --std=08 mpsoc_mpram_testbench
	ghdl -r --std=08 mpsoc_mpram_testbench --ieee-asserts=disable-at-0 --disp-tree=inst > mpsoc_mpram_testbench.tree

clean:
	rm -f *.cf *.tree
