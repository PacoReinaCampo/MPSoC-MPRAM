@echo off
call ../../../../../../settings64_vivado.bat

vlib work
vcom -2008 -f system.vc
vsim -c -do run.do work.peripheral_mpram_testbench
pause
