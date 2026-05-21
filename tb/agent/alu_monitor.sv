class alu_monitor extends uvm_monitor;
    `uvm_component_utils(alu_monitor)

    virtual alu_if vif;
    uvm_analysis_port #(alu_seq_item) alu_ap;

    function new(string name = "alu_monitor", uvm_component parent = null);
        super.new(name, parent);
    endfunction

    function void build_phase(uvm_phase phase);
        super.build_phase(phase);
        alu_ap = new("alu_ap", this); // instantiate analysis port

        if (!uvm_config_db #(virtual alu_if)::get(this, "", "vif", vif)) 
            `uvm_fatal("NO_VIF", "Virtual interface not found in config db!")
    endfunction
    
    task run_phase(uvm_phase phase);
        alu_seq_item mon_item;

        forever begin
            @(vif.monitor_cb);
            mon_item = alu_seq_item::type_id::create("mon_item");
            mon_item.A      = vif.monitor_cb.A;
            mon_item.B      = vif.monitor_cb.B;
            mon_item.op     = operation_t'(vif.monitor_cb.op);
            mon_item.result = vif.monitor_cb.result;
            mon_item.zero   = vif.monitor_cb.zero;
            mon_item.cout   = vif.monitor_cb.cout;
            alu_ap.write(mon_item);
        end
    endtask

endclass