`timescale 1ns / 1ps

module seg_scan (
    input  wire       clk_100m,
    input  wire       tick_1khz,

    // 东西方向倒计时
    input  wire [5:0] ew_countdown,

    // 南北方向倒计时
    input  wire [5:0] sn_countdown,

    // 4位数码管位选，低电平有效
    output reg  [3:0] seg_sel,

    // {DP,G,F,E,D,C,B,A}，低电平点亮
    output reg  [7:0] seg_data
);

    // 4个位的扫描计数器
    reg [1:0] scan_cnt = 2'd0;

    // 当前被扫描位需要显示的数字
    reg [3:0] digit_value;

    // 1kHz扫描脉冲到来时切换到下一位
    always @(posedge clk_100m) begin
        if (tick_1khz) begin
            scan_cnt <= scan_cnt + 2'd1;
        end
    end

    /*
     * 数码管物理顺序：
     *
     * 左边两位：东西方向 EW
     * 右边两位：南北方向 SN
     *
     * 修正后的十位/个位对应关系：
     * 1011 -> EW十位
     * 0111 -> EW个位
     * 1110 -> SN十位
     * 1101 -> SN个位
     */
    always @(*) begin
        // 默认关闭全部数码管
        seg_sel     = 4'b1111;
        digit_value = 4'd0;

        case (scan_cnt)
            2'd0: begin
                // 南北方向十位
                seg_sel     = 4'b1110;
                digit_value = sn_countdown / 10;
            end

            2'd1: begin
                // 南北方向个位
                seg_sel     = 4'b1101;
                digit_value = sn_countdown % 10;
            end

            2'd2: begin
                // 东西方向十位
                seg_sel     = 4'b1011;
                digit_value = ew_countdown / 10;
            end

            2'd3: begin
                // 东西方向个位
                seg_sel     = 4'b0111;
                digit_value = ew_countdown % 10;
            end

            default: begin
                seg_sel     = 4'b1111;
                digit_value = 4'd0;
            end
        endcase
    end

    /*
     * 共阳数码管段码
     * seg_data = {DP,G,F,E,D,C,B,A}
     * 低电平点亮
     */
    always @(*) begin
        case (digit_value)
            4'd0: seg_data = 8'hC0;
            4'd1: seg_data = 8'hF9;
            4'd2: seg_data = 8'hA4;
            4'd3: seg_data = 8'hB0;
            4'd4: seg_data = 8'h99;
            4'd5: seg_data = 8'h92;
            4'd6: seg_data = 8'h82;
            4'd7: seg_data = 8'hF8;
            4'd8: seg_data = 8'h80;
            4'd9: seg_data = 8'h90;
            default: seg_data = 8'hFF;
        endcase
    end

endmodule