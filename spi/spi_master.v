module spi_master #(
    parameter CLK_DIV = 4
)(
    input  wire       clk,
    input  wire       rst,
    input  wire       start,
    input  wire [7:0] data_in,

    output reg        sclk,
    output reg        mosi,
    output reg        cs,
    output reg [7:0]  data_out,
    output reg        busy,
    output reg        done
);

    reg [7:0] shift_reg;
    reg [3:0] bit_count;
    reg [15:0] clk_count;

    always @(posedge clk or posedge rst) begin
        if (rst) begin
            sclk      <= 1'b0;
            mosi      <= 1'b0;
            cs        <= 1'b1;
            data_out  <= 8'b0;
            busy      <= 1'b0;
            done      <= 1'b0;
            shift_reg <= 8'b0;
            bit_count <= 4'b0;
            clk_count <= 16'b0;
        end
        else begin
            done <= 1'b0;

            if (start && !busy) begin
                busy      <= 1'b1;
                cs        <= 1'b0;
                shift_reg <= data_in;
                bit_count <= 4'd0;
                clk_count <= 16'b0;
                mosi      <= data_in[7];
                sclk      <= 1'b0;
            end

            else if (busy) begin

                if (clk_count == CLK_DIV-1) begin
                    clk_count <= 16'b0;
                    sclk      <= ~sclk;

                    if (sclk == 1'b1) begin
                        if (bit_count == 4'd7) begin
                            data_out <= shift_reg;
                            busy     <= 1'b0;
                            done     <= 1'b1;
                            cs       <= 1'b1;
                            sclk     <= 1'b0;
                            mosi     <= 1'b0;
                        end
                        else begin
                            bit_count <= bit_count + 1'b1;
                            shift_reg <= {shift_reg[6:0], 1'b0};
                            mosi      <= shift_reg[6];
                        end
                    end
                end
                else begin
                    clk_count <= clk_count + 1'b1;
                end
            end
        end
    end

endmodule