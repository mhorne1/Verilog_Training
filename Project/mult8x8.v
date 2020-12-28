//Top-level module and port declarations section
module mult8x8(output [15:0] product8x8_out,
					output done_flag,
					output seg_a,
					output seg_b,
					output seg_c,
					output seg_d,
					output seg_e,
					output seg_f,
					output seg_g,
					input [7:0] dataa,
					input [7:0] datab,
					input start,
					input reset_a,
					input clk
					);

//End port declarations section


//Internal wire declarations section

//counter
wire [1:0] count;

//mult_control
wire [1:0] sel;
wire [1:0] shift;
wire [2:0] state_out;
//wire done_flag;
wire clk_ena;
wire sclr_n;

//mux4a
wire [3:0] aout;

//mux4b
wire [3:0] bout;

//mult4x4
wire [7:0] product;

//shifter
wire [15:0] shift_out;

//adder
wire [15:0] sum;

//End internal wire declarations section


//Module instantiations section
//First instantiation begins with a, second instantion with b...
//Specify vectors as needed

counter acounter (	.clk(clk),
							.aclr_n(!start),
							.count_out(count[1:0])
							);

mult_control u6 (	.clk(clk),
						.reset_a(reset_a),
						.start(start),
						.count(count[1:0]),
						.input_sel(sel[1:0]),
						.shift_sel(shift[1:0]),
						.state_out(state_out[2:0]),
						.done(done_flag),
						.clk_ena(clk_ena),
						.sclr_n(sclr_n)
						);

mux4 amux4 (	.mux_in_a(dataa[3:0]),
					.mux_in_b(dataa[7:4]),
					.mux_sel(sel[1]),
					.mux_out(aout[3:0])
					);

mux4 bmux4 (	.mux_in_a(datab[3:0]),
					.mux_in_b(datab[7:4]),
					.mux_sel(sel[0]),
					.mux_out(bout[3:0])
					);

mult4x4 amult4x4 (	.dataa(aout[3:0]),
							.datab(bout[3:0]),
							.product(product[7:0])
							);
						
shifter ashifter (	.inp(product[7:0]),
							.shift_cntrl(shift[1:0]),
							.shift_out(shift_out[15:0])
							);

adder aadder (	.dataa(shift_out[15:0]),
					.datab(product8x8_out[15:0]),
					.sum(sum[15:0])
					);

reg16 areg16 (	.clk(clk),
					.sclr_n(sclr_n),
					.clk_ena(clk_ena),
					.datain(sum[15:0]),
					.reg_out(product8x8_out[15:0])
					);

seven_segment_cntrl assc (	.inp(state_out[2:0]),
									.seg_a(seg_a),
									.seg_b(seg_b),
									.seg_c(seg_c),
									.seg_d(seg_d),
									.seg_e(seg_e),
									.seg_f(seg_f),
									.seg_g(seg_g)
									);

endmodule