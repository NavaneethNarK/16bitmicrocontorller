module cpu(inM,inst,reset,clk,outM,writeM,addressM,PC);
    input [15:0] inM,inst;
    input reset,clk;
    output [15:0] outM;
    output [14:0] addressM,PC;
    output writeM;
    wire [15:0] m1,m2,ra,rd,aluo;
    wire pcLoad,zr,nv;
    wire op,a,c1,c2,c3,c4,c5,c6,d1,d2,d3,j1,j2,j3;
    wire loada;

    assign {a,c1,c2,c3,c4,c5,c6,d1,d2,d3,j1,j2,j3} = inst[12:0];
    assign op = inst[15];
    assign loada = d1|~op;

    mux16_2_1   inst_alu_MUX(.in1(aluo),.in0(inst),.sel(op),.out(m1));
    mux16_2_1   regA_inM_MUX(.in1(inM),.in0(ra),.sel(a),.out(m2));

    register    regA(.in(m1),.load(loada),.clk(clk),.out(ra));
    register    regD(.in(aluo),.load(d2),.clk(clk),.out(rd));

    jmpctrl     jctrl(.j1(j1),.j2(j2),.j3(j3),.zr(zr),.nv(nv),.cj(pcLoad));

    counter     programCtr(.in(ra[14:0]),.reset(reset),.load(pcLoad),.inc(1'b1),.clk(clk),.out(PC));

    mic_alu     alu(.x(rd),.y(m2),.zx(c1),.nx(c2),.zy(c3),.ny(c4),.f(c5),.no(c6),.out(aluo),.nv(nv),.zr(zr));

    assign outM = aluo;
    assign writeM = d3;
    assign addressM = ra;
endmodule