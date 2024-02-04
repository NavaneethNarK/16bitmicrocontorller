module ram16k(in,load,address,clk,out,p0,p1,p2,p3);
    input [15:0] in;
    input [14:0] address;
    input load,clk;
    output [15:0] out,p0,p1,p2,p3;
    reg [15:0] temp [16383:0];

    always@(posedge clk)begin
        if(load) begin
            temp[address] <= in;
        end
    end
    assign out = temp[address];
    assign p0 = temp[15'h0000];
    assign p1 = temp[15'h1000];
    assign p2 = temp[15'h2000];
    assign p3 = temp[15'h3000];
endmodule