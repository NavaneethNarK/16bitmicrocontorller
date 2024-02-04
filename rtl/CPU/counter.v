module counter(in,reset,load,inc,clk,out);
    input [14:0] in;
    input reset,load,inc,clk;
    output [14:0] out;
    reg [14:0] temp;
    always@(posedge clk) begin
        if(reset)
            temp <= 15'h7fff;
        else if (load) 
            temp <= in;
        else if (inc)
            temp <= temp + 1;
        else
            temp <= temp; 
    end
    assign out = temp;
endmodule