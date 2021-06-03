@echo off
call ../../../../../../settings64_ghdl.bat

ghdl -a --std=08 ../../../../../../rtl/vhdl/ahb3/pkg/peripheral_mpram_ahb3_pkg.vhd
ghdl -a --std=08 ../../../../../../rtl/vhdl/ahb3/core/peripheral_ahb3_mpram.vhd
ghdl -a --std=08 ../../../../../../rtl/vhdl/ahb3/core/peripheral_ram_1r1w.vhd
ghdl -a --std=08 ../../../../../../rtl/vhdl/ahb3/core/peripheral_ram_1r1w_generic.vhd
ghdl -a --std=08 ../../../../../../bench/vhdl/tests/core/ahb3/peripheral_mpram_testbench.vhd
ghdl -m --std=08 peripheral_mpram_testbench
ghdl -r --std=08 peripheral_mpram_testbench --ieee-asserts=disable-at-0 --disp-tree=inst > peripheral_mpram_testbench.tree
pause
