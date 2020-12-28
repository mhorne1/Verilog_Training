module mult4x4(product, dataa, datab); //Module with a list of ports
//Begin port declarations section
output[7:0] product;
input [3:0] dataa, datab;


//End port declarations section
assign product = dataa * datab;

endmodule
