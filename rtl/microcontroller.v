module microcontroller(programIN,LMin,reset,clk);
    input [15:0] programIN;
    input LMin,reset,clk;
    wire [15:0] rom_data, instruction, ram_r_data, ram_w_data;
    wire [14:0] rom_address, PC, ram_address;
    wire rom_write, ram_write;

    programmer  programmer1(.programIn(programIN),
                            .PC(PC),
                            .reset(reset),
                            .LMin(LMin),
                            .clk(clk),
                            .programOut(rom_data),
                            .address(rom_address),
                            .LMout(rom_write));
    
    mem16k      ROM1(       .in(rom_data),
                            .load(rom_write),
                            .address(rom_address),
                            .clk(clk),
                            .out(instruction));

    cpu         CPU(        .inM(ram_r_data),
                            .inst(instruction),
                            .reset(reset),
                            .clk(clk),
                            .outM(ram_w_data),
                            .writeM(ram_write),
                            .addressM(ram_address),
                            .PC(PC));

    mem16k      RAM1(       .in(ram_w_data),
                            .load(ram_write),
                            .address(ram_address),
                            .clk(clk),
                            .out(ram_r_data));
endmodule