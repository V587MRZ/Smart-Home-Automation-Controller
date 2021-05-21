module spot (
input wire clk,
input wire spot_in,
output wire spot_out);

// you write the module code!
reg ff;

always@(posedge clk) begin
    ff<=spot_in;
end

assign spot_out = spot_in & (~ff);

endmodule