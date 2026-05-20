`include "uvm_macros.svh"

import alu_pkg::*;
import uvm_pkg::*;

class alu_base_seq extends uvm_sequence #(alu_seq_item);
    `uvm_object_utils(alu_base_seq)

    function new(string name = "alu_base_seq");
        super.new(name);
    endfunction

    task body();
        repeat (20) begin
            req = alu_seq_item::type_id::create("req");
            start_item(req);
            if (!req.randomize()) begin
                `uvm_error("BODY", "Randomization failure")
            end
            finish_item(req);
        end
    endtask

endclass