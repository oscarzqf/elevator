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
input clk_1k,//键盘扫描时钟
input clk_50,//按键消抖时钟50Hz
input [3:0]col,//4列输入
output  [3:0]row,//4行输出
output  upButton,//对应一楼电梯外按键
output  downButton,//对应二楼电梯外按键
output  upstair,//一楼电梯内按键
output  downstair);//二楼电梯内按键
assign row[3:0]=4'b0001;//固定一行row3
reg [3:0] btn=0;//初始化为0
always @ (negedge clk_1k)
    begin
        btn[3:0]=col;
    end 
   //对四个按键进行消抖
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
