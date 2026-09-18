class alu_scoreboard extends uvm_scoreboard;
    `uvm_component_utils(alu_scoreboard)

    // receive transactions from monitor
    uvm_analysis_imp #(alu_seq_item, alu_scoreboard) score_imp;
    int pass_count, fail_count, total_count;

    function new(string name = "alu_scoreboard", uvm_component parent = null);
        super.new(name, parent);
    endfunction

    function void build_phase(uvm_phase phase);
        super.build_phase(phase);
        score_imp = new("score_imp", this);
    endfunction

    function void check_phase(uvm_phase phase);
        super.check_phase(phase);
        `uvm_info("SCORE", $sformatf("%0d instructions tested: %0d instructions passed, %0d failed.", total_count, pass_count, fail_count), UVM_LOW)
    endfunction

    function void write(alu_seq_item item);
        logic [BIT_WIDTH-1:0] exp_result;
        logic                 exp_zero;
        logic                 exp_cout = 1'b0;

        // replicate ALU logic
        case (item.op)
            ADD:  {exp_cout, exp_result} = item.A + item.B;
            SUB:  begin
                exp_cout   = (item.A >= item.B); 
                exp_result = item.A - item.B;
            end
            AND:  exp_result = item.A & item.B;
            OR:   exp_result = item.A | item.B;
            XOR:  exp_result = item.A ^ item.B;
            NAND: exp_result = ~(item.A & item.B);
            NOR:  exp_result = ~(item.A | item.B);
            SLT:  exp_result = ($signed(item.A) < $signed(item.B));

            default: begin
                `uvm_fatal("INVALID_OP", $sformatf("Invalid operation: %0d", item.op))
            end
        endcase

        exp_zero    = (exp_result == 0);
        total_count = total_count + 1;

        if (exp_result == item.result && exp_zero == item.zero && exp_cout == item.cout) begin 
            `uvm_info("SCORE", $sformatf(
                "Test passed: A = %0d,\t B = %0d,\t op = %s.",
                item.A, item.B, item.op.name()
            ), UVM_LOW)
            pass_count = pass_count + 1;
        end else begin
            `uvm_error("SCORE", $sformatf(
                "Test failed: A = %0d,\t B = %0d,\t op = %s.",
                item.A, item.B, item.op.name()
            ))

            if (exp_result != item.result) begin
                `uvm_error("SCORE", $sformatf(
                    "Result mismatch: Expecting %0d, Got %0d",
                    exp_result, item.result
                ))
            end

            if (exp_zero != item.zero) begin
                `uvm_error("SCORE", $sformatf(
                    "Zero flag mismatch: Expecting %0d, Got %0d",
                    exp_zero, item.zero
                ))
            end

            if (exp_cout != item.cout) begin
                `uvm_error("SCORE", $sformatf(
                    "Carry-out mismatch: Expecting %0d, Got %0d",
                    exp_cout, item.cout
                ))
            end
            
            fail_count = fail_count + 1;
        end
    endfunction

endclass