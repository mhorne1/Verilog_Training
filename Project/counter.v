module counter(count_out, clk, aclr_n); //Module with a list of ports
//Begin port declarations section
output[1:0] count_out;
input clk, aclr_n;

reg [1:0] count_out;
wire clk, aclr_n;

//End port declarations section

always @(posedge clk, negedge aclr_n ) //Note use of comma operator
begin

	if( aclr_n == 0 )
		count_out = 2'b0;
		
	else
		count_out = count_out + 1'b1;
		
end

endmodule