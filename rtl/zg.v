module zg(
    input [15:0] din,
    input z,
    output [15:0] dout
);
assign dout = (z)?16'h0000:din;
endmodule