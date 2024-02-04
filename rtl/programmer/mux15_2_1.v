module mux15_2_1(in1,in0,sel,out);
    input [14:0] in1,in0;
    input sel;
    output [14:0] out;
    assign out = (sel)?in1:in0;
endmodule