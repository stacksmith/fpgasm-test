setMode -bscan
setCable -p auto
addDevice -p 1 -file test.bit
addDevice -p 2 -file /opt/Xilinx/13.3/ISE_DS/ISE/xcf/data/xcf02s.bsd
program -p 1
exit
