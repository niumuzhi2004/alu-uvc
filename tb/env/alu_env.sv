`include "uvm_macros.svh"

import alu_pkg::*;
import uvm_pkg::*;

class alu_env extends uvm_env;
    `uvm_component_utils(alu_env)

    alu_agent      agent;
    alu_scoreboard scoreboard;
    alu_coverage   cover;

    function new(string name = "alu_env", uvm_component parent = null);
        super.new(name, parent);
    endfunction

    function void build_phase(uvm_phase phase);
        super.build_phase(phase);
        agent = alu_agent::type_id::create("agent", this);
        scoreboard = alu_scoreboard::type_id::create("scoreboard", this);
        cover = alu_coverage::type_id::create("coverage", this);
    endfunction

    function void connect_phase(uvm_phase phase);
        super.connect_phase(phase);
        agent.monitor.alu_ap.connect(scoreboard.score_imp);
        agent.monitor.alu_ap.connect(cover.analysis_export);
    endfunction

endclass