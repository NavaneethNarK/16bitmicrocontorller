module register(in,load,clk,out);
    input [7:0] in;
    input load,clk;
    output [7:0] out;
    reg [7:0] temp;
    always @(posedge clk) begin
        if(load) begin
            temp = in;
        end
        else begin
            temp = temp;
        end
    end
    assign out = temp;
endmodule