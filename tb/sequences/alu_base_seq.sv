class alu_base_seq extends uvm_sequence #(alu_seq_item);
    `uvm_object_utils(alu_base_seq)

    operation_t op_list[8] = '{ ADD, SUB, AND, OR, XOR, NAND, NOR, SLT };

    function new(string name = "alu_base_seq");
        super.new(name);
    endfunction

    task body();

        // first iteration
        repeat (200) begin
            req = alu_seq_item::type_id::create("req");
            start_item(req);
            if (!req.randomize()) begin
                `uvm_error("BODY", "Randomization failure")
            end
            finish_item(req);
        end

        // second iteration directly testing zero results for cross coverage
        foreach (op_list[i]) begin
            req = alu_seq_item::type_id::create("req");
            start_item(req);

            if (!req.randomize() with {
                op == op_list[i]; // fix op to the current operation value

                // let solver find A and B that produce zero result for the given operation
                (op == ADD) -> (A + B == 0);
                (op == SUB) -> (A == B);
                (op == AND) -> ((A & B) == 0);
                (op == OR)  -> (A == 0 && B == 0);
                (op == XOR) -> ((A ^ B) == 0);
                (op == NAND) -> (A == 255 && B == 255); 
                (op == NOR) -> (A == 255 || B == 255);
                (op == SLT) -> (A == 0);
            }) begin
                `uvm_error("BODY", "Randomization failure")
            end

            finish_item(req);
        end
    endtask

endclass