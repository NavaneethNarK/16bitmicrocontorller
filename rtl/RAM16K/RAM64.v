module RAM64(in,load,address,clk,out);
    input [15:0] in;
    input [5:0] address;
    input load,clk;
    output [15:0] out;
    wire [7:0] loadw;
    wire [15:0] outw [7:0];

    demux18 demux18in(.in(load),.sel(address[5:3]),.out(loadw));

    RAM8 RAM8_0(.in(in),.load(loadw[0]),.address(address[2:0]),.clk(clk),.out(outw[0]));
    RAM8 RAM8_1(.in(in),.load(loadw[1]),.address(address[2:0]),.clk(clk),.out(outw[1]));
    RAM8 RAM8_2(.in(in),.load(loadw[2]),.address(address[2:0]),.clk(clk),.out(outw[2]));
    RAM8 RAM8_3(.in(in),.load(loadw[3]),.address(address[2:0]),.clk(clk),.out(outw[3]));
    RAM8 RAM8_4(.in(in),.load(loadw[4]),.address(address[2:0]),.clk(clk),.out(outw[4]));
    RAM8 RAM8_5(.in(in),.load(loadw[5]),.address(address[2:0]),.clk(clk),.out(outw[5]));
    RAM8 RAM8_6(.in(in),.load(loadw[6]),.address(address[2:0]),.clk(clk),.out(outw[6]));
    RAM8 RAM8_7(.in(in),.load(loadw[7]),.address(address[2:0]),.clk(clk),.out(outw[7]));

    mux81 mux81out(.in(outw),.sel(address[5:3]),.out(out));

endmodule