module tb();

    //Declare I/O
    reg clk=0, rst, PCSrcE;
    reg [31:0] PCTargetE;
    wire [31:0] InstrD, PCPlus4D, PCD;

    //Declare the design under test
    fetch_cycle dut (.clk(clk), 
                     .rst(rst), 
                     .PCSrcE(PCSrcE), 
                     .PCTargetE(PCTargetE), 
                     .InstrD(InstrD), 
                     .PCD(PCD), 
                     .PCPlus4D(PCPlus4D)
                     );
        
    
    //Generation of clk
    always 
    begin 
        clk = ~clk;
        #50;
    end

    //Provide the stimulus
    initial
    begin
        rst <= 1'b0;
        #200;
        rst <= 1'b1;
        PCSrcE <= 1'b0;
        PCTargetE <= 32'h00000000;
        #500;
        $finish;

    end

    //Generation of VCD file
    initial 
    begin 
        $dumpfile("sump.vcd");
        $dumpvars(0);
    end

endmodule 
