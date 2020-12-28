// EECS X494.92 Logic_Design_and_Analysis_using_Verilog
// Project
// Horne, Michael
// dual_mult8x8_top.v

//`timescale 1 ns/100 ps

module dual_mult8x8_top(
	input             clk,
   input             reset_al,
   input      [3:0]  address,
   input             cs,       // cs is high for access to cpu_if, cs is low for access to multipliers
   input             rd,
   input             wr,
	inout      [15:0] data
);

//define parameters
	parameter rst = 1'b0;  // reset signal level

// Multiplier mult8x8_i1 registers
reg [7:0] data_a1;     // 8-bit register to hold the multiplier input
reg [7:0] data_b1;     // 8-bit register to hold the multiplier input
reg start_1;           // 1-bit register to hold the “start” bit input
reg ghost_start_1;     // 1-bit register used to toggle the “start” bit input for one clock cycle
reg done_flag_1;       // 1-bit register to hold the done_flag output
reg [15:0] product_1;  // 16-bit register to hold the multiplier output

// Multiplier mult8x8_i2 registers
reg [7:0] data_a2;     // 8-bit register to hold the multiplier input
reg [7:0] data_b2;     // 8-bit register to hold the multiplier input
reg start_2;           // 1-bit register to hold the “start” bit input
reg ghost_start_2;     // 1-bit register used to toggle the “start” bit input for one clock cycle
reg done_flag_2;       // 1-bit register to hold the done_flag output
reg [15:0] product_2;  // 16-bit register to hold the multiplier output

// data bus control registers
reg drive;             // 1-bit register to control data bus reads
//reg drive_1;             // 1-bit register to hold the done_flag output
//reg drive_2;             // 1-bit register to hold the done_flag output
reg [15:0] data_out;   // 16-bit register to store read data


wire st_1; // temporary start signal for multiplier 1
wire df_1; // temporary done_flag signal from multiplier 1
wire [15:0] pr_1; // product from multiplier 1 
wire seg_a_1, seg_b_1, seg_c_1, seg_d_1, seg_e_1, seg_f_1, seg_g_1; // unused


wire st_2; // temporary start signal for multiplier 2
wire df_2; // temporary done_flag signal from multiplier 2
wire [15:0] pr_2; // product from multiplier 1 
wire seg_a_2, seg_b_2, seg_c_2, seg_d_2, seg_e_2, seg_f_2, seg_g_2; // unused


assign data = (drive && !cs && rd) ? data_out : 16'bz; // drive data bus with multiplier information
//assign data = (drive_1 && !cs && rd) ? product_1 : 16'bz;
//assign data = (drive_2 && !cs && rd) ? product_2 : 16'bz;

assign st_1 = start_1 & !ghost_start_1; // trigger start signal for multiplier 1 if start bit is set
assign st_2 = start_2 & !ghost_start_2; // trigger start signal for multiplier 2 if start bit is set


initial begin
$display ("%m instantiated");
end


cpu_if cpu_if_i1 (.clk(clk), .reset_al(reset_al), .data(data),
		.address(address), .cs(cs), .rd(rd), .wr(wr));

// reset is active low
mult8x8 mult8x8_i1 (.clk(clk), .reset_a(!reset_al), .dataa(data_a1), .datab(data_b1),
		.product8x8_out(pr_1), .done_flag(df_1), .start(st_1),
		.seg_a(seg_a_1), .seg_b(seg_b_1), .seg_c(seg_c_1), .seg_d(seg_d_1), 
		.seg_e(seg_e_1), .seg_f(seg_f_1), .seg_g(seg_g_1));

// reset is active low
mult8x8 mult8x8_i2 (.clk(clk), .reset_a(!reset_al), .dataa(data_a2), .datab(data_b2),
		.product8x8_out(pr_2), .done_flag(df_2), .start(st_2),
		.seg_a(seg_a_2), .seg_b(seg_b_2), .seg_c(seg_c_2), .seg_d(seg_d_2), 
		.seg_e(seg_e_2), .seg_f(seg_f_2), .seg_g(seg_g_2));


initial begin
data_a1 = 8'b0; // initialize multiplier 1 input register
data_b1 = 8'b0; // initialize multiplier 1 input register
start_1 = 1'b1; // initialize multiplier 1 start register
done_flag_1 = 1'b1; // initialize multiplier 1 done_flag register
product_1 = 16'b0; // initialize multiplier 1 product register

