@echo off
call ../../../../../../settings64_msim.bat

vlib work
vlog -sv +incdir+../../../../../../rtl/verilog/axi4/pkg -f system.vc
vsim -c -do run.do work.peripheral_mpram_testbench
pause
