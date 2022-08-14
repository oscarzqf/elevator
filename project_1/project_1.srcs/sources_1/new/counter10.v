`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2022/05/16 18:01:38
// Design Name: 
// Module Name: counter10
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

module counter10(clk,clr,EN,Q,cy);
	input clk,clr;
	input EN;               //ʹ���ź�
	output cy;              //��������λ���
	output reg [3:0] Q;     // �����������
        
         always @(posedge clk or negedge clr)  //�첽����
              begin
                  if (~clr)       //������Ч
                    begin 
                     Q<=0;
                   end          //���������������������Ϊ0
                  else if(EN==1)  //ʹ����Ч
                    begin
                     if (Q==9)    //����+1������λ�Ѿ��������9
                      begin 
                        Q<=0;      //�����ת����С��0
                        end
                     else Q<=Q+1;       //�����δ�����������ֻ��1
                     end
              end
               //�Ƶ������9��ͬʱʹ����Ч�����CyΪ1
              assign cy=((EN==1)&&(Q==9))?1'b1:1'b0;
endmodule
