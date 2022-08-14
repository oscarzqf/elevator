`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2022/05/25 18:24:42
// Design Name: 
// Module Name: dian_ti
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


module dian_ti(
input clk,//ϵͳʱ��
input set,//����
input reset,//��λ
input key0,//һ¥�ⰴ��
input key1,//��¥�ⰴ��
input key2,//һ¥�ڰ���
input key3,//��¥�ڰ���
output reg [3:0]led=0,//�ĸ�ledָʾ��
output reg [1:0]state=0,//00����״̬ 01����״̬ 10����״̬
output reg [1:0]floor=1  //¥�� 01һ¥ 10��¥ 
	);
reg [2:0] num;
reg [27:0]clk_count=0;
always@(posedge clk)
begin
if(!reset)//���²�������reset=0ʱ��λ
       begin
        led=4'b0000;
        state=0;
        floor=1;//�ص�һ¥����
       end
else if(set)//���������ϲ�������set=1ʱ��������Ч
   begin
        if(led)//led������0ʱ��˵���������ź�
           begin 
           if(clk_count==199999999)//����4s 
            begin            
                clk_count=0;                           
                if((floor==1)) 
                    begin 
                        floor=floor+1; //ʱ�䵽¥��ű仯+1
                     end
                else          
                    begin 
                         floor=floor-1; //ʱ�䵽¥��ű仯-1
                    end                     
                state=0;  //����״̬       
                led=4'b0000;//led����
          end
         else  
            clk_count=clk_count+1;
    end
    else if((key0)&&state==0)  //һ¥����key0�ҵ��ݴ���
                 begin                
                         if(floor==2)
                           begin
                           led[0]=1; //һ¥���������
                           state=2;  //����״̬
                           end
                  end 
                  
    else if((key1)&&state==0)//
                          begin
                              if(floor==1)
                              begin
                                  led[1]=1;//��¥���������
                                  state=1;//����
                              end
                          end
                       
     else if((key3)&&floor==1)  //��һ¥ �����ڰ��� 
                                 begin
                                    led[3]=1;
                                    state=1; //��������
                                 end 
      else if((key2)&&floor==2)  //�ڶ�¥�������ڰ�
                                   begin
                                   led[2]=1;
                                   state=2; //��������
                                   end                                 
      end
end
endmodule
