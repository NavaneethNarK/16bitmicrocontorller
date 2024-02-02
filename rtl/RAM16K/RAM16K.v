module RAM16K(in,load,address,clk,out);
    input [7:0] in;
    input [14:0] address;
    input load,clk;
    output [7:0] out;
    wire [7:0] loadw;
    wire [7:0] outw [7:0];

    demux18 demux18in(.in(load),.sel(address[14:12]),.out(loadw));

    RAM4K RAM4K_0(.in(in),.load(loadw[0]),.address(address[11:0]),.clk(clk),.out(outw[0]));
    RAM4K RAM4K_1(.in(in),.load(loadw[1]),.address(address[11:0]),.clk(clk),.out(outw[1]));
    RAM4K RAM4K_2(.in(in),.load(loadw[2]),.address(address[11:0]),.clk(clk),.out(outw[2]));
    RAM4K RAM4K_3(.in(in),.load(loadw[3]),.address(address[11:0]),.clk(clk),.out(outw[3]));
    RAM4K RAM4K_4(.in(in),.load(loadw[4]),.address(address[11:0]),.clk(clk),.out(outw[4]));
    RAM4K RAM4K_5(.in(in),.load(loadw[5]),.address(address[11:0]),.clk(clk),.out(outw[5]));
    RAM4K RAM4K_6(.in(in),.load(loadw[6]),.address(address[11:0]),.clk(clk),.out(outw[6]));
    RAM4K RAM4K_7(.in(in),.load(loadw[7]),.address(address[11:0]),.clk(clk),.out(outw[7]));

    mux81 mux81out(.in(outw),.sel(address[14:12]),.out(out));

endmodule