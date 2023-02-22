@echo off
call ../../../../../../settings64_verilator.bat

verilator -Wno-lint +incdir+../../../../../../rtl/verilog/pkg/ahb3 --cc -f system.vc --top-module peripheral_mpram_testbench
pause
