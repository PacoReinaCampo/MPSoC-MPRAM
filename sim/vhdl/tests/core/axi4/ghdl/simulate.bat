@echo off
call ../../../../../../settings64_ghdl.bat

ghdl -a --std=08 ../../../../../../rtl/vhdl/axi4/core/peripheral_axi4_mpram.vhd
ghdl -a --std=08 ../../../../../../bench/vhdl/tests/core/axi4/peripheral_mpram_testbench.vhd
ghdl -m --std=08 peripheral_mpram_testbench
ghdl -r --std=08 peripheral_mpram_testbench --ieee-asserts=disable-at-0 --disp-tree=inst > peripheral_mpram_testbench.tree
pause
