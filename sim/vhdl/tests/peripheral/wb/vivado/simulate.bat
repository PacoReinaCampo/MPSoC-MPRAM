@echo off
call ../../../../../../settings64_vivado.bat

xvhdl -prj system.prj
xelab peripheral_mpram_testbench
xsim -R peripheral_mpram_testbench
