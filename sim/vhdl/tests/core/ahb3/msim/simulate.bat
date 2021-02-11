@echo off
call ../../../../../../settings64_vivado.bat

vlib work
vcom -2008 -f system.vc
vsim -c -do run.do work.mpsoc_mpram_testbench
pause
