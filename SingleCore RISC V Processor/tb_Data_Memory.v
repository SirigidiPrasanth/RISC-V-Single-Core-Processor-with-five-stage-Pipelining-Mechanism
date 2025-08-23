
module tb_Data_Memory;

    reg clk, rst, WE;
    reg [31:0] A, WD;
    wire [31:0] RD;

    // Instantiate the Data_Memory module
    Data_Memory uut (
        .clk(clk),
        .rst(rst),
        .WE(WE),
        .WD(WD),
        .A(A),
        .RD(RD)
    );

    
    initial clk = 0;
    always #5 clk = ~clk; 

    initial 
    begin
        
        $display("Time\tRST\tWE\tA\t\tWD\t\t\tRD");
        $monitor("%0t\t%b\t%b\t%h\t%h\t%h", $time, rst, WE, A, WD, RD);

        rst = 1; WE = 0; A = 0; WD = 0;

        // 1. Write 0xAAAA5555 to address 4
        #7  WE = 1; A = 32'd4; WD = 32'hAAAA5555;
        #10 WE = 0;

        // 2. Write 0xDEADBEEF to address 8
        #7  WE = 1; A = 32'd8; WD = 32'hDEADBEEF;
        #10 WE = 0;

        // 3. Read from address 4
        #10 A = 32'd4;

        // 4. Read from address 8
        #10 A = 32'd8;

        // 5. Read from address 0 
        #10 A = 32'd0;

        // 6. Reset memory (should force RD to zero)
        #10 rst = 0; // Assert reset
        #10 A = 32'd4;

        // 7. De-assert reset and check memory contents again
        #10 rst = 1; A = 32'd4;

        #20 $finish;
    end

endmodule
