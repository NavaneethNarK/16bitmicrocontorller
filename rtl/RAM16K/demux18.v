module demux18(in,sel,out);
    input in;
    input [2:0] sel;
    output [7:0] out;
    reg [7:0] temp;
    always @(*) begin
        case (sel)
            3'b000:temp = 8'h01;
            3'b001:temp = 8'h02;
            3'b010:temp = 8'h04;
            3'b011:temp = 8'h08;
            3'b100:temp = 8'h10;
            3'b101:temp = 8'h20;
            3'b110:temp = 8'h40;
            3'b111:temp = 8'h80;
            default:temp = 8'h00;
        endcase
    end
    assign out = (in)?temp:8'h00;
endmodule
