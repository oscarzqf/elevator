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
input clk,//系统时钟
input set,//启动
input reset,//复位
input key0,//一楼外按键
input key1,//二楼外按键
input key2,//一楼内按键
input key3,//二楼内按键
output reg [3:0]led=0,//四个led指示灯
output reg [1:0]state=0,//00，一楼待机    01，一楼上行状态  10 二楼待机状态  11二楼下行状态
output reg[1:0] ledfloor=1
	);
	integer clk_count0=0;
	integer clk_count1=0;
	reg[1:0] nextstate=0;
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
else if(set)//启动了,接下来按键才有效果

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
if(clk_count0==249999999)
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
//接下来先实现按下key3后立刻按下key2逻辑,不能写在上面的逻辑中判断，顺序执行太快，不能执行key2逻辑
 if(key2)//如果按下key2进入逻辑
                begin
                led[2]=1;
                nextstate=3;//到二楼后下一个状态为二楼下行
                end
 //实现立刻按下key0逻辑
 else if(key0)//如果按下key2进入逻辑
                begin
                led[0]=1;
                nextstate=3;//到二楼后下一个状态为二楼下行
                end
                
if(clk_count0==249999999)//计数5s
            begin            
                clk_count0=0;                           
                 state=2;  //2楼待机状态       
                led[3]=0;//led清零
                
                       //立刻按下逻辑
                         //立刻按下led2逻辑
                        if(led[2])//led2亮说明接着按下了key2
                        begin
                        state=nextstate;//改变当前状态为2楼下行
                        end
                        //立刻按下key0
                        else if(led[0])//led0亮说明接着按下了key0
                         begin
                         state=nextstate;//改变当前状态为2楼下行
                         end
                         
            end
         else  
            clk_count0=clk_count0+1;
end


if(state==3&&led[0]==1)//key0按下引发2楼下行状态
begin
 if(clk_count1==249999999)
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

//接下来实现立刻按下逻辑
 if(key3)//如果按下key3进入逻辑
                begin
                led[3]=1;
                nextstate=1;//到一楼后下一个状态为一楼上行
                end
 //实现立刻按下key1逻辑
 else if(key1)//如果按下key1进入逻辑
                begin
                led[1]=1;
                nextstate=1;//到一楼后下一个状态为一楼上行，以返回二楼
                end

if(clk_count1==249999999)
              begin            
                clk_count1=0;                           
                 state=0;  //1楼待机状态       
                led[2]=0;//led清零
                
                        //立刻按下逻辑
                         if(led[3])//led3亮说明接着按下了key3
                           begin
                           state=nextstate;//改变当前状态
                           end
                           //立刻按下key0
                           else if(led[1])//led1亮说明接着按下了key1
                            begin
                            state=nextstate;//改变当前状态
                            end
                        
            end
         else  
            clk_count1=clk_count1+1;
end


if(state==3&&!reset)//复位动作引发2楼下行状态
begin
if(clk_count1==249999999)//计数第5s
            begin
                clk_count1=0;//清零
                state=0;//1楼待机状态
            end
else
      clk_count1=clk_count1+1;
end

end


//下行4s+1s显示与上行4+1s显示，当state状态变化时执行
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
