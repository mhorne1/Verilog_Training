module shifter(shift_out, inp, shift_cntrl); //Module with a list of ports
//Begin port declarations section
output[15:0] shift_out;
input [7:0] inp;
input [1:0] shift_cntrl;

reg [15:0] shift_out;
wire [7:0] inp;
wire [1:0] shift_cntrl;

//End port declarations section

always @(inp, shift_cntrl) //Note use of comma operator
	begin

	if( shift_cntrl == 1 )
		shift_out = inp << 4;
	
	else if( shift_cntrl == 2 )
		shift_out = inp << 8;

	else
		shift_out = inp;
		
	end

endmodule

//module Top; // No list of ports, top-level module in simulation