`timescale 1ns/1ps

module spi_master_tb;

    reg clk;
    reg rst;
    reg start;
    reg [7:0] data_in;

    wire sclk;
    wire mosi;
    wire cs;
    wire [7:0] data_out;
    wire busy;
    wire done;

    spi_master #(
        .CLK_DIV(2)
    ) uut (
        .clk(clk),
        .rst(rst),
        .start(start),
        .data_in(data_in),
        .sclk(sclk),
        .mosi(mosi),
        .cs(cs),
        .data_out(data_out),
        .busy(busy),
        .done(done)
    );

    always #5 clk = ~clk;

    initial begin
        clk = 0;
        rst = 1;
        start = 0;
        data_in = 8'b0;

        #20;
        rst = 0;

        // Send 10101010
        #10;
        data_in = 8'b10101010;
        start = 1;

        #10;
        start = 0;

        wait(done);

        #20;

        $display("--------------------------------");
        $display("SPI MASTER SIMULATION");
        $display("--------------------------------");
        $display("Data Sent    = %b", data_in);
        $display("Data Output  = %b", data_out);
        $display("CS           = %b", cs);
        $display("BUSY         = %b", busy);
        $display("DONE         = %b", done);
        $display("--------------------------------");

        #20;
        $finish;
    end

    initial begin
        $monitor("Time=%0t | CS=%b | SCLK=%b | MOSI=%b | BUSY=%b | DONE=%b | DATA_OUT=%b",
                 $time, cs, sclk, mosi, busy, done, data_out);
    end

endmodule