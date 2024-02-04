module microcontroller_tb;
    reg [15:0] programIN;
    reg LMin,reset,clk;

    microcontroller dut(programIN,LMin,reset,clk);

    always #5 clk = ~clk;

    initial begin
        clk = 0;
        reset = 1;
        #15;
        reset = 0;
        LMin = 1;
        programIN = 16'h0005;
        #10;
        programIN = 16'hec10;
        #10;
        programIN = 16'h0001;
        #10;
        programIN = 16'he308;
        #10;
        programIN = 16'h0000;
        #10;
        programIN = 16'he007;
        #10;
        LMin =0;
        reset = 1;
        #10;
        reset = 0;
        #200;
        $finish();
    end
endmodule