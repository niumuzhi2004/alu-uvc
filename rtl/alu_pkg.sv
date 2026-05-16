package alu_pkg;

// operation code for ALU
typedef enum logic [2:0] { 
    ADD = 3'b000,
    SUB = 3'b001,
    AND = 3'b010,
    OR  = 3'b011,
    XOR = 3'b100,
    NOT = 3'b101,
    SHL = 3'b110,
    SHR = 3'b111
} operation_t;
    
endpackage