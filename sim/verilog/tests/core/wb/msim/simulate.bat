vlib work
vlog -sv +incdir+../../../../../../rtl/verilog/wb/pkg -f system.vc
vsim -c -do run.do work.mpsoc_mpram_testbench
