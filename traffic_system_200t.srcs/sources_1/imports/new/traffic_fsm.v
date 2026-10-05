`timescale 1ns / 1ps

module traffic_fsm #(
    parameter integer EW_GREEN_SECONDS  = 35,
    parameter integer EW_YELLOW_SECONDS = 5,
    parameter integer SN_GREEN_SECONDS  = 35,
    parameter integer SN_YELLOW_SECONDS = 5
)(
    input  wire       clk_100m,
    input  wire       tick_1hz,

    /*
     * 实际交通灯扩展板位序：
     * [2] = 绿灯
     * [1] = 红灯
     * [0] = 黄灯
     */
    output reg  [2:0] light_ew,
    output reg  [2:0] light_sn,

    output reg  [1:0] curr_state,
    output reg  [5:0] seconds_left,
    output reg  [5:0] ew_countdown,
    output reg  [5:0] sn_countdown
);

    localparam [1:0] STATE_EW_GREEN  = 2'd0;
    localparam [1:0] STATE_EW_YELLOW = 2'd1;
    localparam [1:0] STATE_SN_GREEN  = 2'd2;
    localparam [1:0] STATE_SN_YELLOW = 2'd3;

    // 实际硬件灯光编码
    localparam [2:0] LIGHT_GREEN  = 3'b100;
    localparam [2:0] LIGHT_RED    = 3'b010;
    localparam [2:0] LIGHT_YELLOW = 3'b001;

    initial begin
        curr_state   = STATE_EW_GREEN;
        seconds_left = EW_GREEN_SECONDS;
    end

    // 1Hz状态计时
    always @(posedge clk_100m) begin
        if (tick_1hz) begin
            if (seconds_left > 6'd1) begin
                seconds_left <= seconds_left - 6'd1;
            end
            else begin
                case (curr_state)
                    STATE_EW_GREEN: begin
                        curr_state   <= STATE_EW_YELLOW;
                        seconds_left <= EW_YELLOW_SECONDS;
                    end

                    STATE_EW_YELLOW: begin
                        curr_state   <= STATE_SN_GREEN;
                        seconds_left <= SN_GREEN_SECONDS;
                    end

                    STATE_SN_GREEN: begin
                        curr_state   <= STATE_SN_YELLOW;
                        seconds_left <= SN_YELLOW_SECONDS;
                    end

                    STATE_SN_YELLOW: begin
                        curr_state   <= STATE_EW_GREEN;
                        seconds_left <= EW_GREEN_SECONDS;
                    end

                    default: begin
                        curr_state   <= STATE_EW_GREEN;
                        seconds_left <= EW_GREEN_SECONDS;
                    end
                endcase
            end
        end
    end

    // 灯光输出和倒计时显示
    always @(*) begin
        // 默认安全状态：两个方向红灯
        light_ew     = LIGHT_RED;
        light_sn     = LIGHT_RED;
        ew_countdown = 6'd40;
        sn_countdown = 6'd40;

        case (curr_state)

            // EW绿灯35秒，SN红灯40秒
            STATE_EW_GREEN: begin
                light_ew = LIGHT_GREEN;
                light_sn = LIGHT_RED;

                ew_countdown = seconds_left;
                sn_countdown = seconds_left + EW_YELLOW_SECONDS;
            end

            // EW黄灯5秒，SN红灯继续最后5秒
            STATE_EW_YELLOW: begin
                light_ew = LIGHT_YELLOW;
                light_sn = LIGHT_RED;

                ew_countdown = seconds_left;
                sn_countdown = seconds_left;
            end

            // EW红灯40秒，SN绿灯35秒
            STATE_SN_GREEN: begin
                light_ew = LIGHT_RED;
                light_sn = LIGHT_GREEN;

                ew_countdown = seconds_left + SN_YELLOW_SECONDS;
                sn_countdown = seconds_left;
            end

            // EW红灯继续最后5秒，SN黄灯5秒
            STATE_SN_YELLOW: begin
                light_ew = LIGHT_RED;
                light_sn = LIGHT_YELLOW;

                ew_countdown = seconds_left;
                sn_countdown = seconds_left;
            end

            default: begin
                light_ew     = LIGHT_GREEN;
                light_sn     = LIGHT_RED;
                ew_countdown = 6'd35;
                sn_countdown = 6'd40;
            end
        endcase
    end

endmodule