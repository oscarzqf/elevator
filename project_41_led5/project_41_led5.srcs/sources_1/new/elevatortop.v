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
  input set,    //T9�����ź�
  input reset,  //f3 ��λ�ź�
  input [3:0]col,//�м���
  output  [3:0]row,//�м���
  output  [3:0]led,//P9,R8,R7,T5
  output [4:0]led5,//E3,H3,G5,R1,T2,led11-led7
  output [1:0]dig,//λѡ�ұ�����
  output [7:0]seg//��ѡ
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
         .clk_1k(clk_1k),//����ɨ��
         .clk_50(clk_50),//��������
         .col(col),//��
         .row(row),//��
         .upButton(k0),//��Ӧһ¥����
         .downButton(k1),//��Ӧ��¥����
         .upstair(k2),
         .downstair(k3)//��Ӧ������1 2����
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
              .led(led),//ָʾ��
              .state(state),//00����״̬ 01����״̬ 10�»�״̬
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
