module ramcu(
              
              input clk,
              
              //write port decleration

              input wr_en,
              input [4:0]wr_addr,
              input [31:0]wr_data,
             // output reg [15:0]d_out,
              
              
              //read port decleration

              input rd_en,
              input [4:0]rd_addr1,
              output reg[31:0]rd_data1,
              input [4:0]rd_addr2,
              output reg[31:0]rd_data2
           ); 
  
 
  reg [0:31]mem[31:0]; 
  
initial 
begin
$readmemh("memory_write.hex",mem);
end 
 
  
  // Write to memory 
  
  always@(posedge clk)
   begin
     
     if (wr_en) 
       begin
         
       mem[wr_addr] <= wr_data;
       //d_out <= mem[wr_addr]; 
         
       end
     
   end
  
  //read from memory
  
  always@(posedge clk)
    begin
      
      if(rd_en)
       begin
        rd_data1 <= mem[rd_addr1];
      
        rd_data2 <= mem[rd_addr2];
       end
      
    end
    

endmodule 








