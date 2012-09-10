/* TEST HARNESS 

  Board: Digilent Sparatan 3 Demo Board

Generate very slow clocks for debugging the test board
6-wire 4-digit debugging connection

features:
 16 clocks of different frequencies on B1 top
 4-bit serial debuggin port on b1-bottom(skip 3 pins, the next one is low bit
*/

/* Ok, this is what it's all about.  Generating 8 segments, multiplexed
with a one-hot select.  Low anode is active. Low segment is active.
The segments are layed out as follows:
    a
  g   b
    f 
  e   c
    d  
       dp       
Placement works out better if we put the decoders down low where 4 are used.
3 wires run up to the remaining outputs (better 3 than 4...)  

Now we can time-domain mux 4 nybbles on 4 wires using 4 4-way muxes in 2 slices,
driven by a 2 enables.
For debugging, switching 4 wires is a lot better than switching 16.
. */
module nyb2s7(
  input C
,  input [3:0] nyb
, output reg [1:0] sel //digit select
, output  [7:0] seg
, output reg [3:0] anode
);
// a 2-bit digit counter
//reg [1:0] digcnt; assign dig=digcnt;
//reg [3:0] anode; 

assign seg[7]=1; //dp is off

(*LOC="SLICE_X39Y5" *)(* BEL="G"*) // segment 0 or A, at E14
ROM16X1 #(.INIT(16'b0010100000010010))segrom0 (seg[0], nyb[0],nyb[1],nyb[2],nyb[3]); 
(*LOC="SLICE_X39Y3" *)(* BEL="G"*) // segment 1 or B, at G13
ROM16X1 #(.INIT(16'b1101100001100000))segrom1 (seg[1], nyb[0],nyb[1],nyb[2],nyb[3]);
(*LOC="SLICE_X39Y4" *)(* BEL="G"*) // segment 2 or C, at N15
ROM16X1 #(.INIT(16'b1101000000000100))segrom2 (seg[2], nyb[0],nyb[1],nyb[2],nyb[3]);
(*LOC="SLICE_X39Y2" *)(* BEL="F"*) // segment 3 or D, at P15
ROM16X1 #(.INIT(16'b1000010010010010))segrom3 (seg[3], nyb[0],nyb[1],nyb[2],nyb[3]);
(*LOC="SLICE_X39Y2" *)(* BEL="G"*) // segment 4 or E, at R16
ROM16X1 #(.INIT(16'b0000001010111010))segrom4 (seg[4], nyb[0],nyb[1],nyb[2],nyb[3]);
(*LOC="SLICE_X39Y3" *)(* BEL="F"*) // segment 5 or F, at F13
ROM16X1 #(.INIT(16'b0010000010001110))segrom5 (seg[5], nyb[0],nyb[1],nyb[2],nyb[3]);
(*LOC="SLICE_X39Y4" *)(* BEL="F"*) // segment 6 or G, at N16
ROM16X1 #(.INIT(16'b0001000010000011))segrom6 (seg[6], nyb[0],nyb[1],nyb[2],nyb[3]);

always @ (posedge C) //we generate selects for the target
  sel <= sel+1;

always @(sel)	     //we also use selects to output anodes
  case (sel)  
    2'b00: anode = 4'b1110;
    2'b01: anode = 4'b1101; 
    2'b10: anode = 4'b1011;
    2'b11: anode = 4'b0111;
  endcase

endmodule

/*====================================
  Divide the 50MHz clock by 2 in 26 stages.
  output stages 10-26 to port b1.
  

*/

module top(
  input mclk
, output [3:0] led
, input [3:0] btn
, input [3:0] bugin //4-bit-serialized debug input
, output [1:0] bugsel //2-bit digit select - to our circuit's mux
, output [15:0] CLOCK
, output [3:0] anode
, output [7:0] seg
);
wire[3:0] bug;
assign bug[3:0]=bugin;



assign led[3:2]=0;

reg  [26:0]clkdiv;
always @ (posedge mclk)
  clkdiv <= clkdiv+1;

assign led[0] = clkdiv[26];
assign CLOCK[15:0] = clkdiv[26:10];

nyb2s7 s7decoder(CLOCK[0]
	,bug[3:0],bugsel[1:0]
	,seg[7:0],anode[3:0]);

assign led[1]=btn[0];
endmodule
