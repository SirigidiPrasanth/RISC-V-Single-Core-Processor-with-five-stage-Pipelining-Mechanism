module tb_PC_Module;

    reg clk, rst;
    reg [31:0] PC_Next;
    wire [31:0] PC;

    PC_Module uut (
        .clk(clk),
        .rst(rst),
        .PC(PC),
        .PC_Next(PC_Next)
    );

    initial clk = 0;
    always #5 clk = ~clk; 

    initial 
    begin
        $display("Time\tclk\trst\tPC_Next\t\tPC");
        $monitor("%0t\t%b\t%b\t%h\t%h", $time, clk, rst, PC_Next, PC);

        rst = 0;
        PC_Next = 32'h00000000;
        
        #8  rst = 0; PC_Next = 32'h12345678;
        #12 rst = 1; PC_Next = 32'h00000004;
        #10 PC_Next = 32'h00000008;
        #10 PC_Next = 32'hABCDEF01;
        #10 rst = 0; // Assert reset again, PC should return to 0
        #10 rst = 1; PC_Next = 32'h00000020;
        #10 PC_Next = 32'h00000024;
        #10;
        
        $finish;
    end
endmodule
