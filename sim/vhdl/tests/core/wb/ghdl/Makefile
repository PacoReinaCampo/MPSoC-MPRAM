all: build simulate

build:
	ghdl -a --std=08 ../../../../../../rtl/vhdl/wb/pkg/peripheral_mpram_wb_pkg.vhd
	ghdl -a --std=08 ../../../../../../rtl/vhdl/wb/core/peripheral_ram_generic_wb.vhd
	ghdl -a --std=08 ../../../../../../rtl/vhdl/wb/core/peripheral_mpram_wb.vhd
	ghdl -a --std=08 ../../../../../../bench/vhdl/tests/core/wb/peripheral_mpram_testbench.vhd

simulate:
	ghdl -m --std=08 peripheral_mpram_testbench
	ghdl -r --std=08 peripheral_mpram_testbench --ieee-asserts=disable-at-0 --disp-tree=inst > peripheral_mpram_testbench.tree

clean:
	rm -f *.cf *.tree
