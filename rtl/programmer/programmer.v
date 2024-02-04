module programmer(programIn,PC,reset,LMin,clk,programOut,address,LMout);
    input [15:0] programIn;
    input [14:0] PC;
    input reset,LMin,clk;
    output [15:0] programOut;
    output [14:0] address;
    output LMout;

    wire [14:0] counterOut;

    mux15_2_1   mux1(.in1(counterOut),.in0(PC),.sel(LMin),.out(address));
    
    counter     count1(.in(15'h0000),.reset(reset),.load(1'b0),.inc(LMin),.clk(clk),.out(counterOut));

    assign LMout = LMin;
    assign programOut = programIn;
endmodule