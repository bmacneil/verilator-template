// ***************************
// Date:
// Author:
// Module Name: MODULENAME
// Description:
// ***************************

module MODULENAME(
    input logic         i_clk,
    input logic         i_reset,
    output logic        o_out);

// INTERNAL VARIABLES ********


// MODULE START***************
always_ff @(posedge i_clk)
    if(i_reset) begin
        // Reset State
        o_out <= 1'b0;
    end
    else begin
        // Code
        o_out <= 1'b0;
    end
endmodule // MODULENAME