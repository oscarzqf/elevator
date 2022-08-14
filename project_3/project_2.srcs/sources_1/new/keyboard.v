`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2022/05/25 18:22:37
// Design Name: 
// Module Name: keyboard
// Project Name: 
// Target Devices: 
// Tool Versions: 
// Description: 
// 
// Dependencies: 
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
//////////////////////////////////////////////////////////////////////////////////


module keyboard(
input clk_1k,//����ɨ��ʱ��
input clk_50,//��������ʱ��50Hz
input [3:0]col,//4������
output  [3:0]row,//4�����
output  upButton,//��Ӧһ¥�����ⰴ��
output  downButton,//��Ӧ��¥�����ⰴ��
output  upstair,//һ¥�����ڰ���
output  downstair);//��¥�����ڰ���
assign row[3:0]=4'b0001;//�̶�һ��row3
reg [3:0] btn=0;//��ʼ��Ϊ0
always @ (negedge clk_1k)
    begin
        btn[3:0]=col;
    end 
   //���ĸ�������������
  ajxd u0(
        .btn_in(btn[3]), 
        .clk(clk_50),
        .btn_out(downstair)
        );   
   ajxd u1(
         .btn_in(btn[2]), 
         .clk(clk_50),
         .btn_out(upstair)
          ); 
  ajxd u2(
         .btn_in(btn[1]), 
         .clk(clk_50),
         .btn_out(downButton)
           );  
  ajxd u3(
         .btn_in(btn[0]), 
         .clk(clk_50),
         .btn_out(upButton)
           );  
                                                        
endmodule
