`timescale 1ns/1ps

module Top (
    input wire clk,
    input wire reset,
    input wire start,
    output wire [7:0] fib_out,
    output wire done_tick,
    output wire [2:0] current_state
);

    wire n_eq_target;
    wire [11:0] control_signals;
    wire [7:0] t0, t1, n;
    
    // Control Unit
    Controller cu (
        .clk(clk),
        .reset(reset),
        .start(start),
        .n_eq_target(n_eq_target),
        .control_signals(control_signals),
        .done_tick(done_tick),
        .current_state(current_state)
    );
    
    // Datapath
    datapath dp (
        .clk(clk),
        .reset(reset),
        .control_signals(control_signals),
        .t0(t0),
        .t1(t1),
        .n(n),
        .fib_out(fib_out),
        .n_eq_target(n_eq_target)
    );
    
endmodule
