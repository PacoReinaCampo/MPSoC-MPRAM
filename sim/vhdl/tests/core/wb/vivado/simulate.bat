@echo off
call ../../../../../../settings64_vivado.bat

xvhdl -prj system.prj
xelab mpsoc_mpram_testbench
xsim -R mpsoc_mpram_testbench
