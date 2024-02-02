module mux81(in,sel,out);
    input [15:0] in [7:0];
    input [2:0] sel;
    output [15:0] out;
    reg [15:0] temp;

    always@(*) begin
        case(sel)
            3'b000:temp = in[0];
            3'b001:temp = in[1];
            3'b010:temp = in[2];
            3'b011:temp = in[3];
            3'b100:temp = in[4];
            3'b101:temp = in[5];
            3'b110:temp = in[6];
            3'b111:temp = in[7];
            default:temp = 8'h00;
        endcase
    end
    assign out = temp;
endmodule