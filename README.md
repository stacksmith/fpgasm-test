FPGASM TEST
===========
The src directory contains test source for fpgasm.  Note that the new extension format is:
* .fa  for fpgasm top files
* .fai for fpgasm include files
* .ham - old extension, deprecated

To quickly check for errors,

```
fpgasm <filename>.ham (or .fa)
```
To build and optionally burn an FPGA, run:
```
build <filename> [burn]
```
(no exension!) This creates an xdl file in the ../xdl directory and invokes a makefile that runs the Xilinx stuff.

