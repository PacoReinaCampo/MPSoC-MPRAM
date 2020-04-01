all: build

build:
	@if [ ! -e work ]; then vlib work; fi
	@vcom -2008 -f mpram.vc
	vsim -c -do run.do work.mpsoc_mpram_testbench
