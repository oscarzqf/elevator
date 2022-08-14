`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2022/05/28 11:44:35
// Design Name: 
// Module Name: led_5
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


module led_5(
input clk_1s,//1s时钟
input[1:0] state,
output reg[4:0] led_o
    );
    reg[2:0] s_present=0;
    reg[2:0] s_next;
    always@(s_present,state)
    if(s_present==4|state==0|state==2)
        begin
        s_next=-1;//保证从state变化后开始显示第一个
        end
       else
        s_next=s_present+1;
     always@(negedge clk_1s)
     begin
            s_present<=s_next;
     end
     always@(state,s_present)
     begin
     if(state==1)
        case(s_present)
            0:led_o=5'b10000;
            1:led_o=5'b01000;
            2:led_o=5'b00100;
            3:led_o=5'b00010;
            4:led_o=5'b00001;
            default:led_o=5'b00000;
         endcase
       else if(state==3)
        case(s_present)
              0:led_o=5'b00001;
              1:led_o=5'b00010;
              2:led_o=5'b00100;
              3:led_o=5'b01000;
              4:led_o=5'b10000;
              default:led_o=5'b00000;
         endcase
        else 
            led_o=5'b00000;
     end
endmodule
