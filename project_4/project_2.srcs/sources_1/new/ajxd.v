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
    input btn_in, //未消抖信号
    input clk,//50Hz时钟
    output btn_out//消抖后按键输出
    );  
    reg  btn0=0;//定义了btn0寄存器
    reg  btn1=0;//定义了btn1寄存器
    reg  btn2=0;//定义了btn2寄存器
 always@ (posedge clk)
      begin
          btn0<=btn_in;
          btn1<=btn0;
         btn2<=btn1;
      end
      assign btn_out=(btn2&btn1&btn0)|(~btn2&btn1&btn0);//btn_out信号，每按下一次，只产生一个上升沿
endmodule
