module debounce_worse_version(input pb_1, input clk, output pb_out);
    assign pb_out = pb_1 & clk;
endmodule
