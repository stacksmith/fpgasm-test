FPGASM TEST
===========
The src directory contains test source for fpgasm.

To build and optionally burn an FPGA, run:

build <filename> [burn]

This creates an xdl file in the ../xdl directory and invokes a makefile that runs
the Xilinx stuff.