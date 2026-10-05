`timescale 1ns/1ps

module alu_tb;

    logic [3:0] a;
    logic [3:0] b;
    logic [1:0] op;

    logic [3:0] result;
    logic       zero;

    integer pass_count;
    integer fail_count;

    // Connect ALU
    alu uut (
        .a(a),
        .b(b),
        .op(op),
        .result(result),
        .zero(zero)
    );

    // Task to check the result
    task check_result(
        input [3:0] expected_result,
        input       expected_zero
    );
        begin
            #10;

            if ((result == expected_result) &&
                (zero == expected_zero)) begin

                $display("PASS: A=%d B=%d OP=%b RESULT=%d ZERO=%b",
                         a, b, op, result, zero);

                pass_count = pass_count + 1;

            end
            else begin

                $display("FAIL: A=%d B=%d OP=%b RESULT=%d ZERO=%b",
                         a, b, op, result, zero);

                $display("      EXPECTED: RESULT=%d ZERO=%b",
                         expected_result, expected_zero);

                fail_count = fail_count + 1;

            end
        end
    endtask

    initial begin

        // Waveform generation
        $dumpfile("alu.vcd");
        $dumpvars(0, alu_tb);

        pass_count = 0;
        fail_count = 0;

        // ADD: 3 + 2 = 5
        a = 4'd3;
        b = 4'd2;
        op = 2'b00;
        check_result(4'd5, 1'b0);

        // SUBTRACT: 6 - 2 = 4
        a = 4'd6;
        b = 4'd2;
        op = 2'b01;
        check_result(4'd4, 1'b0);

        // AND: 12 & 10 = 8
        a = 4'd12;
        b = 4'd10;
        op = 2'b10;
        check_result(4'd8, 1'b0);

        // OR: 12 | 10 = 14
        a = 4'd12;
        b = 4'd10;
        op = 2'b11;
        check_result(4'd14, 1'b0);

        // ZERO TEST: 5 - 5 = 0
        a = 4'd5;
        b = 4'd5;
        op = 2'b01;
        check_result(4'd0, 1'b1);

        // Final report
        $display("");
        $display("==============================");
        $display("       ALU TEST SUMMARY");
        $display("==============================");
        $display("PASS = %d", pass_count);
        $display("FAIL = %d", fail_count);
        $display("==============================");

        if (fail_count == 0)
            $display("ALL TESTS PASSED!");
        else
            $display("SOME TESTS FAILED!");

        $finish;

    end

endmodule