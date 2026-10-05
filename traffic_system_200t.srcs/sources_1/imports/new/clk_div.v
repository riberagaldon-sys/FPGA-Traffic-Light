`timescale 1ns / 1ps

module clk_div #(
    parameter integer TICK_1HZ_COUNT  = 100_000_000,
    parameter integer TICK_1KHZ_COUNT = 100_000
)(
    input  wire clk_100m,
    output reg  tick_1hz  = 1'b0,
    output reg  tick_1khz = 1'b0
);

    reg [26:0] cnt_1hz  = 27'd0;
    reg [16:0] cnt_1khz = 17'd0;

    always @(posedge clk_100m) begin
        tick_1hz <= 1'b0;

        if (cnt_1hz == TICK_1HZ_COUNT - 1) begin
            cnt_1hz  <= 27'd0;
            tick_1hz <= 1'b1;
        end
        else begin
            cnt_1hz <= cnt_1hz + 1'b1;
        end
    end

    always @(posedge clk_100m) begin
        tick_1khz <= 1'b0;

        if (cnt_1khz == TICK_1KHZ_COUNT - 1) begin
            cnt_1khz  <= 17'd0;
            tick_1khz <= 1'b1;
        end
        else begin
            cnt_1khz <= cnt_1khz + 1'b1;
        end
    end

endmodule