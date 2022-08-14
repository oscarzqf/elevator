`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2022/05/25 18:19:41
// Design Name: 
// Module Name: fenpin
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


module fenpin(clk,clk_1k,clk_50,clk_4s);
      inout clk;
      output reg clk_1k=0;//后面需要改变数值，所以使用reg类型
      output reg clk_50=0;
      output reg clk_4s=0;
      
      integer clk_div_cnt0=0;//计数个数保存
      integer clk_div_cnt1=0;
      integer clk_div_cnt2=0;
      //1khz
      always @ (posedge clk)
              begin
                  if (clk_div_cnt0==24999)////判断是否达到最大数,
                  begin
                       clk_div_cnt0<=0;
                      clk_1k=~clk_1k;//达到分频并反转
                  end
                  else 
                      clk_div_cnt0<=clk_div_cnt0+1;//未达到，继续计数
             end
    //50hz  ,20ms       
       always @ (posedge clk)
             begin
                 if (clk_div_cnt1==499999)//分频
                         begin
                         clk_div_cnt1<=0;
                           clk_50=~clk_50;
                          end
                  else    
                       clk_div_cnt1<=clk_div_cnt1+1;      
               end 
     //4s                          
         always @ (posedge clk)
                 begin
                 if (clk_div_cnt2==9999999)//分频
                       begin
                       clk_div_cnt2<=0;
                        clk_4s=~clk_4s;
                        end
                        else 
                         clk_div_cnt2<=clk_div_cnt2+1;
                  end      
endmodule
