FPGASM TEST
===========
The src directory contains test source for fpgasm.

To quickly check for errors,

```
fpgasm **filename.ham**
```
To build and optionally burn an FPGA, run:
```
build **filename** [burn]
```
(no .ham exension!) This creates an xdl file in the ../xdl directory and invokes a makefile that runs the Xilinx stuff.

