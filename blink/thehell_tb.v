
module thehell_tb;
    reg clk = 0;
    reg btn1 = 1;
    reg btn2 = 1;
    wire [5:0] led;

    // Instantiate the top-level module
    thehell uut (
        .clk(clk),
        .btn1(btn1),
        .btn2(btn2),
        .led(led)
    );

    // Generate a clock signal
    always #5 clk = ~clk; // 100 MHz clock (10 ns period)

    // Stimulate the inputs
    initial begin
        // Reset test
        #10 btn1 = 0; #10 btn1 = 1;

        // Simulate btn2 presses
        #50 btn2 = 0; #10 btn2 = 1;  // Simulate button press and release
        #50 btn2 = 0; #10 btn2 = 1;  // Another button press

        // End simulation
        #200 $finish;
    end
endmodule