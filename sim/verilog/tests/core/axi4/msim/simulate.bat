@echo off
call ../../../../../../settings64_msim.bat

vlib work
vlog -f system.vc
vsim -c -do run.do work.peripheral_mpram_testbench
pause