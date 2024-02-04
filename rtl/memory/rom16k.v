module rom16k(in,load,address,clk,out);
    input [15:0] in;
    input [14:0] address;
    input load,clk;
    output [15:0] out;
    reg [15:0] temp [16383:0];

    always@(posedge clk)begin
        if(load) begin
            temp[address] <= in;
        end
    end
    assign out = temp[address];
endmodule