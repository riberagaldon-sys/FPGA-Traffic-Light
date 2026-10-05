`timescale 1ns / 1ps

module top_traffic #(
    parameter integer TICK_1HZ_COUNT    = 100_000_000,
    parameter integer TICK_1KHZ_COUNT   = 100_000,
    parameter integer EW_GREEN_SECONDS  = 35,
    parameter integer EW_YELLOW_SECONDS = 5,
    parameter integer SN_GREEN_SECONDS  = 35,
    parameter integer SN_YELLOW_SECONDS = 5
)(
    input  wire       clk_100m,
    output wire [2:0] light_ew,
    output wire [2:0] light_sn,
    output wire [3:0] seg_sel,
    output wire [7:0] seg_data
);

    (* mark_debug = "true" *)
    wire tick_1hz;

    (* mark_debug = "true" *)
    wire tick_1khz;

    (* mark_debug = "true" *)
    wire [1:0] curr_state;

    (* mark_debug = "true" *)
    wire [5:0] seconds_left;

    (* mark_debug = "true" *)
    wire [5:0] ew_countdown;

    (* mark_debug = "true" *)
    wire [5:0] sn_countdown;

    clk_div #(
        .TICK_1HZ_COUNT  (TICK_1HZ_COUNT),
        .TICK_1KHZ_COUNT (TICK_1KHZ_COUNT)
    ) u_clk_div (
        .clk_100m  (clk_100m),
        .tick_1hz  (tick_1hz),
        .tick_1khz (tick_1khz)
    );

    traffic_fsm #(
        .EW_GREEN_SECONDS  (EW_GREEN_SECONDS),
        .EW_YELLOW_SECONDS (EW_YELLOW_SECONDS),
        .SN_GREEN_SECONDS  (SN_GREEN_SECONDS),
        .SN_YELLOW_SECONDS (SN_YELLOW_SECONDS)
    ) u_traffic_fsm (
        .clk_100m     (clk_100m),
        .tick_1hz     (tick_1hz),
        .light_ew     (light_ew),
        .light_sn     (light_sn),
        .curr_state   (curr_state),
        .seconds_left (seconds_left),
        .ew_countdown (ew_countdown),
        .sn_countdown (sn_countdown)
    );

    seg_scan u_seg_scan (
        .clk_100m     (clk_100m),
        .tick_1khz    (tick_1khz),
        .ew_countdown (ew_countdown),
        .sn_countdown (sn_countdown),
        .seg_sel      (seg_sel),
        .seg_data     (seg_data)
    );

endmodule