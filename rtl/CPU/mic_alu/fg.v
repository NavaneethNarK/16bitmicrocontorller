module fg(
    input [15:0] xin,yin,
    input f,
    output [15:0] dout
);
assign dout = (f)?(xin + yin):(xin & yin);
endmodule