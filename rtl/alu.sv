import alu_pkg::*;

module alu #(
    parameter BIT_WIDTH = 8
) (
    input  logic [ BIT_WIDTH-1 : 0 ] A,     // operand A
    input  logic [ BIT_WIDTH-1 : 0 ] B,     // operand B
    input  operation_t              op,    // 3-bit operation select

    output logic [ BIT_WIDTH-1 : 0 ] result,
    output logic                     zero,  // zero flag
    output logic                     cout   // overflow flag
);

    always_comb begin
        case (op)
            ADD: {cout, result} = A + B;
            SUB: {cout, result} = A - B;
            AND: {cout, result} = A & B;
            OR:  {cout, result} = A | B;
            XOR: {cout, result} = A ^ B;
            NOT: begin
                result = ~A;
                cout   = 1'b0; // not applicable
            end
            SHL: {cout, result} = {1'b0, A} << 1;
            SHR: begin
                result = A >> 1;
                cout   = A[0]; // wrap around
            end

            default: {cout, result} = {(BIT_WIDTH+1){1'b0}};
        endcase

        zero = (result == 0);
    end
    
endmodule