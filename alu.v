//////////////////////////          TOP MODULE        //////////////////

module top_alu(
    
       input add_en,            ////   from  decoder
       input sub_en,
       input sll_en,
       input slt_en,
       input xor_en,
       input sra_en,
       input srl_en,
       input or_en,
       input and_en,

       input sign_valid,
       input imm_valid,

       input [31:0]imm,
     
       input [31:0]rd_data1,    ////   from  SRAM
       input [31:0]rd_data2,

       output [31:0]alu_out
       
);

wire [31:0]sum_w;
wire [31:0]diff_w;
wire [31:0]sll_w;
wire [31:0]slt_sltu_w;
wire [31:0]xor_w;
wire [31:0]sra_w;
wire [31:0]srl_w;
wire [31:0]or_w;
wire [31:0]and_w;



add add_instance(              

        .in1(rd_data1),
        .in2(rd_data2),
        .en(add_en),
        .imm(imm),
        .imm_valid(imm_valid),
        .sign_valid(sign_valid),
        .sum(sum_w)
       );

sub sub_instance(

        .in1(rd_data1),
        .in2(rd_data2),
        .en(sub_en),
        .diff(diff_w)
       );

sll sll_instance(

        .in1(rd_data1),
        .in2(rd_data2),
        .en(sll_en),
        .imm(imm),
        .imm_valid(imm_valid),
        .sll_res(sll_w)
       );

slt_sltu slt_sltu_instance(

        .in1(rd_data1),
        .in2(rd_data2),
        .en(slt_en),
        .sign_valid(sign_valid),
        .imm(imm),
        .imm_valid(imm_valid),
        .slt_sltu_res(slt_sltu_w)
       );

xor_ xor_instance(

        .in1(rd_data1),
        .in2(rd_data2),
        .en(xor_en),
        .imm(imm),
        .imm_valid(imm_valid),
        .xor_res(xor_w)
       );

sra sra_instance(

        .in1(rd_data1),
        .in2(rd_data2),
        .en(sra_en),
        .imm(imm),
        .imm_valid(imm_valid),
        .sra_res(sra_w)
       );

srl srl_instance(

        .in1(rd_data1),
        .in2(rd_data2),
        .en(srl_en),
        .imm(imm),
        .imm_valid(imm_valid),
        .srl_res(srl_w)
       );

or_ or_instance(

        .in1(rd_data1),
        .in2(rd_data2),
        .en(or_en),
        .imm(imm),
        .imm_valid(imm_valid),
        .or_res(or_w)
       );

and_ and_instance(

        .in1(rd_data1),
        .in2(rd_data2),
        .en(and_en),
        .imm(imm),
        .imm_valid(imm_valid),
        .and_res(and_w)
       );

mux mux_instance(
        .add_i(sum_w),
        .sub_i(diff_w),
        .sll_i(sll_w),
        .slt_sltu_i(slt_sltu_w),
        .xor_i(xor_w),
        .sra_i(sra_w),
        .srl_i(srl_w),
        .or_i(or_w),
        .and_i(and_w),
        
              .add_en(add_en),
              .sub_en(sub_en),
              .sll_en(sll_en),
              .slt_en(slt_en),
              .xor_en(xor_en),
              .sra_en(sra_en),
              .srl_en(srl_en),
              .or_en(or_en),
              .and_en(and_en),  
                 
        .mux_out(alu_out)
       );
endmodule

//////////////////////////////////////////       ALU BLOCK     ///////////////

module add(
            input     [31:0]in1,
            input     [31:0]in2,
            input     en,
            input     [31:0]imm,
            input     imm_valid,
            input     sign_valid,
            output    [31:0]sum 
      );
 wire [31:0]op_w;
 assign op_w = imm_valid ? imm : in2 ; 

  
  assign sum = en ? (in1+op_w) : 0 ;
endmodule



module sub(
            input     [31:0]in1,
            input     [31:0]in2,
            input     en,
            output    [31:0]diff 
      );

  assign diff = en ? (in1-in2) : 0 ;
endmodule



module sll(
            input     [31:0]in1,
            input     [31:0]in2,
            input     en,
            input     [31:0]imm,
            input     imm_valid,
            output    [31:0]sll_res 
      );
 wire [31:0]op_w;
 assign op_w = imm_valid ? imm : in2 ; 
 
  assign sll_res = en ? (in1<<op_w[4:0]) : 0 ;
endmodule



