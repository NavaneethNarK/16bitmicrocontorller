module mic_alu(
     x,y,zx,nx,zy,ny,f,no,out,nv,zr
);
    input  [15:0] x,y;
    input  zx,zy,nx,ny,f,no;
    output [15:0] out;
    output nv,zr;
    wire [15:0] zxo,zyo,nxo,nyo,fo;

    zg  zxg(.din(x),.z(zx),.dout(zxo));
    zg  zyg(.din(y),.z(zy),.dout(zyo));

    ng  nxg(.din(zxo),.n(nx),.dout(nxo));
    ng  nyg(.din(zyo),.n(ny),.dout(nyo));

    fg  fxyg(.xin(nxo),.yin(nyo),.f(f),.dout(fo));

    ng  nxyg(.din(fo),.n(no),.dout(out));

    assign nv = out[15];
    assign zr = ~(|out);

endmodule