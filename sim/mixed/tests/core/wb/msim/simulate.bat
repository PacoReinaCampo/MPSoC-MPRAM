@echo off
call ../../../../../../settings64_msim.bat

vlib work
vlog -sv -f system.verilog.vc
vcom -2008 -f system.vhdl.vc
vsim -c -do run.do work.peripheral_mpram_testbench
pause