data_a2 = 8'b0; // initialize multiplier 2 input register
data_b2 = 8'b0; // initialize multiplier 2 input register
start_2 = 1'b1; // initialize multiplier 2 start register
done_flag_2 = 1'b1; // initialize multiplier 2 done_flag register
product_2 = 16'b0; // initialize multiplier 2 product register

drive = 1'b0; // initialize register to control data bus reads
//drive_1 = 1'b0;
//drive_2 = 1'b0;
data_out = 16'b0; // initialize register to store read data
end


// multiplier read and write control with address decoding
always@(posedge clk) begin
	if (reset_al == rst) begin
	start_1 <= 1'b1;
	end
	else begin
		case (address)
		4'b0000 : begin
			if (!cs && wr) begin
				data_a1 <= data[7:0];
				data_b1 <= data[15:8];
				//done_flag_1 <= 1'b0;
			end
		end
		4'b0001 : begin
			if (!cs && wr) begin
				//start_1 <= data[0];
				start_1 <= 1'b1;
				//#10 ;
				//start_1 <= 1'b0;
				//#20 ;
			end
		end
		4'b0010 : begin
			if (!cs && rd) begin
				data_out <= done_flag_1;
				drive <= 1'b1;
				//drive_1 <= 1'b1;
			end
		end
		4'b0011 : begin
			if (!cs && rd) begin
				data_out <= product_1;
				drive <= 1'b1;
				//drive_1 <= 1'b1;
			end
		end
		4'b0100 : begin
			if (!cs && wr) begin
				data_a2 <= data[7:0];
				data_b2 <= data[15:8];
				//done_flag_2 <= 1'b0;
			end
		end
		4'b0101 : begin
			if (!cs && wr) begin
				//start_2 <= data[0];
				start_2 <= 1'b1;
				//#10 ;
				//start_2 <= 1'b0;
				//#20 ;
			end
		end
		4'b0110 : begin
			if (!cs && rd) begin
				data_out <= done_flag_2;
				drive <= 1'b1;
				//drive_2 <= 1'b1;
			end
		end
		4'b0111 : begin
			if (!cs && rd) begin
				data_out <= product_2;
				drive <= 1'b1;
				//drive_2 <= 1'b1;
			end
		end
		default : begin
					start_1 <= 1'b0;
					start_2 <= 1'b0;
					//data_out <= 16'bz;
					data_out <= 16'b0;
					drive <= 1'b0;
					//drive_1 <= 1'b0;
					//drive_2 <= 1'b0;
					end
		endcase
	end
end


always@(posedge clk) begin
   if (reset_al == rst) begin
	   //start_1 <= 1'b0;
		ghost_start_1 <= 1'b0; // trigger automatic start after reset
	end
	else begin
	   ghost_start_1 <= start_1; // store previous value of start bit
	end
end


always@(posedge clk) begin
   if (reset_al == rst) begin
	   //start_1 <= 1'b0;
		ghost_start_2 <= 1'b0; // trigger automatic start after reset
	end
	else begin
	   ghost_start_2 <= start_2; // store previous value of start bit
	end
end


always@(posedge clk) begin
   if (reset_al == rst) begin
	   done_flag_1 <= 1'b1;
	end
	else begin
	   if (start_1 == 1'b1) begin
		   done_flag_1 <= 1'b0; // clear done_flag if start bit is set
		end
	   else begin
		   if (df_1 == 1'b1) begin
			   done_flag_1 <= 1'b1; // set done_flag for multiplier 1
		   end
		end
	end
end


always@(posedge clk) begin
   if (reset_al == rst) begin
	   done_flag_2 <= 1'b1;
	end
	else begin
	   if (start_2 == 1'b1) begin
		   done_flag_2 <= 1'b0; // clear done_flag if start bit is set
		end
	   else begin
		   if (df_2 == 1'b1) begin
			   done_flag_2 <= 1'b1; // set done_flag for multiplier 2
		   end
		end
	end
end


always@(posedge clk) begin
   if (reset_al == rst) begin
	   product_1 <= 16'b0;
	end
	else begin
	   //if (done_flag_1 == 1'b1) begin
		if (df_1 == 1'b1) begin
		   product_1 <= pr_1;  // load product from multiplier 1
		end
	end
end


always@(posedge clk) begin
   if (reset_al == rst) begin
	   product_2 <= 16'b0;
	end
	else begin
	   //if (done_flag_2 == 1'b1) begin
		if (df_2 == 1'b1) begin
		   product_2 <= pr_2;  // load product from multiplier 2
		end
	end
end


endmodule