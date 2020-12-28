module reg16(reg_out, clk, sclr_n, clk_ena, datain); //Module with a list of ports
//Begin port declarations section
output[15:0] reg_out ;
input clk, sclr_n, clk_ena;
input [15:0] datain;

reg [15:0] reg_out;
wire clk, sclr_n, clk_ena;
wire [15:0] datain;

//End port declarations section

always @(posedge clk /*, posedge clk_ena, posedge sclr_n, datain*/ ) //Note use of comma operator
begin

	if( (clk_ena == 1) && (sclr_n == 0) )
		reg_out = 16'b0;
	
	else if( (clk_ena == 1) && (sclr_n == 1) )
		reg_out = datain;

	else
		reg_out = reg_out;
		
end

endmodule