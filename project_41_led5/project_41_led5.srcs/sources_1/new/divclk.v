`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2022/05/28 11:40:09
// Design Name: 
// Module Name: divclk
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


module divclk(clk,clk_1k,clk_50,clk_1s);
      inout clk;
      output reg clk_1k=0;//������Ҫ�ı���ֵ������ʹ��reg����
      output reg clk_50=0;
      output reg clk_1s=0;
      
      integer clk_div_cnt0=0;//������������
      integer clk_div_cnt1=0;
      integer clk_div_cnt2=0;
      //1khz
      always @ (posedge clk)
              begin
                  if (clk_div_cnt0==24999)////�ж��Ƿ�ﵽ�����,
                  begin
                       clk_div_cnt0<=0;
                      clk_1k=~clk_1k;//�ﵽ��Ƶ����ת
                  end
                  else 
                      clk_div_cnt0<=clk_div_cnt0+1;//δ�ﵽ����������
             end
    //50hz  ,20ms       
       always @ (posedge clk)
             begin
                 if (clk_div_cnt1==499999)//��Ƶ
                         begin
                         clk_div_cnt1<=0;
                           clk_50=~clk_50;
                          end
                  else    
                       clk_div_cnt1<=clk_div_cnt1+1;      
               end 
     //1s                          
         always @ (posedge clk)
                 begin
                 if (clk_div_cnt2==24999999)//��Ƶ
                       begin
                       clk_div_cnt2<=0;
                        clk_1s=~clk_1s;
                        end
                        else 
                         clk_div_cnt2<=clk_div_cnt2+1;
                  end      
endmodule
