module 	riscv_processor(
        input [31:0]instruction,
        input clk
);


wire add_en_w;
wire sub_en_w;
wire sll_en_w;
wire slt_en_w;
wire xor_en_w;
wire sra_en_w;
wire srl_en_w;
wire or_en_w;
wire and_en_w;

wire sign_valid_w;
wire imm_valid_w;

wire [4:0]rd_w;
wire [4:0]rs1_w;
wire [4:0]rs2_w;
wire [31:0]imm_w;

wire [31:0]rd_data1_w;
wire [31:0]rd_data2_w;
wire [31:0]alu_out_w;

wire rd_en_w;
wire wr_en_w;


r_type r_tpe_instance(

              .inst(instruction),
  
              .add_en(add_en_w),
              .sub_en(sub_en_w),
              .sll_en(sll_en_w),
              .slt_en(slt_en_w),
              .xor_en(xor_en_w),
              .sra_en(sra_en_w),
              .srl_en(srl_en_w),
              .or_en(or_en_w),
              .and_en(and_en_w),
  
              .sign_valid(sign_valid_w),
              .imm_valid(imm_valid_w),  
     
              .rd(rd_w),
              .rs1(rs1_w),
              .rs2(rs2_w),
              .imm(imm_w),

              .rd_en_o(rd_en_w),
              .wr_en_o(wr_en_w)
       
          );


top_alu top_alu_instance(

      .add_en(add_en_w),           
      .sub_en(sub_en_w),
      .sll_en(sll_en_w),
      .slt_en(slt_en_w),
      .xor_en(xor_en_w),
      .sra_en(sra_en_w),
      .srl_en(srl_en_w),
      .or_en(or_en_w),
      .and_en(and_en_w),

      .sign_valid(sign_valid_w),
      .imm_valid(imm_valid_w),

      .imm(imm_w),
     
      .rd_data1(rd_data1_w),   
      .rd_data2(rd_data2_w),

      .alu_out(alu_out_w)

);

ramcu ramcu_instance(

              .clk(clk),
              
             
              .wr_en(wr_en_w),
              .wr_addr(rd_w),
              .wr_data(alu_out_w),
             
             
             
              

              .rd_en(rd_en_w),
              .rd_addr1(rs1_w),
              .rd_data1(rd_data1_w),
              .rd_addr2(rs2_w),
              .rd_data2(rd_data2_w)

              );
endmodule
