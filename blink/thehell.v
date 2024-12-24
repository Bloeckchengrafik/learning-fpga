module debounced_signal(
    input pb_1,       // Noisy button input
    input clk,        // Clock signal
    output reg pb_out // Clean, debounced output
);
    reg [2:0] shift_reg;

    always @(posedge clk) begin
        // Shift register for debouncing
        shift_reg <= {shift_reg[1:0], pb_1};
        // Debounced output: Set high only if all three samples are high
        pb_out <= (shift_reg == 3'b111);
    end
endmodule

module thehell(
    input clk,
    input btn1,
    input btn2,
    output [5:0] led
);
    reg [5:0] leds = 0;

    wire btn2reg = 0;
    debounced_signal debouncer(btn2, clk, btn2reg);

    always @(posedge clk) begin
        if (!btn1) begin
            leds <= 0;
        end else if (btn2reg) begin
            leds <= leds + 1;
        end
    end

    assign led = ~leds;
endmodule

