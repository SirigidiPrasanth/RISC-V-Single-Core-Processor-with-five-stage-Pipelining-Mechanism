module tb_Register_File;

  reg clk;
  reg rst;
  reg WE3;
  reg [4:0] A1, A2, A3;
  reg [31:0] WD3;
  wire [31:0] RD1, RD2;

  Register_File uut (
    .clk(clk),
    .rst(rst),
    .WE3(WE3),
    .WD3(WD3),
    .A1(A1),
    .A2(A2),
    .A3(A3),
    .RD1(RD1),
    .RD2(RD2)
  );
  
  always #5 clk = ~clk;

  initial 
  begin
  
    clk = 0;
    rst = 0;
    WE3 = 0;
    WD3 = 0;
    A1 = 0;
    A2 = 0;
    A3 = 0;
    
    #5; rst = 1;
    #10;
  
    WE3 = 1; A3 = 5'd1; WD3 = 32'hA5A5A5A5;
    #10;  
    WE3 = 0;

    A1 = 5'd1;
    #10;
    
    WE3 = 1; A3 = 5'd0; WD3 = 32'hFFFFFFFF;
    #10;
    WE3 = 0;

    A1 = 5'd0;
    #10;
    
    WE3 = 1; A3 = 5'd2; WD3 = 32'h12345678;
    #10;
    WE3 = 0;

    A1 = 5'd2;
    A2 = 5'd1;
    #10;
    $finish;
  end

endmodule
