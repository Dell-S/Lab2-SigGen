module rom2  #(
    parameter   ADDRESS_WIDTH = 8,
                DATA_WIDTH = 8
)(
    input logic                             clk,
    input logic     [ADDRESS_WIDTH-1:0]     addr1,
    input logic     [ADDRESS_WIDTH-1:0]     addr2,
    input logic     [ADDRESS_WIDTH-1:0]     offset,
    output logic    [DATA_WIDTH-1:0]        dout1,
    output logic    [DATA_WIDTH-1:0]        dout2
);

logic   [DATA_WIDTH-1:0] rom_array [2**ADDRESS_WIDTH-1:0];

initial begin
        $display("Loading rom.");
        $readmemh("sinerom.mem", rom_array);
end;

always_ff @(posedge clk) begin
    // output is synchronous
    dout1 <= rom_array [addr1];
    dout2 <= rom_array [addr2+offset];

    // [addr+128] creates an offset of (128/256)*2pi = pi out of phase plot
end

endmodule
