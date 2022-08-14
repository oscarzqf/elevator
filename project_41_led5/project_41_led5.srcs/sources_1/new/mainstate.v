`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2022/05/28 11:45:35
// Design Name: 
// Module Name: mainstate
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


module mainstate(
input clk,//ϵͳʱ��
input set,//����
input reset,//��λ
input key0,//һ¥�ⰴ��
input key1,//��¥�ⰴ��
input key2,//һ¥�ڰ���
input key3,//��¥�ڰ���
output reg [3:0]led=0,//�ĸ�ledָʾ��
output reg [1:0]state=0,//00��һ¥����    01��һ¥����״̬  10 ��¥����״̬  11��¥����״̬
output reg[1:0] ledfloor=1
	);
	integer clk_count0=0;
	integer clk_count1=0;
	reg[1:0] nextstate=0;
always@(posedge clk)
begin
if(!reset)
begin
led=4'b0000;//led����
if(state==2)//����ڵڶ���Ļ�
begin
state=3;//���ڶ�¥����״̬
end
end
else if(set)//������,��������������Ч��

begin
 if((key0)&&state==2)  //һ¥����key0�ҵ��ݶ�¥����
                begin                
                          led[0]=1; //һ¥���������
                          state=3;  //2¥����״̬      
                 end 
else if((key1)&&state==0)//��¥�����ҵ�����һ¥����
                       begin
                               led[1]=1;//��¥���������
                               state=1;//1¥����״̬  
                       end
                                        
else if((key3)&&state==0)  //��һ¥ �����ڰ��� 
                          begin
                             led[3]=1;
                             state=1; //����һ¥����״̬
                             
                                
                          end 
else if((key2)&&state==2)  //�ڶ�¥�������ڰ�
                            begin
                            led[2]=1;
                            state=3; //���ݶ�¥����״̬
                            end                                            
end



if(state==1&&led[1]==1)//key1������������״̬
begin
if(clk_count0==249999999)
            begin            
                clk_count0=0;                           
                 state=2;  //2¥����״̬       
                led[1]=0;//led����
            end
       else  
            clk_count0=clk_count0+1;
end

if(state==1&&led[3]==1)//key3������������״̬
begin
//��������ʵ�ְ���key3�����̰���key2�߼�,����д��������߼����жϣ�˳��ִ��̫�죬����ִ��key2�߼�
 if(key2)//�������key2�����߼�
                begin
                led[2]=1;
                nextstate=3;//����¥����һ��״̬Ϊ��¥����
                end
 //ʵ�����̰���key0�߼�
 else if(key0)//�������key2�����߼�
                begin
                led[0]=1;
                nextstate=3;//����¥����һ��״̬Ϊ��¥����
                end
                
if(clk_count0==249999999)//����5s
            begin            
                clk_count0=0;                           
                 state=2;  //2¥����״̬       
                led[3]=0;//led����
                
                       //���̰����߼�
                         //���̰���led2�߼�
                        if(led[2])//led2��˵�����Ű�����key2
                        begin
                        state=nextstate;//�ı䵱ǰ״̬Ϊ2¥����
                        end
                        //���̰���key0
                        else if(led[0])//led0��˵�����Ű�����key0
                         begin
                         state=nextstate;//�ı䵱ǰ״̬Ϊ2¥����
                         end
                         
            end
         else  
            clk_count0=clk_count0+1;
end


if(state==3&&led[0]==1)//key0��������2¥����״̬
begin
 if(clk_count1==249999999)
            begin            
                clk_count1=0;                           
                 state=0;  //1¥����״̬       
                led[0]=0;//led����
            end
        else  
            clk_count1=clk_count1+1;
end 


if(state==3&&led[2]==1)//key2��������2¥����״̬,
begin

//������ʵ�����̰����߼�
 if(key3)//�������key3�����߼�
                begin
                led[3]=1;
                nextstate=1;//��һ¥����һ��״̬Ϊһ¥����
                end
 //ʵ�����̰���key1�߼�
 else if(key1)//�������key1�����߼�
                begin
                led[1]=1;
                nextstate=1;//��һ¥����һ��״̬Ϊһ¥���У��Է��ض�¥
                end

if(clk_count1==249999999)
              begin            
                clk_count1=0;                           
                 state=0;  //1¥����״̬       
                led[2]=0;//led����
                
                        //���̰����߼�
                         if(led[3])//led3��˵�����Ű�����key3
                           begin
                           state=nextstate;//�ı䵱ǰ״̬
                           end
                           //���̰���key0
                           else if(led[1])//led1��˵�����Ű�����key1
                            begin
                            state=nextstate;//�ı䵱ǰ״̬
                            end
                        
            end
         else  
            clk_count1=clk_count1+1;
end


if(state==3&&!reset)//��λ��������2¥����״̬
begin
if(clk_count1==249999999)//������5s
            begin
                clk_count1=0;//����
                state=0;//1¥����״̬
            end
else
      clk_count1=clk_count1+1;
end

end


//����4s+1s��ʾ������4+1s��ʾ����state״̬�仯ʱִ��
always@(state)
begin
if(state==3&&clk_count1==199999999)
begin
ledfloor=1;
end
else if(state==1&&clk_count0==199999999)
begin
ledfloor=2;
end
end





endmodule
