module sinegen (
    input logic clk,
    input logic rst,
    input logic en,
    input logic [7:0] incr,
    output logic [7:0] dout
);

    logic [7:0] count;
    logic [7:0] addr;

    // Instantiate counter
    counter my_counter (
        .clk(clk),
        .rst(rst),
        .en(en),
        .incr(incr),
        .count(count)
    );

    // Connect counter output to ROM address input
    assign addr = count;

    // Instantiate rom
    rom my_rom (
        .clk(clk),
        .addr(addr),
        .dout(dout)
    );

endmodule
