`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2022/05/28 11:46:59
// Design Name: 
// Module Name: elevatortop
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


module elevatortop(
  input clk,
  input set,    //T9启动信号
  input reset,  //f3 复位信号
  input [3:0]col,//列键盘
  output  [3:0]row,//行键盘
  output  [3:0]led,//P9,R8,R7,T5
  output [4:0]led5,//E3,H3,G5,R1,T2,led11-led7
  output [1:0]dig,//位选右边两个
  output [7:0]seg//段选
    );
    wire clk_1k;//1k
    wire clk_50;//50Hz
    wire clk_1s;//1s
 
  divclk u1(.clk(clk),
         .clk_1k(clk_1k),
         .clk_50(clk_50),
         .clk_1s(clk_1s));
         
         wire k0;
         wire k1;
         wire k2;
         wire k3;
  keyboard u2(
         .clk_1k(clk_1k),//键盘扫描
         .clk_50(clk_50),//按键消抖
         .col(col),//列
         .row(row),//行
         .upButton(k0),//对应一楼按键
         .downButton(k1),//对应二楼按键
         .upstair(k2),
         .downstair(k3)//对应电梯内1 2按键
         );  
         
            wire [1:0]state; 
             wire [1:0]ledfloor; 
           
  mainstate u3(
              .clk(clk),
              .set(set),
               .reset(reset),
              .key0(k0),
              .key1(k1),
              .key2(k2),
              .key3(k3),
              .led(led),//指示灯
              .state(state),//00待机状态 01上行状态 10下机状态
              .ledfloor(ledfloor)
              ); 
   dynamic_led2 u4(
               .state(state),
                .ledfloor(ledfloor),
               .clk(clk_1k),
               .seg(seg),
               .dig(dig)       
               );      
    led_5 u5(
        .clk_1s(clk_1s),
        .state(state),
        .led_o(led5)
    );        
endmodule
