module ram2  #(
    parameter   ADDRESS_WIDTH = 8,
                DATA_WIDTH = 8
)(
    input logic                             clk,
    input logic                             writeEn,
    input logic                             readEn,
    input logic     [ADDRESS_WIDTH-1:0]     writeAddr,
    input logic     [ADDRESS_WIDTH-1:0]     readAddr,
    input logic     [DATA_WIDTH-1:0]        mic_signal,
    output logic    [DATA_WIDTH-1:0]        delayed_signal
);

logic   [DATA_WIDTH-1:0] ram_array [2**ADDRESS_WIDTH-1:0];

always_ff @(posedge clk) begin
    if (writeEn == 1'b1)
        ram_array[writeAddr] <= mic_signal;
    if (readEn == 1'b1)
        // output is synchronous
        delayed_signal <= ram_array [readAddr];
end

endmodule
