@echo off
call ../../../../../../settings64_vivado.bat

xvlog -i ../../../../../../rtl/verilog/wb/pkg -prj system.verilog.prj
xelab wb_mpram_tb
xsim -R wb_mpram_tb
pause
