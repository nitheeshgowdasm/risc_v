module tb();

reg [31:0]instruction ;
reg       clk         ;

riscv_processor riscv_processor_uut(
.instruction(instruction) ,
.clk(clk)
);

initial 
begin
    instruction = 32'd0       ;
    clk = 1'b0                ;
end
    always #5 clk = ~clk      ;

initial
begin
#10
    instruction = 32'h001080B3;
    #10
    instruction = 32'h40210133;
    #10
    instruction = 32'h003191B3;
    #10
    instruction = 32'h00422233;
    #10
    instruction = 32'h0052B2B3;
    #10
    instruction = 32'h00634333;
    #10
    instruction = 32'h0073D3B3;
    #10
    instruction = 32'h40845433;
    #10
    instruction = 32'h0094E4B3;
    #10
    instruction = 32'h00A57533;
    
    #10
    instruction = 32'h00108093;
    #10
    instruction = 32'h00212113;
    #10
    instruction = 32'h0031B193;
    #10
    instruction = 32'h00424213;
    #10
    instruction = 32'h0052E293;
    #10
    instruction = 32'h00637313;
    #10
    instruction = 32'h00739393;
    #10
    instruction = 32'h00845413;
    #10
    instruction = 32'h4094D493;
    #10
    instruction = 32'h11223344;
    
    
    #10 $finish;
    
    $finish;
  end
  initial 
    begin 
     $shm_open("wave.shm");
     $shm_probe("ACTMF");
    
     
    end
endmodule

