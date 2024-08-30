`timescale 1ns/1ns

`define SECOND 1000000000
`define MS 1000000

module four_bit_comparator_always_tb();
    reg [3:0] a, b;
    wire greater, less, equal;

    four_bit_comparator_always DUT (
        .a(a),
        .b(b),
        .greater(greater),
        .less(less),
        .equal(equal)
    );

    integer i;

    initial begin
        `ifdef IVERILOG
            $dumpfile("four_bit_comparator_always_tb.fst");
            $dumpvars(0, four_bit_comparator_always_tb);
        `endif
        `ifndef IVERILOG
            $vcdpluson;
        `endif

        for(i = 0; i < 16; i = i + 1) begin
            a = $urandom() % 16;
            b = $urandom() % 16;
            #(1);
            if (a > b) begin
                assert(greater == 1'b1);
                assert(less == 1'b0);
                assert(equal == 1'b0);
            end else if (a < b) begin
                assert(greater == 1'b0);
                assert(less == 1'b1);
                assert(equal == 1'b0);
            end else begin
                assert(greater == 1'b0);
                assert(less == 1'b0);
                assert(equal == 1'b1);
            end
        end

        $display("All tests passed!");

        `ifndef IVERILOG
            $vcdplusoff;
        `endif
        $finish();
    end
endmodule
