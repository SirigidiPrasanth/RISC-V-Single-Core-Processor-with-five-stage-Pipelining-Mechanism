module tb_ALU;
  
    reg  [31:0] A, B;
    reg  [2:0]  ALUControl;
    wire [31:0] Result;
    wire Carry, OverFlow, Zero, Negative;

    // Instantiate the ALU DUT
    ALU uut(
        .A(A),
        .B(B),
        .Result(Result),
        .ALUControl(ALUControl),
        .OverFlow(OverFlow),
        .Carry(Carry),
        .Zero(Zero),
        .Negative(Negative)
    );

    initial 
      begin
      
        $display("Time\tA\t\tB\t\tALUControl\tResult\t\tCarry\tOverflow\tZero\tNegative");
        $monitor($time, "\t%h\t%h\t%b\t\t%h\t%b\t%b\t\t%b\t%b",
                 A, B, ALUControl, Result, Carry, OverFlow, Zero, Negative);

        // ADD (ALUControl = 000)
        A = 32'd10; B = 32'd5;   ALUControl = 3'b000; #10;

        // SUB (ALUControl = 001)
        A = 32'd15; B = 32'd10;  ALUControl = 3'b001; #10;
        A = 32'd0;  B = 32'd1;   ALUControl = 3'b001; #10;

        // AND (ALUControl = 010)
        A = 32'hFFFF0000; B = 32'h0F0F0F0F; ALUControl = 3'b010; #10;

        // OR (ALUControl = 011)
        A = 32'h0000FFFF; B = 32'h0F0F0F0F; ALUControl = 3'b011; #10;

        // SLT / Negative check (ALUControl = 101)
        A = 32'h80000000; B = 32'h00000001; ALUControl = 3'b101; #10;
        A = 32'h7FFFFFFF; B = 32'h00000001; ALUControl = 3'b101; #10;

        // Zero Output
        A = 32'd0; B = 32'd0; ALUControl = 3'b000; #10;

        // edge/additional cases
        A = 32'hFFFFFFFF; B = 32'd1; ALUControl = 3'b000; #10; // ADD: overflow/Carry
        A = 32'h7FFFFFFF; B = 32'd1; ALUControl = 3'b000; #10; // ADD: signed overflow

       
        $finish;
    end

endmodule
