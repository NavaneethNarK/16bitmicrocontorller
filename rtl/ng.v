module ng(
    input [15:0] din,
    input n,
    output [15:0] dout
);
assign dout = (n)?~din:din;
endmodule