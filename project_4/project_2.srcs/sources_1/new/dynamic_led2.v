`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2022/05/25 18:25:23
// Design Name: 
// Module Name: dynamic_led2
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


module dynamic_led2(
input [1:0]state,//状态
input clk,      //1kHz信号
output reg [7:0] seg,//段码
output reg [1:0] dig//位码，最右边两个
);
reg [1:0] num=0;
	always @ (posedge clk)
	begin
		if (num>=1)
			num=0;
		else
			num=num+1;
	end
	
	//译码器
	always @ (num)
	begin	
		case(num)
		0:dig=2'b10;//右边第一个
		1:dig=2'b01;//右边第二个
		default: dig=0;
		endcase
	end
	
	//数据选择器，确定显示数据
	reg [3:0] disp_data;
	always @ (num)
	begin	
		case(num)
		0:
		      case(state)
		      0:disp_data=1;
		      1:disp_data=1;
		      2:disp_data=2;
		      3:disp_data=2;
		      endcase
		 1://disp_data=state+3'b011;//状态+3分开以避免译码冲突
		      case(state)
                       0:disp_data=0+3'b011;
                       1:disp_data=1+3'b011;
                       2:disp_data=0+3'b011;
                       3:disp_data=2+3'b011;
               endcase
		default: disp_data=0;
		endcase
	end
	//显示译码器
	always@(disp_data)
	begin
		case(disp_data)
		4'h1: seg=8'h06;//1楼
		4'h2: seg=8'h5b;//2楼
		4'h3: seg=8'h40;//待机
		4'h4: seg=8'h01;//上行
		4'h5: seg=8'h08;//下行
		default: seg=0;
		endcase
	end
   
endmodule