module slt_sltu(
            input     [31:0]in1,
            input     [31:0]in2,
            input     sign_valid,
            input     en,
            input     [31:0]imm,
            input     imm_valid,
            output reg   [31:0]slt_sltu_res 
      );
  
    wire [1:0]check_MSB;
    wire [31:0]op_w;
    assign op_w = imm_valid ? imm : in2 ; 

    assign check_MSB[0] = in1[31]; 
    assign check_MSB[1] = op_w[31];
        
 always@*
  if(en)
    begin
      case(sign_valid)
        
        1'b1 :
          
          case(check_MSB)
         2'b00:
       assign slt_sltu_res = (in1<op_w) ? 32'd1 : 32'd0 ; 
         2'b01 :
       assign slt_sltu_res = 32'd1 ;
         2'b10 :
       assign slt_sltu_res = 32'd0 ;
          2'b11 : 
       assign slt_sltu_res = (in1[30:0] < op_w[30:0]) ? 32'd1 : 32'd0 ;
          2'b00:
       assign slt_sltu_res = (in1<op_w) ? 32'd1 : 32'd0 ; 
            default : slt_sltu_res = 32'd0;
          endcase
        
        1'b0 :
              assign slt_sltu_res = (in1<op_w) ? 32'd1 : 32'd0 ; ///sltu operation
        default :
      assign    slt_sltu_res = 32'd0;
      endcase
    end
        
endmodule
      

            
module xor_(
            input     [31:0]in1,
            input     [31:0]in2,
            input     en,
            input     [31:0]imm,
            input     imm_valid,
            output    [31:0]xor_res 
      );
  wire [31:0]op_w;
 assign op_w = imm_valid ? imm : in2 ; 

  assign xor_res = en ? (in1^op_w) : 0 ;
endmodule



module sra(
            input     [31:0]in1,
            input     [31:0]in2,
            input     en,
            input     [31:0]imm,
            input     imm_valid,
            output    [31:0]sra_res 
      );
  wire [31:0]op_w;
 assign op_w = imm_valid ? imm : in2 ; 

  assign sra_res = en ? (in1>>>op_w[4:0]) : 0 ;
endmodule



module srl(
            input     [31:0]in1,
            input     [31:0]in2,
            input     en,
            input     [31:0]imm,
            input     imm_valid,
            output    [31:0]srl_res 
      );
  wire [31:0]op_w;
 assign op_w = imm_valid ? imm : in2 ; 

  assign srl_res = en ? (in1>>op_w[4:0]) : 0 ;
endmodule



module or_(
            input     [31:0]in1,
            input     [31:0]in2,
            input     en,
            input     [31:0]imm,
            input     imm_valid,
            output    [31:0]or_res 
      );
  wire [31:0]op_w;
 assign op_w = imm_valid ? imm : in2 ; 

  assign or_res = en ? (in1|op_w) : 0 ;
endmodule



module and_(
            input     [31:0]in1,
            input     [31:0]in2,
            input     en,
            input     [31:0]imm,
            input     imm_valid,
            output    [31:0]and_res 
      );
 wire [31:0]op_w;
 assign op_w = imm_valid ? imm : in2 ; 
 
  assign and_res = en ? (in1&op_w) : 0 ;
endmodule


////////////////////////////////////////////        mux block        ///////////


module mux(

         input  [31:0]add_i,
         input  [31:0]sub_i,
         input  [31:0]sll_i,
         input  [31:0]slt_sltu_i,
         input  [31:0]xor_i,
         input  [31:0]sra_i,
         input  [31:0]srl_i,
         input  [31:0]or_i,
         input  [31:0]and_i,

input        and_en,
input     or_en,
input    srl_en,
input     sra_en,
input     xor_en,
input     slt_en,
input     sll_en,
input     sub_en,
input     add_en,

 output reg [31:0]mux_out
);

wire [8:0]select_line;
assign select_line = {and_en,or_en,srl_en,sra_en,xor_en,slt_en,sll_en,sub_en,add_en};

always@*
begin

case(select_line)

9'd1 : mux_out = add_i;
9'd2 : mux_out = sub_i;
9'd4 : mux_out = sll_i;
9'd8 : mux_out = slt_sltu_i;
9'd16 : mux_out = xor_i;
9'd32 : mux_out = sra_i;
9'd64 : mux_out = srl_i;
9'd128 : mux_out = or_i;
9'd256 : mux_out = and_i;
default :
          mux_out = 32'd0 ;
endcase
end

endmodule

