# Makefile to compile verilog
# DO THIS FIRST:
# source /opt/Xilinx/13.2/ISE_DS/settings32.sh
#

DEVICE = xc3s200-4ft256

default: gen

slowClkSrc: src/slowClkSrc.v
	cp src/slowClkSrc.v src/top.v
	make

srl16: 	src/srl16.v
	cp src/srl16.v src/top.v
	make


top.ngc:src/top.v src/top.ucf top.prj 
	xst -intstyle silent -ifn top.xst 

top.ngd: top.ngc
	ngdbuild -intstyle silent -dd _ngo -nt timestamp -uc src/top.ucf  -p xc3s200-ft256-4 top.ngc top.ngd

#-intstyle silent
top.pcf: top.ngd top.ngc
	map  -p xc3s200-ft256-4 -timing -logic_opt off   \
	-ol high -t 1 -register_duplication off -cm area -detail -ir off -pr b \
	-power off -o top_map.ncd top.ngd top.pcf 

top.ncd: top.ngd top.ngc top.pcf top_map.ncd
	par -intstyle silent -w  -ol high -t 1 top_map.ncd top.ncd top.pcf
#-intstyle ise
top.bit: top.ncd
	bitgen -intstyle silent -w -g DebugBitstream:No -g Binary:no -g CRC:Enable -g ConfigRate:6 \
	-g CclkPin:PullUp -g M0Pin:PullUp -g M1Pin:PullUp -g M2Pin:PullUp -g ProgPin:PullUp \
	-g DonePin:PullUp -g HswapenPin:PullUp -g TckPin:PullUp -g TdiPin:PullUp -g TdoPin:PullUp \
	-g TmsPin:PullUp -g UnusedPin:PullDown -g UserID:0xFFFFFFFF -g DCMShutdown:Disable \
	-g DCIUpdateMode:AsRequired -g StartUpClk:CClk -g DONE_cycle:4 -g GTS_cycle:5 \
	-g GWE_cycle:6 -g LCK_cycle:NoWait -g Match_cycle:Auto -g Security:None -g DonePipe:No \
	-g DriveDone:No top.ncd

#-intstyle ise -f top.ut top.ncd

#matilda: matilda/matilda.c
#	gcc -o matilda/matilda matilda/matilda.c

#gen: top.bit #prog/testi.mem prog/iram.bmm
#	cp top.ncd ~/Desktop/SHARED/DIGILENTS3/top.ncd#
#	cp top.bit ~/Desktop/SHARED/DIGILENTS3/top.bit
gen:	top.bit 
	impact -batch impact.cmd
#impact

clean:
	rm -rf *~ src/*~ *.bgn *.bin *.bit *.xwbt *.bld *.drc *_log *.html *.ncd *.ngc *.ngd *.map *.mrp *.xrpt \
*.ngr *.syr *.twr *.twx *.unroutes webtalk* *_map* *.pad *.lso *.par *.xdl *_summary* *_usage* *.xpi *.stx *.srp \
*.ptwx *.pcf \
_ngo planAhead* iseconfig* _xmsgs xlnx_auto* xst/dump.xst xst/work \
*.prm *.cfi *.hex


