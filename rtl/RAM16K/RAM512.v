module RAM512(in,load,address,clk,out);
    input [7:0] in;
    input [8:0] address;
    input load,clk;
    output [7:0] out;
    wire [7:0] loadw;
    wire [7:0] outw [7:0];

    demux18 demux18in(.in(load),.sel(address[8:6]),.out(loadw));

    RAM64 RAM64_0(.in(in),.load(loadw[0]),.address(address[5:0]),.clk(clk),.out(outw[0]));
    RAM64 RAM64_1(.in(in),.load(loadw[1]),.address(address[5:0]),.clk(clk),.out(outw[1]));
    RAM64 RAM64_2(.in(in),.load(loadw[2]),.address(address[5:0]),.clk(clk),.out(outw[2]));
    RAM64 RAM64_3(.in(in),.load(loadw[3]),.address(address[5:0]),.clk(clk),.out(outw[3]));
    RAM64 RAM64_4(.in(in),.load(loadw[4]),.address(address[5:0]),.clk(clk),.out(outw[4]));
    RAM64 RAM64_5(.in(in),.load(loadw[5]),.address(address[5:0]),.clk(clk),.out(outw[5]));
    RAM64 RAM64_6(.in(in),.load(loadw[6]),.address(address[5:0]),.clk(clk),.out(outw[6]));
    RAM64 RAM64_7(.in(in),.load(loadw[7]),.address(address[5:0]),.clk(clk),.out(outw[7]));

    mux81 mux81out(.in(outw),.sel(address[8:6]),.out(out));

endmodule