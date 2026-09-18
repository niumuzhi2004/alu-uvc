import alu_pkg::*;

module alu_1bit (
    input  logic A,
    input  logic B,
    input  logic Cin,
    input  logic Less,
    input  logic Ainv,
    input  logic Binv,
    input  logic [2:0] op,
    output logic Result,
    output logic Cout,
    output logic Adder_out
);

    logic Am, Bm;

    always_comb begin
        Am   = Ainv ? ~A : A;
        Bm   = Binv ? ~B : B;
        Cout = (Am & Bm) | (Cin & Am) | (Bm & Cin);
        Adder_out =  Am ^ Bm ^ Cin;

        case (op)
            ADD:  Result = Am ^ Bm ^ Cin;
            SUB:  Result = Am ^ Bm ^ Cin;
            AND:  Result = Am & Bm;
            OR:   Result = Am | Bm;
            XOR:  Result = Am ^ Bm;
            NAND: Result = Am | Bm;
            NOR:  Result = Am & Bm;
            SLT:  Result = Less;
            default: Result = 1'b0;
        endcase
    end
    
endmodule

module alu #(
    parameter BIT_WIDTH = 8
) (
    input  logic [ BIT_WIDTH-1 : 0 ] A,     // operand A
    input  logic [ BIT_WIDTH-1 : 0 ] B,     // operand B
    input  operation_t              op,     // 3-bit operation select

    output logic [ BIT_WIDTH-1 : 0 ] result,
    output logic                     zero,  // zero flag
    output logic                     cout   // overflow flag
);

    logic Less_0, set, overflow, Ainv, Binv;
    logic [ BIT_WIDTH-1 : 0 ] Less, Adder_out;
    logic [ BIT_WIDTH : 0 ]   Carry;         // Carry[0] = Cin

    always_comb begin
        Ainv     = (op inside {NAND, NOR}) ? 1'b1 : 1'b0;
        Binv     = (op inside {SUB, SLT, NAND, NOR}) ? 1'b1 : 1'b0;
        Carry[0] = (op inside {SUB, SLT}) ? 1'b1 : 1'b0;
        set      = Adder_out[BIT_WIDTH-1];
        overflow = Carry[BIT_WIDTH-1] ^ Carry[BIT_WIDTH];
        cout     = (op inside {SUB, ADD}) ? Carry[BIT_WIDTH]: 1'b0;
        Less_0   = set ^ overflow;
        zero     = ~ (|result);
        Less     = Less_0;
    end

    genvar j;
    generate
        for (j = 0; j < BIT_WIDTH; ++j) begin
            alu_1bit alu1 (
                .A(A[j]),
                .B(B[j]),
                .Cin(Carry[j]),
                .Less(Less[j]),
                .Ainv(Ainv),
                .Binv(Binv),
                .op(op),
                .Result(result[j]),
                .Cout(Carry[j+1]),
                .Adder_out(Adder_out[j])
            );
        end
    endgenerate
    
endmodule