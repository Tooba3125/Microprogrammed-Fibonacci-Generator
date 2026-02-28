`timescale 1ns/1ps

module Controller (
    input wire clk,
    input wire reset,
    input wire start,
    input wire n_eq_target,
    output wire [11:0] control_signals,
    output wire done_tick,
    output wire [2:0] current_state
);
    
    // State encoding 
    localparam IDLE  = 3'd0;
    localparam INIT  = 3'd1;
    localparam OP    = 3'd2;
    localparam DONE  = 3'd3;
    
    // State register
    reg [2:0] state, next_state;
    
    // Control signals
    reg [11:0] ctrl_signals;
    reg done_tick_next;
    
    // State register - SEQUENTIAL
    always @(posedge clk or posedge reset) begin
        if (reset) begin
            state <= IDLE;
        end else begin
            state <= next_state;
        end
    end
    
    // Done tick - SEQUENTIAL
    always @(posedge clk or posedge reset) begin
        if (reset) begin
            done_tick_next <= 1'b0;
        end else begin
            done_tick_next <= (next_state == DONE);
        end
    end
    
    // Next state and control signals - COMBINATIONAL
    always @(*) begin
        next_state = IDLE;
        ctrl_signals = 12'b0;
        
        case (state)
            IDLE: begin
                if (start)
                    next_state = INIT;
                else
                    next_state = IDLE;
            end
            
            INIT: begin
                // t0 = 0, t1 = 1, n = 0
                ctrl_signals[11] = 1'b1;  // load_t0
                ctrl_signals[10] = 1'b1;  // load_t1
                ctrl_signals[9] = 1'b1;   // load_n
                next_state = OP;
            end
            
            OP: begin
                if (n_eq_target) begin
                    next_state = DONE;
                end else begin
                    // Calculate next: t1 <= t1 + t0, t0 <= t1, n <= n + 1
                    ctrl_signals[11] = 1'b1;  // load_t0
                    ctrl_signals[10] = 1'b1;  // load_t1
                    ctrl_signals[9] = 1'b1;   // load_n
                    ctrl_signals[8] = 1'b1;   // alu_add
                    next_state = OP;
                end
            end
            
            DONE: begin
                next_state = IDLE;
            end
            
            default: next_state = IDLE;
        endcase
    end
    
    // Output assignments
    assign control_signals = ctrl_signals;
    assign done_tick = done_tick_next;
    assign current_state = state;
    
endmodule
