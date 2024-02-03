module jmpctrl(j1,j2,j3,zr,nv,cj);
    input j1,j2,j3,zr,nv;
    output cj;
  assign cj = ((j1&nv)|(j2&zr)|(j3&~(nv|zr)));
endmodule