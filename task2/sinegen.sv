module sinegen #(
  parameter     A_WIDTH = 8,
                D_WIDTH = 8
)(
  // interface signals
  input  logic                  clk,      // clock 
  input  logic                  rst,      // reset 
  input  logic                  en,       // enable
  input  logic [A_WIDTH-1:0]    incr,     // increment
  input  logic [D_WIDTH-1:0]    offset,   // offset
  output logic [D_WIDTH-1:0]    dout1,    // count output
  output logic [D_WIDTH-1:0]    dout2
);

  logic  [A_WIDTH-1:0]       address;    // interconnect wire

counter addrCounter ( // instantiate counter module
  .clk (clk),
  .rst (rst),
  .en (en),
  .incr (incr),
  .count (address) // count - internal signal name; address - external signal name
);

rom2 sineRom (
    .clk (clk),
    .addr1 (address), 
    .addr2 (address), 
    .dout1 (dout1),
    .dout2 (dout2),
    .offset (offset)
);

endmodule
