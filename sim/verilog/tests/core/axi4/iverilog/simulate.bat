@echo off
call ../../../../../../settings64_iverilog.bat

iverilog -g2012 -o system.vvp -c system.vc -s peripheral_mpram_testbench -I ../../../../../../rtl/verilog/axi4/pkg
vvp system.vvp
pause
