@echo off
call ../../../../../../settings64_vivado.bat

xvlog -prj system.prj
xelab mpsoc_mpram_testbench
xsim -R mpsoc_mpram_testbench
pause
