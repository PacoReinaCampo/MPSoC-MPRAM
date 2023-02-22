all: build simulate

build:
	ghdl -a --std=08 ../../../../../../rtl/vhdl/peripheral/axi4/peripheral_mpram_axi4.vhd
	ghdl -a --std=08 ../../../../../../bench/vhdl/tests/peripheral/axi4/peripheral_mpram_testbench.vhd

simulate:
	ghdl -m --std=08 peripheral_mpram_testbench
	ghdl -r --std=08 peripheral_mpram_testbench --ieee-asserts=disable-at-0 --disp-tree=inst > peripheral_mpram_testbench.tree

clean:
	rm -f *.cf *.tree
