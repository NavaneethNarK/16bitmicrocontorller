module counter(in,reset,load,inc,clk,out);
    input [15:0] in;
    input reset,load,inc,clk;
    output [15:0] out;
    reg [15:0] temp;
    always@(posedge clk) begin
        if(reset)
            temp <= 16'h0000;
        else if (load) 
            temp <= in;
        else if (inc)
            temp <= temp + 1;
        else
            temp <= temp; 
    end
    assign out = temp;
endmodule