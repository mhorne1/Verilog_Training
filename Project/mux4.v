module mux4(mux_out, mux_in_a, mux_in_b, mux_sel); //Module with a list of ports
//Begin port declarations section
output[3:0] mux_out;
input [3:0] mux_in_a;
input [3:0] mux_in_b;
input mux_sel;

reg [3:0] mux_out;
wire [3:0] mux_in_a;
wire [3:0] mux_in_b;
wire mux_sel;

//End port declarations section

//assign mux_out = mux_in_a;

always @(mux_sel, mux_in_a, mux_in_b) //Note use of comma operator
//begin

if( mux_sel == 1'b0)
	mux_out = mux_in_a;

//if( mux_sel == 1'b1)
//	mux_out = mux_in_b;

else
	mux_out = mux_in_b;
//end

endmodule

//module Top; // No list of ports, top-level module in simulation