module adder(sum, dataa, datab); //Module with a list of ports
//Begin port declarations section
output[15:0] sum;
input [15:0] dataa,datab;


//End port declarations section
assign sum = dataa + datab;

endmodule

//module Top; // No list of ports, top-level module in simulation
