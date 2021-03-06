`timescale 1ns / 1ps

(* use_dsp48 = "no" *)
module clock_divider(
    input Clk5MHz,
    output reg Clk1Hz
    );
    integer cnt;
    parameter C5MHz = 5000000 / 2;
    initial
    begin
        cnt = 0;
        Clk1Hz = 0;
    end

    always @(posedge Clk5MHz)
    begin
        if (cnt < C5MHz)
            cnt <= cnt + 1;
        else
        begin
            Clk1Hz <= ~Clk1Hz;
            cnt <= 0;
        end
    end
endmodule
