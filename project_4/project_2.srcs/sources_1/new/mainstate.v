`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2022/05/25 21:09:40
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
input clk,//系统时钟
input set,//启动
input reset,//复位
input key0,//一楼外按键
input key1,//二楼外按键
input key2,//一楼内按键
input key3,//二楼内按键
output reg [3:0]led=0,//四个led指示灯
output reg [1:0]state=0//00，一楼待机    01，一楼上行状态  10 二楼待机状态  11二楼下行状态
	);
	integer clk_count0=0;
	integer clk_count1=0;
always@(posedge clk)
begin
if(!reset)
begin
led=4'b0000;//led清零
if(state==2)//如果在第二层的话
begin
state=3;//置于二楼下行状态
end
end
else if(set)//启动了,按键才有效果
begin
 if((key0)&&state==2)  //一楼按下key0且电梯二楼待机
                begin                
                          led[0]=1; //一楼电梯外灯亮
                          state=3;  //2楼下行状态      
                 end 
else if((key1)&&state==0)//二楼按下且电梯在一楼待机
                       begin
                               led[1]=1;//二楼电梯外灯亮
                               state=1;//1楼上行状态  
                       end
                                        
else if((key3)&&state==0)  //在一楼 电梯内按下 
                          begin
                             led[3]=1;
                             state=1; //电梯一楼上行状态
                          end 
else if((key2)&&state==2)  //在二楼，电梯内按
                            begin
                            led[2]=1;
                            state=3; //电梯二楼下行状态
                            end                                            
end

if(state==1&&led[1]==1)//key1按下引发上行状态
begin
if(clk_count0==199999999)//计数4s 
            begin            
                clk_count0=0;                           
                 state=2;  //2楼待机状态       
                led[1]=0;//led清零
            end
         else  
            clk_count0=clk_count0+1;
end

if(state==1&&led[3]==1)//key3按下引发上行状态
begin
if(clk_count0==199999999)//计数4s 
            begin            
                clk_count0=0;                           
                 state=2;  //2楼待机状态       
                led[3]=0;//led清零
            end
         else  
            clk_count0=clk_count0+1;
end


if(state==3&&led[0]==1)//key0按下引发2楼下行状态
begin
if(clk_count1==199999999)//计数4s 
            begin            
                clk_count1=0;                           
                 state=0;  //1楼待机状态       
                led[0]=0;//led清零
            end
         else  
            clk_count1=clk_count1+1;
end 


if(state==3&&led[2]==1)//key2按下引发2楼下行状态,
begin
if(clk_count1==199999999)//计数4s 
            begin            
                clk_count1=0;                           
                 state=0;  //1楼待机状态       
                led[2]=0;//led清零
            end
         else  
            clk_count1=clk_count1+1;
end


if(state==3&&!reset)//复位动作引发2楼下行状态,
begin
if(clk_count1==199999999)//计数4s 
            begin            
                clk_count1=0;                           
                 state=0;  //1楼待机状态       
            end
         else  
            clk_count1=clk_count1+1;
end



end	

endmodule
