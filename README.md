# Microprogrammed Fibonacci Generator

## Problem Understanding
Implemented a microprogrammed controller that generates the Fibonacci sequence (0, 1, 1, 2, 3, 5, 8, 13, 21, 34) using:
- **Control Unit (FSM)**: Manages states (IDLE → INIT → OP → DONE)
- **Datapath**: Contains registers t0, t1, n and ALU for calculations
- **Microprogram**: Control signals direct the data flow

### Input/Output
- **Inputs**: clk, reset, start
- **Outputs**: fib_out (8-bit Fibonacci number), done_tick, current_state

## Approach
1. Created FSM with 4 states controlling the flow
2. Implemented datapath with:
   - t0: holds F(n-2) 
   - t1: holds F(n-1)
   - n: counter (0 to 9)
3. ALU performs addition: F(n) = F(n-1) + F(n-2)
4. Counter increments from 0 to 9 (TARGET = 9)

## Challenges Faced
1. **Multi-driven net error** - done_tick had multiple drivers
   - Fixed by using single sequential always block
   
2. **Latch inference** - signals not properly assigned
   - Fixed by using proper register assignments in always blocks
   
3. **Wrong output (0x55 instead of 0x37)** - counter was decrementing
   - Changed from n = n - 1 to n = n + 1
   
4. **State width mismatch** - current_state was 4-bit
   - Changed to 3-bit to match states (IDLE, INIT, OP, DONE)

## Files Implemented
Controller.v
datapath.v
Top.v
fibonacci_tb.v

<img width="407" height="546" alt="image" src="https://github.com/user-attachments/assets/946e76e8-28b1-4488-8ee9-fa7c2fa005de" />

