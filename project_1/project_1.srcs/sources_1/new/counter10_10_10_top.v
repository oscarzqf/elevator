`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2022/05/16 18:04:15
// Design Name: 
// Module Name: counter10_10_10_top
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

module counter10_10_10_top(
    input clk_50M,
    input CLR_L,
    input start_stop,
    output [7:0] seg,
    output [2:0] dig
    );
	 //分频部分
	wire clk_s;
//参照课件上顶层模块连接图，在下面写出分频电路的例化语句
	 
	 clk_div u1(
    .clk_in(clk_50M),
    .clk_out(clk_s)
    );

	//计数器部分
         	wire EN;               //使能信号      
         	wire[3:0] Q_0,Q_1,Q_2;// 计数器的输出
        	wire cy_0,cy_1,cy_2;  //进位信号
//参照课件上顶层模块连接图，在下面写出3个计数器电路的例化语句

	counter10 u2(
    .clk(clk_s),
    .clr(CLR_L),
    .EN(start_stop),
    .Q(Q_0),
    .cy(cy_0)
    );
	counter10 u3(
    .clk(clk_s),
    .clr(CLR_L),
    .EN(cy_0),
    .Q(Q_1),
    .cy(cy_1)                       
     );
	counter10 u4(
    .clk(clk_s),
    .clr(CLR_L),
    .EN(cy_1),
    .Q(Q_2),
    .cy(cy_2)
           );
	 
                                                
         //调用3位数码管显示模块
          wire[3:0] disp_data_right0,disp_data_right1,disp_data_right2;
          assign disp_data_right0=Q_0;
          assign disp_data_right1=Q_1;
          assign disp_data_right2=Q_2;    
          dynamic_led3 u5 (
              .disp_data_right0(disp_data_right0), 
              .disp_data_right1(disp_data_right1),
               .disp_data_right2(disp_data_right2),
               .clk(clk_50M),
               .seg(seg),
               .dig(dig)
                           );
endmodule
                                                    
                                          
