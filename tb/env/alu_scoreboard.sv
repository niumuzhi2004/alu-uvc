`include "uvm_macros.svh"

import alu_pkg::*;
import uvm_pkg::*;

class alu_scoreboard extends uvm_scoreboard;
    `uvm_component_utils(alu_scoreboard)

    // receive transactions from monitor
    uvm_analysis_imp #(alu_seq_item, alu_scoreboard) score_imp;

    function new(string name = "alu_scoreboard", uvm_component parent = null);
        super.new(name, parent);
    endfunction

    function void build_phase(uvm_phase phase);
        super.build_phase(phase);
        score_imp = new("score_imp", this);
    endfunction

    function void write(alu_seq_item item);
        logic [BIT_WIDTH-1:0] exp_result;
        logic                 exp_zero;
        logic                 exp_cout;

        // replicate ALU logic
        case (item.op)
            ADD: {exp_cout, exp_result} = item.A + item.B;
            SUB: {exp_cout, exp_result} = item.A - item.B;
            AND: {exp_cout, exp_result} = item.A & item.B;
            OR:  {exp_cout, exp_result} = item.A | item.B;
            XOR: {exp_cout, exp_result} = item.A ^ item.B;
            NOT: begin
                exp_result = ~item.A;
                exp_cout   = 1'b0; // not applicable
            end
            SHL: {exp_cout, exp_result} = {1'b0, item.A} << 1;
            SHR: begin
                exp_result = item.A >> 1;
                exp_cout   = item.A[0];  // wrap around
            end

            default: begin
                `uvm_fatal("INVALID_OP", $sformatf("Invalid operation: %0d", item.op))
            end
        endcase

        exp_zero = (exp_result == 0);

        if (exp_result == item.result && exp_zero == item.zero && exp_cout == item.cout) 
            `uvm_info("SCORE", $sformatf(
                "Test passed: A = %0d,\t B = %0d,\t op = %s.",
                item.A, item.B, item.op.name()
            ), UVM_LOW)
        else
            `uvm_error("SCORE", $sformatf(
                "Test failed: A = %0d,\t B = %0d,\t op = %s.",
                item.A, item.B, item.op.name()
            ))
    endfunction

endclass