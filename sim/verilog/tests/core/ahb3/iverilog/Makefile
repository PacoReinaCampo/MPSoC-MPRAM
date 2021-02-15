all: build simulate

build:
	iverilog -g2012 -o system.vvp -c system.vc -s mpsoc_mpram_testbench

simulate:
	vvp system.vvp

clean:
	rm -rf system.vvp
