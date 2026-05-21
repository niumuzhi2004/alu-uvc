class alu_agent extends uvm_agent;
    `uvm_component_utils(alu_agent)

    alu_sequencer sequencer;
    alu_monitor   monitor;
    alu_driver    driver;

    // active mode:  instantiates sequencer, driver, and monitor
    // passive mode: instantiates monitor only 

    function new(string name = "alu_agent", uvm_component parent = null);
        super.new(name, parent);
    endfunction

    function void build_phase(uvm_phase phase);
        super.build_phase(phase);
        if (is_active == UVM_ACTIVE) begin
            sequencer = alu_sequencer::type_id::create("sequencer", this);
            driver    = alu_driver::type_id::create("driver", this);
        end
        monitor = alu_monitor::type_id::create("monitor", this);
    endfunction

    function void connect_phase(uvm_phase phase);
        super.connect_phase(phase);
        if (is_active == UVM_ACTIVE) 
            driver.seq_item_port.connect(sequencer.seq_item_export);
    endfunction
endclass