`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2022/05/25 18:23:23
// Design Name: 
// Module Name: ajxd
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


module ajxd(
    input btn_in, //δ�����ź�
    input clk,//50Hzʱ��
    output btn_out//�����󰴼����
    );  
    reg  btn0=0;//������btn0�Ĵ���
    reg  btn1=0;//������btn1�Ĵ���
    reg  btn2=0;//������btn2�Ĵ���
 always@ (posedge clk)
      begin
          btn0<=btn_in;
          btn1<=btn0;
         btn2<=btn1;
      end
      assign btn_out=(btn2&btn1&btn0)|(~btn2&btn1&btn0);//btn_out�źţ�ÿ����һ�Σ�ֻ����һ��������
endmodule
