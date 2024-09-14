`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////
//                                                          //
// Author : @thetrung                                       // 
// Date : 14th, September 2024                              //
// Quick Test LED chases, similar to one I tested on ESP32. //
//                                                          //
//////////////////////////////////////////////////////////////
module led_chase(
    input clk,           // E3 clock
    input rst,           // C12 Reset button
    output reg[15:0] led // [H17-V11] 16-LEDs
);
// 24-bit counter :
reg [23:0] counter;

// Main Loop w/ 100Mhz clock :
always @(posedge clk or posedge rst) begin
    if(rst) begin
        // On Reset :
        led <= 16'b0000000000000001;
        counter <= 0;
    end 
    else begin
        // Count for 50ms 
        counter <= counter + 1;
        if(counter == 24'd5000000) begin 
            // Shift LED Register per 50ms :
            counter <= 0;
            led <= {led[14:0], led[15]};
        end
    end
end    
endmodule
