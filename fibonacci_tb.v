`timescale 1ns/1ps

module `timescale 1ns/1ps

module fibonacci_tb;

// Input signals
reg clk;
reg reset;
reg start;

// Output signals
wire [7:0] fib_out;
wire done_tick;
wire [2:0] current_state;

// Expected Fibonacci values
wire [7:0] expected_val;
reg [7:0] expected_array [0:9];
reg [7:0] expected_reg;
integer count;

// Clock generation - 20ns period
always #10 clk = ~clk;

// Instantiate the design under test
Top uut (
    .clk(clk),
    .reset(reset),
    .start(start),
    .fib_out(fib_out),
    .done_tick(done_tick),
    .current_state(current_state)
);

// Track which Fibonacci number we expect
assign expected_val = expected_reg;

// Initialize expected values
initial begin
    expected_array[0] = 0;
    expected_array[1] = 1;
    expected_array[2] = 1;
    expected_array[3] = 2;
    expected_array[4] = 3;
    expected_array[5] = 5;
    expected_array[6] = 8;
    expected_array[7] = 13;
    expected_array[8] = 21;
    expected_array[9] = 34;
end

// Counter to track which Fibonacci number we're on
always @(posedge clk or posedge reset) begin
    if (reset) begin
        count <= 0;
        expected_reg <= 0;
    end
    else if (done_tick && count < 10) begin
        expected_reg <= expected_array[count];
        count <= count + 1;
    end
end

// Initialize and run test
initial begin
    clk = 0;
    reset = 1;
    start = 0;
    
    #50;
    reset = 0;
    #30;
    
    start = 1;
    #20;
    start = 0;
    
    #10000;
    $finish;
end

// Generate waveform dump file
initial begin
    $dumpfile("fibonacci.vcd");
    $dumpvars(0, fibonacci_tb);
end

endmodule;

// Input signals
reg clk;
reg reset;
reg start;

// Output signals
wire [7:0] fib_out;
wire done_tick;
wire [2:0] current_state;

// Expected Fibonacci values
wire [7:0] expected_val;
reg [7:0] expected_array [0:9];
reg [7:0] expected_reg;
integer count;

// Clock generation - 20ns period
always #10 clk = ~clk;

// Instantiate the design under test
Top uut (
    .clk(clk),
    .reset(reset),
    .start(start),
    .fib_out(fib_out),
    .done_tick(done_tick),
    .current_state(current_state)
);

// Track which Fibonacci number we expect
assign expected_val = expected_reg;

// Initialize expected values
initial begin
    expected_array[0] = 0;
    expected_array[1] = 1;
    expected_array[2] = 1;
    expected_array[3] = 2;
    expected_array[4] = 3;
    expected_array[5] = 5;
    expected_array[6] = 8;
    expected_array[7] = 13;
    expected_array[8] = 21;
    expected_array[9] = 34;
end

// Counter to track which Fibonacci number we're on
always @(posedge clk or posedge reset) begin
    if (reset) begin
        count <= 0;
        expected_reg <= 0;
    end
    else if (done_tick && count < 10) begin
        expected_reg <= expected_array[count];
        count <= count + 1;
    end
end

// Initialize and run test
initial begin
    clk = 0;
    reset = 1;
    start = 0;
    
    #50;
    reset = 0;
    #30;
    
    start = 1;
    #20;
    start = 0;
    
    #10000;
    $finish;
end

// Generate waveform dump file
initial begin
    $dumpfile("fibonacci.vcd");
    $dumpvars(0, fibonacci_tb);
end

endmodule
