module r_type(
       input            [31:0]inst,
  
       output reg       add_en,
       output reg       sub_en,
       output reg       sll_en,
       output reg       slt_en,
       output reg       xor_en,
       output reg       sra_en,
       output reg       srl_en,
       output reg       or_en,
       output reg       and_en,
  
       output reg       sign_valid,
       output reg       imm_valid,  
     
       output reg       [4:0]rd,
       output reg       [4:0]rs1,
       output reg       [4:0]rs2,
       output reg       [31:0]imm,

       output reg        rd_en_o
       output reg        wr_en_o
       
             );
  
  wire         [6:0]opcode;
  wire         [2:0]func3;
  wire         [6:0]func7;
  
  assign   opcode = inst[6:0];
  assign   func3 = inst[14:12];
  assign   func7 = inst[31:25];
    
  
  always@(opcode,func3,func7)
    begin
    
      case(opcode)
      
      7'b0110011: case(func3)
        
          3'b000: 
            if(func7 == 7'b0000000)
            begin
              add_en = 1'b1;
              rd = inst[11:7];
              rs1 = inst[19:15];
              rs2 = inst[24:20];
              imm_valid = 1'b0;
              
              sub_en = 1'b0;
              sll_en = 1'b0;
              slt_en = 1'b0;
              xor_en = 1'b0;
              sra_en = 1'b0;
              srl_en = 1'b0;
              or_en = 1'b0;
              and_en = 1'b0;

              rd_en_o = 1'b1;
              wr_en_o = 1'b1;
            end
        
            else if(func7 == 7'b0100000)
            begin
              sub_en = 1'b1;
              rd = inst[11:7];
              rs1 = inst[19:15];
              rs2 = inst[24:20];
              imm_valid = 1'b0;
                 
              add_en = 1'b0;
              sll_en = 1'b0;
              slt_en = 1'b0;
              xor_en = 1'b0;
              sra_en = 1'b0;
              srl_en = 1'b0;
              or_en = 1'b0;
              and_en = 1'b0;

              rd_en_o = 1'b1;
              wr_en_o = 1'b1;
            end
            
            else
            begin 
              add_en = 1'b0; 
              sub_en = 1'b0;
              sll_en = 1'b0;
              slt_en = 1'b0;
              xor_en = 1'b0;
              sra_en = 1'b0;
              srl_en = 1'b0;
              or_en = 1'b0;
              and_en = 1'b0;

              rd_en_o = 1'b0;
              wr_en_o = 1'b0;
            end
        
                    
        3'b001: 
          if(func7 == 7'b0000000)
            begin 
              sll_en = 1'b1;
              rd = inst[11:7];
              rs1 = inst[19:15];
              rs2 = inst[24:20];
              imm_valid = 1'b0;
              
              sub_en = 1'b0;
              add_en = 1'b0;
              slt_en = 1'b0;
              xor_en = 1'b0;
              sra_en = 1'b0;
              srl_en = 1'b0;
              or_en = 1'b0;
              and_en = 1'b0;

              rd_en_o = 1'b1;
              wr_en_o = 1'b1;
            end
        
         else
          begin 
              add_en = 1'b0; 
              sub_en = 1'b0;
              sll_en = 1'b0;
              slt_en = 1'b0;
              xor_en = 1'b0;
              sra_en = 1'b0;
              srl_en = 1'b0;
              or_en = 1'b0;
              and_en = 1'b0;

              rd_en_o = 1'b0;
              wr_en_o = 1'b0;
          end
              
        
           3'b010:
             if(func7 == 7'b0000000) 
             begin
               
                
              slt_en = 1'b1;
              sign_valid = 1'b1; 
              rd = inst[11:7];
              rs1 = inst[19:15];
              rs2 = inst[24:20];
              imm_valid = 1'b0;
             
              add_en = 1'b0;
              sub_en = 1'b0;
              sll_en = 1'b0;
              xor_en = 1'b0;
              sra_en = 1'b0;
              srl_en = 1'b0;
              or_en = 1'b0;
              and_en = 1'b0;

              rd_en_o = 1'b1;
              wr_en_o = 1'b1;
                 end
            
        
        else
          begin 
              add_en = 1'b0; 
              sub_en = 1'b0;
              sll_en = 1'b0;
              slt_en = 1'b0;
              xor_en = 1'b0;
              sra_en = 1'b0;
              srl_en = 1'b0;
              or_en = 1'b0;
              and_en = 1'b0;

              rd_en_o = 1'b0;
              wr_en_o = 1'b0;
          end
             
        
          3'b011:                             /////sltu operation
            if(func7 == 7'b0000000)
            begin
              slt_en = 1'b1;
              sign_valid = 1'b0;
              rd = inst[11:7];
              rs1 = inst[19:15];
              rs2 = inst[24:20];
              imm_valid = 1'b0;

              add_en = 1'b0;
              sub_en = 1'b0;
              sll_en = 1'b0;
              slt_en = 1'b0;
              xor_en = 1'b0;
              sra_en = 1'b0;
              srl_en = 1'b0;
              or_en = 1'b0;
              and_en = 1'b0;

              rd_en_o = 1'b1;
              wr_en_o = 1'b1;
            end
        
           else
          begin 
              add_en = 1'b0; 
              sub_en = 1'b0;
              sll_en = 1'b0;
              slt_en = 1'b0;
              xor_en = 1'b0;
              sra_en = 1'b0;
              srl_en = 1'b0;
              or_en = 1'b0;
              and_en = 1'b0;

              rd_en_o = 1'b0;
              wr_en_o = 1'b0;
          end
        
           3'b100:
             if(func7 == 7'b0000000)
            begin
              xor_en = 1'b1;
              rd = inst[11:7];
              rs1 = inst[19:15];
              rs2 = inst[24:20];
              imm_valid = 1'b0;
 
              add_en = 1'b0;
              sub_en = 1'b0;
              sll_en = 1'b0;
              slt_en = 1'b0;
              sra_en = 1'b0;
              srl_en = 1'b0;
              or_en = 1'b0;
              and_en = 1'b0;

              rd_en_o = 1'b1;
              wr_en_o = 1'b1;
            end
        
          else
          begin 
              add_en = 1'b0; 
              sub_en = 1'b0;
              sll_en = 1'b0;
              slt_en = 1'b0;
              xor_en = 1'b0;
              sra_en = 1'b0;
              srl_en = 1'b0;
              or_en = 1'b0;
              and_en = 1'b0;

              rd_en_o = 1'b0;
              wr_en_o = 1'b0;
          end
        
           3'b101: 
             if(func7 == 7'b0000000)
            begin
              srl_en = 1'b1;
              rd = inst[11:7];
              rs1 = inst[19:15];
              rs2 = inst[24:20];
              imm_valid = 1'b0;
 
              add_en = 1'b0;
              sub_en = 1'b0;
              sll_en = 1'b0;
              slt_en = 1'b0;
              xor_en = 1'b0;
              sra_en = 1'b0;
              or_en = 1'b0;
              and_en = 1'b0;

              rd_en_o = 1'b1;
              wr_en_o = 1'b1;
            end
        
               else if(func7 == 7'b0100000)
              begin
              sra_en = 1'b1;
              rd = inst[11:7];
              rs1 = inst[19:15];
              rs2 = inst[24:20];
              imm_valid = 1'b0;
  
              add_en = 1'b0;
              sub_en = 1'b0;
              sll_en = 1'b0;
              slt_en = 1'b0;
              xor_en = 1'b0;
              srl_en = 1'b0;
              or_en = 1'b0;
              and_en = 1'b0;

              rd_en_o = 1'b1;
              wr_en_o = 1'b1;
              end
        
        else
          begin 
              add_en = 1'b0; 
              sub_en = 1'b0;
              sll_en = 1'b0;
              slt_en = 1'b0;
              xor_en = 1'b0;
              sra_en = 1'b0;
              srl_en = 1'b0;
              or_en = 1'b0;
              and_en = 1'b0;

              rd_en_o = 1'b0;
              wr_en_o = 1'b1;
          end
        
           3'b110: 
             if(func7 == 7'b0000000)
            begin
              or_en = 1'b1;
              rd = inst[11:7];
              rs1 = inst[19:15];
              rs2 = inst[24:20];
              imm_valid = 1'b0;

              add_en = 1'b0;
              sub_en = 1'b0;
              sll_en = 1'b0;
              slt_en = 1'b0;
              xor_en = 1'b0;
              sra_en = 1'b0;
              srl_en = 1'b0;
              and_en = 1'b0;

              rd_en_o = 1'b1;
              wr_en_o = 1'b1;
            end
        
        else
          begin 
              add_en = 1'b0; 
              sub_en = 1'b0;
              sll_en = 1'b0;
              slt_en = 1'b0;
              xor_en = 1'b0;
              sra_en = 1'b0;
              srl_en = 1'b0;
              or_en = 1'b0;
              and_en = 1'b0;

              rd_en_o = 1'b0;
              wr_en_o = 1'b0;
          end
        
       
           3'b111:
             if(func7 == 7'b0000000)
            begin
              and_en = 1'b1;
              rd = inst[11:7];
              rs1 = inst[19:15];
              rs2 = inst[24:20];
              imm_valid = 1'b0;
 
              add_en = 1'b0;
              sub_en = 1'b0;
              sll_en = 1'b0;
              slt_en = 1'b0;
              xor_en = 1'b0;
              sra_en = 1'b0;
              srl_en = 1'b0;
              or_en = 1'b0;

              rd_en_o = 1'b1;
              wr_en_o = 1'b1;
            end
        
        else
        begin 
              add_en = 1'b0; 
              sub_en = 1'b0;
              sll_en = 1'b0;
              slt_en = 1'b0;
              xor_en = 1'b0;
              sra_en = 1'b0;
              srl_en = 1'b0;
              or_en = 1'b0;
              and_en = 1'b0;

              rd_en_o = 1'b0;
              wr_en_o = 1'b0;
        end
            
        default:
          begin 
              add_en = 1'b0; 
              sub_en = 1'b0;
              sll_en = 1'b0;
              slt_en = 1'b0;
              xor_en = 1'b0;
              sra_en = 1'b0;
              srl_en = 1'b0;
              or_en = 1'b0;
              and_en = 1'b0;

              rd_en_o = 1'b0;
              wr_en_o = 1'b0;
          end
        
        endcase
        
        7'b0010011 :
          
          case(func3)
            
            3'b000:
              begin
              add_en = 1'b1;
              rd = inst[11:7];
              rs1 = inst[19:15];
              imm = {{20{inst[31]}},{inst[31:20]}};
              imm_valid = 1'b1;
  
              sub_en = 1'b0;
              sll_en = 1'b0;
              slt_en = 1'b0;
              xor_en = 1'b0;
              sra_en = 1'b0;
              srl_en = 1'b0;
              or_en = 1'b0;
              and_en = 1'b0;

              rd_en_o = 1'b1;
              wr_en_o = 1'b1;
              end
            
            3'b010:
               begin
              slt_en = 1'b1;
              sign_valid = 1'b1;   
              rd = inst[11:7];
              rs1 = inst[19:15];
              imm = {{20{inst[31]}},{inst[31:20]}};
              imm_valid = 1'b1;
    
              add_en = 1'b0;
              sub_en = 1'b0;
              sll_en = 1'b0;
              xor_en = 1'b0;
              sra_en = 1'b0;
              srl_en = 1'b0;
              or_en = 1'b0;
              and_en = 1'b0;

              rd_en_o = 1'b1;
              wr_en_o = 1'b1;
               end   
                
            3'b011:
              begin
              slt_en = 1'b1;
              sign_valid = 1'b0;  
              rd = inst[11:7];
              rs1 = inst[19:15];
              imm = {{20{inst[31]}},{inst[31:20]}};
              imm_valid = 1'b1;
  
              add_en = 1'b0;
              sub_en = 1'b0;
              sll_en = 1'b0;
              slt_en = 1'b0;
              xor_en = 1'b0;
              sra_en = 1'b0;
              srl_en = 1'b0;
              or_en = 1'b0;
              and_en = 1'b0;

              rd_en_o = 1'b1;
              wr_en_o = 1'b1;
              end
                 
            3'b100:
              begin
              xor_en = 1'b1;
              rd = inst[11:7];
              rs1 = inst[19:15];
              imm = {{20{inst[31]}},{inst[31:20]}};
              imm_valid = 1'b1;
  
              add_en = 1'b0;
              sub_en = 1'b0;
              sll_en = 1'b0;
              slt_en = 1'b0;
              sra_en = 1'b0;
              srl_en = 1'b0;
              or_en = 1'b0;
              and_en = 1'b0;

              rd_en_o = 1'b1;
              wr_en_o = 1'b1;
              end
            
            3'b110:
              begin
              or_en = 1'b1;
              rd = inst[11:7];
              rs1 = inst[19:15];
              imm = {{20{inst[31]}},{inst[31:20]}};
              imm_valid = 1'b1;
  
              add_en = 1'b0;
              sub_en = 1'b0;
              sll_en = 1'b0;
              slt_en = 1'b0;
              xor_en = 1'b0;
              sra_en = 1'b0;
              srl_en = 1'b0;
              and_en = 1'b0;

              rd_en_o = 1'b1;
              wr_en_o = 1'b1;
              end
              
            3'b111:
              begin
              and_en = 1'b1;
              rd = inst[11:7];
              rs1 = inst[19:15];
              imm = {{20{inst[31]}},{inst[31:20]}};
              imm_valid = 1'b1;
  
              add_en = 1'b0;
              sub_en = 1'b0;
              sll_en = 1'b0;
              slt_en = 1'b0;
              xor_en = 1'b0;
              sra_en = 1'b0;
              srl_en = 1'b0;
              or_en = 1'b0;

              rd_en_o = 1'b1;
              wr_en_o = 1'b1;
              end
              
            3'b001:
              if(func7 == 7'b0000000)
              begin 
              sll_en = 1'b1;
              rd = inst[11:7];
              rs1 = inst[19:15];
              imm = {27'd0,inst[24:20]};
              imm_valid = 1'b1;
  
              sub_en = 1'b0;
              add_en = 1'b0;
              slt_en = 1'b0;
              xor_en = 1'b0;
              sra_en = 1'b0;
              srl_en = 1'b0;
              or_en = 1'b0;
              and_en = 1'b0;

              rd_en_o = 1'b1;
              wr_en_o = 1'b1;
              end
            
            3'b101:
              if(func7 == 7'b0000000)
              begin
              srl_en = 1'b1;
              rd = inst[11:7];
              rs1 = inst[19:15];
              imm = {27'd0,inst[24:20]};
              imm_valid = 1'b1;
  
              add_en = 1'b0;
              sub_en = 1'b0;
              sll_en = 1'b0;
              slt_en = 1'b0;
              xor_en = 1'b0;
              sra_en = 1'b0;
              or_en = 1'b0;
              and_en = 1'b0; 

              rd_en_o = 1'b1;
              wr_en_o = 1'b1; 
              end
            
              else if(func7 == 7'b0100000)
              begin
              sra_en = 1'b1;
              rd = inst[11:7];
              rs1 = inst[19:15];
              imm = {27'd0,inst[24:20]};
              imm_valid = 1'b1;
  
              add_en = 1'b0;
              sub_en = 1'b0;
              sll_en = 1'b0;
              slt_en = 1'b0;
              xor_en = 1'b0;
              srl_en = 1'b0;
              or_en = 1'b0;
              and_en = 1'b0;

              rd_en_o = 1'b1;
              wr_en_o = 1'b1;
              end
            
              else
            begin 
              add_en = 1'b0; 
              sub_en = 1'b0;
              sll_en = 1'b0;
              slt_en = 1'b0;
              xor_en = 1'b0;
              sra_en = 1'b0;
              srl_en = 1'b0;
              or_en = 1'b0;
              and_en = 1'b0;

              rd_en_o = 1'b0;
              wr_en_o = 1'b0;
            end
            
          default:
            begin 
              add_en = 1'b0; 
              sub_en = 1'b0;
              sll_en = 1'b0;
              slt_en = 1'b0;
              xor_en = 1'b0;
              sra_en = 1'b0;
              srl_en = 1'b0;
              or_en = 1'b0;
              and_en = 1'b0;

              rd_en_o = 1'b0;
              wr_en_o = 1'b0;
            end
            
      endcase
        
        default:
          begin 
              add_en = 1'b0; 
              sub_en = 1'b0;
              sll_en = 1'b0;
              slt_en = 1'b0;
              xor_en = 1'b0;
              sra_en = 1'b0;
              srl_en = 1'b0;
              or_en = 1'b0;
              and_en = 1'b0;

              rd_en_o = 1'b0;
              wr_en_o = 1'b0;
            end
          
        
      endcase
      
    end
  
endmodule

   
        
            
