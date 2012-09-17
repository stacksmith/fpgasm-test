# Makefile to compile verilog
# DO THIS FIRST:
# source /opt/Xilinx/13.2/ISE_DS/settings32.sh
#


default: test.bit


test.ncd: test.xdl
	xdl >xdl.log -xdl2ncd test
#adjust as you see fit - I put it here to look at later
	cp test.ncd ~/Desktop/FPGASM/STUDY/test.ncd

testrt.ncd: test.ncd
	par -p  -w test.ncd testrt.ncd #//-nopad 
#adjust as you see fit - I put it here to look at later
	cp testrt.ncd ~/Desktop/FPGASM/STUDY/testrt.ncd

test.bit: testrt.ncd
	bitgen  -intstyle silent -w -g DebugBitstream:No -g Binary:no -g CRC:Enable -g ConfigRate:6 \
	-g CclkPin:PullUp -g M0Pin:PullUp -g M1Pin:PullUp -g M2Pin:PullUp -g ProgPin:PullUp \
	-g DonePin:PullUp -g HswapenPin:PullUp -g TckPin:PullUp -g TdiPin:PullUp -g TdoPin:PullUp \
	-g TmsPin:PullUp -g UnusedPin:PullDown -g UserID:0xFFFFFFFF -g DCMShutdown:Disable \
	-g DCIUpdateMode:AsRequired -g StartUpClk:CClk -g DONE_cycle:4 -g GTS_cycle:5 \
	-g GWE_cycle:6 -g LCK_cycle:NoWait -g Match_cycle:Auto -g Security:None -g DonePipe:No \
	-g DriveDone:No testrt.ncd test.bit

burn: test.bit
	impact >impact.log  -batch impact.cmd

clean:
	rm -rf *.class *~

