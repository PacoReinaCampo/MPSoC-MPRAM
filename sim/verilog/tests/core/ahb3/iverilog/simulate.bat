@echo off
call ../../../../../../settings64_iverilog.bat

iverilog -g2012 -o system.vvp -c system.vc -s mpsoc_mpram_testbench
vvp system.vvp
pause
