#include "Vsinegen.h"
#include "verilated.h"
#include "verilated_vcd_c.h"
#include "vbuddy.cpp"

#define MAX_CYCLE 1000000
#define ADDR_WIDTH 8
#define ROM_SIZE 256

int main(int argc, char **argv, char **env) {
    int i; // Clock cycle count
    int clk; // module clock signal

    Verilated::commandArgs(argc, argv);
    // init top verilog instance
    Vsinegen* top = new Vsinegen;
    // init trace dump
    Verilated::traceEverOn(true); // turn on signal tracing and tell Verilator to dump waveform data to counter.vcd
    VerilatedVcdC* tfp = new VerilatedVcdC;
    top->trace (tfp, 99);
    tfp->open ("sinegen.vcd");

    // init Vbuddy
    if (vbdOpen() != 1) return(-1);
    vbdHeader("Lab 2 Task 2");

    // init
    top->clk = 1;
    top->rst = 0;
    top->en = 1;
    top->incr = 1;
    top->offset = 0;

    for (i=0; i<MAX_CYCLE; i++){
        // dump variables into VCD file and toggle clock
        for (clk=0; clk<2; clk++){
            tfp->dump (2*i+clk); 
            top->clk = !top->clk;
            top->eval ();
        }

        // top->incr = vbdValue();
        top->offset = vbdValue();
        vbdPlot(int (top->dout1), 0, 255);
        vbdPlot(int (top->dout2), 0, 255);
        vbdCycle(i);

        // either simulation finished, or 'q' is pressed
        if ((Verilated::gotFinish()) || (vbdGetkey()=='q')) 
            exit(0);
            
    }

    vbdClose();     // ++++
    tfp->close();
    exit(0);
}