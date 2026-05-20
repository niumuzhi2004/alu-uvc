`include "uvm_macros.svh"

import alu_pkg::*;
import uvm_pkg::*;

class alu_coverage extends uvm_subscriber #(alu_seq_item);
    `uvm_component_utils(alu_coverage)

    logic [BIT_WIDTH-1:0] A;
    logic [BIT_WIDTH-1:0] B;
    operation_t          op;
    logic        zero, cout;


    covergroup alu_covergroup with function sample();
        // track coverage info for each instance
        option.per_instance = 1;

        cp_op: coverpoint op {
            bins add    = {ADD};
            bins sub    = {SUB};
            bins and_op = {AND};
            bins or_op  = {OR};
            bins xor_op = {XOR};
            bins not_op = {NOT};
            bins shl    = {SHL};
            bins shr    = {SHR};
        }

        cp_A: coverpoint A {
            bins zero = {  8'h00  };
            bins smal = { [8'h01:8'h3F] };
            bins larg = { [8'h40:8'hFE] };
            bins max  = {  8'hFF  };
        }

        cp_B: coverpoint B {
            bins zero = {  8'h00  };
            bins smal = { [8'h01:8'h3F] };
            bins larg = { [8'h40:8'hFE] };
            bins max  = {  8'hFF  };
        }

        cp_cout: coverpoint cout {
            bins zero = { 0 };
            bins one  = { 1 };
        }

        cp_zero: coverpoint zero {
            bins not_detected  = { 0 };
            bins zero_detected = { 1 };
        }

        cp_op_zero: cross cp_op, cp_zero;
    endgroup

    function new(string name = "alu_coverage", uvm_component parent = null);
        super.new(name, parent);
        alu_covergroup = new();
    endfunction

    function void write(alu_seq_item item);
        A    = item.A;
        B    = item.B;
        op   = item.op;
        zero = item.zero;
        cout = item.cout;
        alu_covergroup.sample();
    endfunction

endclass