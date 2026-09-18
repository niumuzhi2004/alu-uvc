package alu_pkg;

    // operation code for ALU
    typedef enum logic [2:0] { 
        ADD  = 3'b000,
        SUB  = 3'b001,
        AND  = 3'b010,
        OR   = 3'b011,
        XOR  = 3'b100,
        NAND = 3'b101,
        NOR  = 3'b110,
        SLT  = 3'b111
    } operation_t;

parameter int BIT_WIDTH = 8;
    
endpackage