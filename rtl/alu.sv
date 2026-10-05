module alu (
    input  logic [3:0] a,
    input  logic [3:0] b,
    input  logic [1:0] op,

    output logic [3:0] result,
    output logic       zero
);

    always_comb begin

        case (op)
            2'b00: result = a + b;  // ADD
            2'b01: result = a - b;  // SUBTRACT
            2'b10: result = a & b;  // AND
            2'b11: result = a | b;  // OR
            default: result = 4'b0000;
        endcase

        // Zero flag
        if (result == 4'b0000)
            zero = 1'b1;
        else
            zero = 1'b0;

    end

endmodule