module seven_segment_cntrl(seg_a, seg_b, seg_c, seg_d, seg_e, seg_f, seg_g, inp); //Module with a list of ports
//Begin port declarations section
output seg_a, seg_b, seg_c, seg_d, seg_e, seg_f, seg_g;
input [2:0] inp;

reg seg_a, seg_b, seg_c, seg_d, seg_e, seg_f, seg_g;
wire [2:0] inp;

//End port declarations section

always @(inp) //Note use of comma operator
begin
	case (inp)
	3'b000 : begin
				seg_a = 1'b1;
				seg_b = 1'b1;
				seg_c = 1'b1;
				seg_d = 1'b1;
				seg_e = 1'b1;
				seg_f = 1'b1;
				seg_g = 1'b0;
				end
	3'b001 : begin
				seg_a = 1'b0;
				seg_b = 1'b1;
				seg_c = 1'b1;
				seg_d = 1'b0;
				seg_e = 1'b0;
				seg_f = 1'b0;
				seg_g = 1'b0;
				end
	3'b010 : begin
				seg_a = 1'b1;
				seg_b = 1'b1;
				seg_c = 1'b0;
				seg_d = 1'b1;
				seg_e = 1'b1;
				seg_f = 1'b0;
				seg_g = 1'b1;
				end
	3'b011 : begin
				seg_a = 1'b1;
				seg_b = 1'b1;
				seg_c = 1'b1;
				seg_d = 1'b1;
				seg_e = 1'b0;
				seg_f = 1'b0;
				seg_g = 1'b1;
				end
	default : begin
				seg_a = 1'b1;
				seg_b = 1'b0;
				seg_c = 1'b0;
				seg_d = 1'b1;
				seg_e = 1'b1;
				seg_f = 1'b1;
				seg_g = 1'b1;
				end

	/*			
	3'b000 : begin
				{seg_a, seg_b, seg_c, seg_d, seg_e, seg_f} = 1'b1;
				seg_g = 1'b0;
				end
	3'b001 : begin
				{seg_b, seg_c} = 1'b1;
				{seg_a, seg_d, seg_e, seg_f, seg_g} = 1'b0;
				end
	3'b010 : begin
				{seg_a, seg_b, seg_d, seg_e, seg_g} = 1'b1;
				{seg_c, seg_f} = 1'b0;
				end
	3'b011 : begin
				{seg_a, seg_b, seg_c, seg_d, seg_g} = 1'b1;
				{seg_e, seg_f} = 1'b0;
				end
	default : begin
				{seg_a, seg_d, seg_e, seg_f, seg_g} = 1'b1;
				{seg_b, seg_c} = 1'b0;
				end
	*/
	
endcase
end

endmodule

//module Top; // No list of ports, top-level module in simulation