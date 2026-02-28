`timescale 1ns/1ps

module datapath (
    input wire clk,
    input wire reset,
    input wire [11:0] control_signals,
    output reg [7:0] t0,
    output reg [7:0] t1,
    output reg [7:0] n,
    output wire [7:0] fib_out,
    output wire n_eq_target
);
    
    // Target: Generate 10 Fibonacci numbers (n = 0 to 9)
    localparam TARGET = 9;
    
    // Control signals - only using bits 11, 10, 9, 8
    wire load_t0, load_t1, load_n, alu_add;
    
    assign load_t0 = control_signals[11];
    assign load_t1 = control_signals[10];
    assign load_n = control_signals[9];
    assign alu_add = control_signals[8];
    
    // ALU
    wire [7:0] alu_result;
    assign alu_result = t1 + t0;
    
    // t0 register
    always @(posedge clk or posedge reset) begin
        if (reset) begin
            t0 <= 8'd0;
        end else if (load_t0) begin
            t0 <= t1;
        end
    end
    
    // t1 register
    always @(posedge clk or posedge reset) begin
        if (reset) begin
            t1 <= 8'd0;
        end else if (load_t1) begin
            if (alu_add)
                t1 <= alu_result;
            else
                t1 <= 8'd1;
        end
    end
    
    // n register - counts UP
    always @(posedge clk or posedge reset) begin
        if (reset) begin
            n <= 8'd0;
        end else if (load_n) begin
            if (!alu_add)
                n <= 8'd0;
            else
                n <= n + 1;
        end
    end
    
    // Check if target reached
    assign n_eq_target = (n >= TARGET);
    
    // Output
    assign fib_out = t1;
    
endmodule
