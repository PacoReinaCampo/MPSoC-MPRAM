@echo off
call ../../../../../../settings64_ghdl.bat

ghdl -a --std=08 ../../../../../../rtl/vhdl/pkg/peripheral/ahb3/peripheral_mpram_ahb3_pkg.vhd
ghdl -a --std=08 ../../../../../../rtl/vhdl/peripheral/ahb3/peripheral_mpram_ahb3.vhd
ghdl -a --std=08 ../../../../../../rtl/vhdl/peripheral/ahb3/peripheral_ram_1r1w.vhd
ghdl -a --std=08 ../../../../../../rtl/vhdl/peripheral/ahb3/peripheral_ram_1r1w_generic.vhd
ghdl -a --std=08 ../../../../../../bench/vhdl/tests/peripheral/ahb3/peripheral_mpram_testbench.vhd
ghdl -m --std=08 peripheral_mpram_testbench
ghdl -r --std=08 peripheral_mpram_testbench --ieee-asserts=disable-at-0 --disp-tree=inst > peripheral_mpram_testbench.tree
pause
