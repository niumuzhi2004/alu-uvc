class alu_seq_item extends uvm_sequence_item;
    
    rand logic [BIT_WIDTH-1:0] A;
    rand logic [BIT_WIDTH-1:0] B;
    rand operation_t           op;

    logic [BIT_WIDTH-1:0] result;
    logic                 zero;
    logic                 cout;

    `uvm_object_utils_begin(alu_seq_item)
        `uvm_field_int(A, UVM_ALL_ON)
        `uvm_field_int(B, UVM_ALL_ON)
        `uvm_field_enum(operation_t, op, UVM_ALL_ON)
    `uvm_object_utils_end

    // operation is within the valid values
    constraint op_valid {
        op inside { ADD, SUB, AND, OR, XOR, NOT, SHL, SHR };
    }

    // B is not needed for NOT, SHL, and SHR
    constraint single_operand_ops {
        (op == NOT || op == SHL || op == SHR) -> B == 0;
    }

    // coverage-driven constraint for A and B to hit corner cases
    constraint corner_cases {
        A dist { {BIT_WIDTH{1'b0}} := 10, {BIT_WIDTH{1'b1}} := 10 };
        B dist { {BIT_WIDTH{1'b0}} := 10, {BIT_WIDTH{1'b1}} := 10 };
    }

    function new(string name = "alu_seq_item");
        super.new(name);
    endfunction

    // custom method for printing debug statement
    function string convert2string();
        return $sformatf("ALU %s Operation: A = %0d, B = %0d", op.name(), A, B);
    endfunction

endclass