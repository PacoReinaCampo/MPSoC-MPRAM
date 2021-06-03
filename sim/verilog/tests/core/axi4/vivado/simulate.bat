@echo off
call ../../../../../../settings64_vivado.bat

xvlog -prj system.prj
xelab peripheral_mpram_testbench
xsim -R peripheral_mpram_testbench
pause
