`timescale 1ns/1ns

`define SECOND 1000000000
`define MS 1000000

module one_bit_comparator_always_tb();
    reg a, b;
    wire greater, less, equal;

    one_bit_comparator_always DUT (
        .a(a),
        .b(b),
        .greater(greater),
        .less(less),
        .equal(equal)
    );

    initial begin
        `ifdef IVERILOG
            $dumpfile("one_bit_comparator_always_tb.fst");
            $dumpvars(0, one_bit_comparator_always_tb);
        `endif
        `ifndef IVERILOG
            $vcdpluson;
        `endif

        a = 1'b0;
        b = 1'b0;
        #(1);
        assert(greater == 1'b0);
        assert(less == 1'b0);
        assert(equal == 1'b1);        

        a = 1'b0;
        b = 1'b1;
        #(1);
        assert(greater == 1'b0);
        assert(less == 1'b1);
        assert(equal == 1'b0);

        a = 1'b1;
        b = 1'b0;
        #(1);
        assert(greater == 1'b1);
        assert(less == 1'b0);
        assert(equal == 1'b0);

        a = 1'b1;
        b = 1'b1;
        #(1);
        assert(greater == 1'b0);
        assert(less == 1'b0);
        assert(equal == 1'b1);

        $display("All tests passed!");

        `ifndef IVERILOG
            $vcdplusoff;
        `endif
        $finish();
    end
endmodule
