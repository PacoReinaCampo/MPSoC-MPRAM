all: build simulate

build:
	iverilog -g2012 -o system.vvp -c system.vc -s wb_mpram_tb

simulate:
	vvp system.vvp

clean:
	rm -rf system.vvp
