`ifndef ALU_TB_PKG_SV
`define ALU_TB_PKG_SV

package alu_tb_pkg;

    import alu_pkg::*;
    import uvm_pkg::*;
    `include "uvm_macros.svh"

    `include "./agent/alu_seq_item.sv"
    `include "./agent/alu_sequencer.sv"
    `include "./agent/alu_monitor.sv"
    `include "./agent/alu_driver.sv"
    `include "./agent/alu_agent.sv"
    `include "./sequences/alu_base_seq.sv"
    `include "./env/alu_scoreboard.sv"
    `include "./env/alu_coverage.sv"
    `include "./env/alu_env.sv"
    `include "./tests/alu_test.sv"

endpackage

`endif