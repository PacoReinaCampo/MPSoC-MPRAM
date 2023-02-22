@echo off
call ../../../../../../settings64_iverilog.bat

iverilog -g2012 -o system.vvp -c system.vc -s peripheral_mpram_testbench -I ../../../../../../rtl/verilog/pkg/ahb3
vvp system.vvp
pause
