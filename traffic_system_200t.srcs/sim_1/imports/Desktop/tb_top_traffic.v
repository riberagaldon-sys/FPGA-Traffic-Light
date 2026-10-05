`timescale 1ns / 1ps

// Chapter 2: traffic lights and four-digit countdown scan.
// Add to Simulation Sources; simulation top is tb_top_traffic.
// DUT synthesis top remains top_traffic, with its original hardware defaults.
module tb_top_traffic;

    reg        clk_100m = 1'b0;
    wire [2:0] light_ew;
    wire [2:0] light_sn;
    wire [3:0] seg_sel;
    wire [7:0] seg_data;

    wire       tick_1hz;
    wire       tick_1khz;
    wire [1:0] curr_state;
    wire [5:0] seconds_left;
    wire [5:0] ew_countdown;
    wire [5:0] sn_countdown;
    wire [1:0] scan_cnt;
    wire [3:0] digit_value;

    top_traffic #(
        .TICK_1HZ_COUNT(10),
        .TICK_1KHZ_COUNT(2),
        .EW_GREEN_SECONDS(4),
        .EW_YELLOW_SECONDS(2),
        .SN_GREEN_SECONDS(4),
        .SN_YELLOW_SECONDS(2)
    ) dut (
        .clk_100m(clk_100m),
        .light_ew(light_ew),
        .light_sn(light_sn),
        .seg_sel(seg_sel),
        .seg_data(seg_data)
    );

    // Read-only aliases for the waveform viewer.
    assign tick_1hz     = dut.tick_1hz;
    assign tick_1khz    = dut.tick_1khz;
    assign curr_state  = dut.curr_state;
    assign seconds_left = dut.seconds_left;
    assign ew_countdown = dut.ew_countdown;
    assign sn_countdown = dut.sn_countdown;
    assign scan_cnt     = dut.u_seg_scan.scan_cnt;
    assign digit_value  = dut.u_seg_scan.digit_value;

    // 10 ns period, first rising edge at 5 ns.
    always #5 clk_100m = ~clk_100m;

    initial begin
        #1300;
        $display("Chapter 2 simulation complete at 1300 ns. Inspect the waveforms.");
        $finish;
    end

endmodule
