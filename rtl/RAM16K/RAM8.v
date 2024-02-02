module RAM8(in,load,address,clk,out);
    input [7:0] in;
    input [2:0] address;
    input load,clk;
    output [7:0] out;
    wire [7:0] loadw;
    wire [7:0] outw [7:0];

    demux18 demux18in(.in(load),.sel(address),.out(loadw));

    register reg0(.in(in),.load(loadw[0]),.clk(clk),.out(outw[0]));
    register reg1(.in(in),.load(loadw[1]),.clk(clk),.out(outw[1]));
    register reg2(.in(in),.load(loadw[2]),.clk(clk),.out(outw[2]));
    register reg3(.in(in),.load(loadw[3]),.clk(clk),.out(outw[3]));
    register reg4(.in(in),.load(loadw[4]),.clk(clk),.out(outw[4]));
    register reg5(.in(in),.load(loadw[5]),.clk(clk),.out(outw[5]));
    register reg6(.in(in),.load(loadw[6]),.clk(clk),.out(outw[6]));
    register reg7(.in(in),.load(loadw[7]),.clk(clk),.out(outw[7]));
    
    mux81 mux81out(.in(outw),.sel(address),.out(out));

endmodule