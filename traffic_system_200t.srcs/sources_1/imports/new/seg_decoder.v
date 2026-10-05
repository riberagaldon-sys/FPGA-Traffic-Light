`timescale 1ns / 1ps

module seg_decoder(
    input  wire [3:0] digit,
    output reg  [7:0] seg_data
);

    // seg_data={DP,G,F,E,D,C,B,A}，低电平点亮
    always @(*) begin
        case (digit)
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