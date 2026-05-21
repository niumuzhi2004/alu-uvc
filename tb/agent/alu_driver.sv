class alu_driver extends uvm_driver #(alu_seq_item);
    `uvm_component_utils(alu_driver)

    virtual alu_if vif;

    function new(string name = "alu_driver", uvm_component parent = null);
        super.new(name, parent);
    endfunction

    function void build_phase(uvm_phase phase);
        super.build_phase(phase);
        if (!uvm_config_db #(virtual alu_if) ::get(this, "", "vif", vif))
            `uvm_fatal("NO_VIF", "Virtual interface not found in config db!")
    endfunction

    task run_phase(uvm_phase phase);
        forever begin 
            seq_item_port.get_next_item(req);
            drive_item2bus(req);
            seq_item_port.item_done();
        end
    endtask

    task drive_item2bus(alu_seq_item req);
        vif.driver_cb.A  <= req.A;
        vif.driver_cb.B  <= req.B;
        vif.driver_cb.op <= req.op;
        @(vif.driver_cb);
    endtask

endclass