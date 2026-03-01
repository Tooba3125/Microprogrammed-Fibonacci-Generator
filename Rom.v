`timescale 1ns/1ps

module rom (
    input  [3:0] addr,
    output [15:0] data
);

    reg [15:0] mem [0:15];
    
    initial begin
        mem[0]  = 16'h0000;  // IDLE: NOP
        mem[1]  = 16'h0E00;  // INIT: load_t0=1, load_t1=1, load_n=1, alu_add=0
        mem[2]  = 16'h0000;  // CHECK: NOP
        mem[3]  = 16'h0F00;  // COMPUTE: load_t0=1, load_t1=1, load_n=1, alu_add=1
        mem[4]  = 16'h0000;  // DONE: NOP
        mem[5]  = 16'h0000;
        mem[6]  = 16'h0000;
        mem[7]  = 16'h0000;
        mem[8]  = 16'h0000;
        mem[9]  = 16'h0000;
        mem[10] = 16'h0000;
        mem[11] = 16'h0000;
        mem[12] = 16'h0000;
        mem[13] = 16'h0000;
        mem[14] = 16'h0000;
        mem[15] = 16'h0000;
    end
    
    assign data = mem[addr];

endmodule
