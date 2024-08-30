`timescale 1ns/1ns

`define SECOND 1000000000
`define MS 1000000

module simple_counter_tb();
    reg reset = 1'b1;
    reg clk = 1'b0;
    wire [1:0] counter;

    simple_counter DUT (
        .clk(clk),
        .reset(reset),
        .counter_out(counter)
    );

    always #(4) clk <= ~clk;

    initial begin
        `ifdef IVERILOG
            $dumpfile("simple_counter_tb.fst");
            $dumpvars(0, simple_counter_tb);
        `endif
        `ifndef IVERILOG
            $vcdpluson;
        `endif

        #(10)
        reset = 1'b0;

        assert(counter == 2'b00);
        #(4)
        assert(counter == 2'b01);
        #(8)
        assert(counter == 2'b10);
        #(8)
        assert(counter == 2'b11);
        #(8)
        assert(counter == 2'b00);
        #(8)
        assert(counter == 2'b01);

        #(1)
        reset = 1'b1;
        #(1)
        assert(counter == 2'b00);

        $display("All tests passed!");

        `ifndef IVERILOG
            $vcdplusoff;
        `endif
        $finish();
    end
endmodule
