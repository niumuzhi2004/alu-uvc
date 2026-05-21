interface alu_if #( parameter BIT_WIDTH = 8 ) ( input logic clk );

    logic [BIT_WIDTH-1:0] A;
    logic [BIT_WIDTH-1:0] B;
    operation_t op;

    logic [BIT_WIDTH-1:0] result;
    logic zero;
    logic cout;

    clocking driver_cb @ (posedge clk);
        default input #1 output #1;
        input result, zero, cout;
        output A, B, op;
    endclocking

    clocking monitor_cb @ (posedge clk);
        default input #1;
        input A, B, op, result, zero, cout;
    endclocking

    modport driver_port (clocking driver_cb, input clk);

    modport monitor_port (clocking monitor_cb, input clk);
    
endinterface