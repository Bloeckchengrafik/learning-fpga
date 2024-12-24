module counter
(
    input clk,
    input btn1,
    input btn2,
    output [5:0] led
);

localparam WAIT_TIME = 13500000;
reg [5:0] ledCounter = 0;
reg [23:0] clockCounter = 0;
reg paused = 0;
reg btn2State = 0;
reg btn2StatePrev = 0;
debounce_worse_version debouncer(!btn2, clk, btn2State);

wire btn2rising;
assign btn2rising = btn2State && ~btn2StatePrev;

always @(posedge clk) begin
    if (paused) begin
        clockCounter <= 0;
    end

    clockCounter <= clockCounter + 1;
    if (clockCounter == WAIT_TIME) begin
        clockCounter <= 0;
        ledCounter <= ledCounter + 1;
    end

    if (!btn1) begin
        ledCounter <= 0;
        paused <= 0;
    end

    if (btn2rising) begin
        paused <= 1;
    end

    btn2StatePrev <= btn2State;
end

assign led = ~ledCounter;
endmodule
