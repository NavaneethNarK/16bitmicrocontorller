module register(in,load,clk,out);
    input [15:0] in;
    input load,clk;
    output [15:0] out;
    reg [15:0] temp;
    always @(posedge clk) begin
        if(load) begin
            temp <= in;
        end
        else begin
            temp <= temp;
        end
    end
    assign out = temp;
endmodule