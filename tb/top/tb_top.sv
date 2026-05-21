`include "uvm_macros.svh"

import alu_pkg::*;
import uvm_pkg::*;
import alu_tb_pkg::*;

module tb_top();

    logic clk = 0;
    always #5 clk = ~clk; // clock generation

    alu_if alu_if_inst(clk);

    alu dut (
        .A     (alu_if_inst.A),
        .B     (alu_if_inst.B),
        .op    (alu_if_inst.op),
        .result(alu_if_inst.result),
        .cout  (alu_if_inst.cout),
        .zero  (alu_if_inst.zero)
    );

    initial begin
        uvm_config_db #(virtual alu_if)::set(null, "uvm_test_top.*", "vif", alu_if_inst);
        run_test();
    end

endmodule