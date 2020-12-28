// EECS X494.92 Logic_Design_and_Analysis_using_Verilog
// Project
// Horne, Michael
// cpu_if.v

module cpu_if(clk, reset_al, address, data, cs, rd, wr);
//module cpu_if(rdata, clk, address, cs, rd, wr, wdata);
//Module for CPU inteface

//Begin port declarations section

//output [15:0] rdata;

//input [15:0] wdata;
input clk;
input reset_al;
input [3:0] address;
inout [15:0] data; // bidirectional data bus
input cs;
input rd;
input wr;

wire rd_en;
wire wr_en;

reg cpu_drive;
reg  [15:0] data_cpu;

//Variable data type
//reg [15:0] rdata;

//Internal 16-bit registers
reg [15:0] r0, r1, r2, r3, r4, r5, r6, r7, r8, r9, r10, r11, r12, r13, r14, r15;
//End port declarations section

assign data = (cs && rd && cpu_drive) ? data_cpu : 16'bz;

assign rd_en = (cs && rd && ~wr) ? 1'b1 : 1'b0;

assign wr_en = (cs && wr && ~rd) ? 1'b1 : 1'b0;


initial begin
$display ("%m instantiated");
end


//Initialize register values
initial begin
//Do not drive bus unless both cs and rd are active
data_cpu = 16'b0;
cpu_drive = 1'b0;
//rdata <= 16'bz;
//Initialize all 16-bit registers with 0
r0 = 0;
r1 = 0;
r2 = 0;
r3 = 0;
r4 = 0;
r5 = 0;
r6 = 0;
r7 = 0;
r8 = 0;
r9 = 0;
r10 = 0;
r11 = 0;
r12 = 0;
r13 = 0;
r14 = 0;
r15 = 0;
end



// Asyncronous read process
always@(*) begin
//always@(rd) begin
	//if (rd) begin
	if (rd_en) begin
		case (address)
			4'd0 : begin
				data_cpu = r0;
				cpu_drive = 1'b1;
				end
			4'd1 : begin
				data_cpu = r1;
				cpu_drive = 1'b1;
				end
			4'd2 : begin
				data_cpu = r2;
				cpu_drive = 1'b1;
				end
			4'd3 : begin
				data_cpu = r3;
				cpu_drive = 1'b1;
				end
			4'd4 : begin
				data_cpu = r4;
				cpu_drive = 1'b1;
				end
			4'd5 : begin
				data_cpu = r5;
				cpu_drive = 1'b1;
				end
			4'd6 : begin
				data_cpu = r6;
				cpu_drive = 1'b1;
				end
			4'd7 : begin
				data_cpu = r7;
				cpu_drive = 1'b1;
				end
			4'd8 : begin
				data_cpu = r8;
				cpu_drive = 1'b1;
				end
			4'd9 : begin
				data_cpu = r9;
				cpu_drive = 1'b1;
				end
			4'd10 : begin
				data_cpu = r10;
				cpu_drive = 1'b1;
				end
			4'd11 : begin
				data_cpu = r11;
				cpu_drive = 1'b1;
				end
			4'd12 : begin
				data_cpu = r12;
				cpu_drive = 1'b1;
				end
			4'd13 : begin
				data_cpu = r13;
				cpu_drive = 1'b1;
				end
			4'd14 : begin
				data_cpu = r14;
				cpu_drive = 1'b1;
				end
			4'd15 : begin
				data_cpu = r15;
				cpu_drive = 1'b1;
				end
			default : begin
				data_cpu = 16'bz;
				cpu_drive = 1'b0;
				end
		endcase
	end
	else begin
			data_cpu = 16'bz;
			cpu_drive = 1'b0;
	end
end


// Synchronous write process
always@( posedge clk, negedge reset_al)
begin
	if (!reset_al) begin
		r0 <= 16'b0;
		r1 <= 16'b0;
		r2 <= 16'b0; 
		r3 <= 16'b0; 
		r4 <= 16'b0;
		r5 <= 16'b0; 
		r6 <= 16'b0; 
		r7 <= 16'b0; 
		r8 <= 16'b0; 
		r9 <= 16'b0; 
		r10 <= 16'b0; 
		r11 <= 16'b0; 
		r12 <= 16'b0; 
		r13 <= 16'b0; 
		r14 <= 16'b0; 
		r15 <= 16'b0; 
	end
	else if (wr_en) begin
		case (address)
		0 : begin
			r0 <= data;
			end
		1 : begin
			r1 <= data;
			end
		2 : begin
			r2 <= data;
			end
		3 : begin
			r3 <= data;
			end
		4 : begin
			r4 <= data;
			end
		5 : begin
			r5 <= data;
			end
		6 : begin
			r6 <= data;
			end
		7 : begin
			r7 <= data;
			end
		8 : begin
			r8 <= data;
			end
		9 : begin
			r9 <= data;
			end
		10 : begin
			r10 <= data;
			end
		11 : begin
			r11 <= data;
			end
		12 : begin
			r12 <= data;
			end
		13 : begin
			r13 <= data;
			end
		14 : begin
			r14 <= data;
			end
		15 : begin
			r15 <= data;
			end
		default :
			begin
			$display("Invalid address signal");
			end
		endcase
	end      
end

endmodule