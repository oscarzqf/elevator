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
input clk,//系统时钟
input set,//启动
input reset,//复位
input key0,//一楼外按键
input key1,//二楼外按键
input key2,//一楼内按键
input key3,//二楼内按键
output reg [3:0]led=0,//四个led指示灯
output reg [1:0]state=0,//00待机状态 01上行状态 10下行状态
output reg [1:0]floor=1  //楼层 01一楼 10二楼 
	);
reg [2:0] num;
reg [27:0]clk_count=0;
always@(posedge clk)
begin
if(!reset)//向下拨动，即reset=0时复位
       begin
        led=4'b0000;
        state=0;
        floor=1;//回到一楼待机
       end
else if(set)//启动，向上拨动，即set=1时，按键有效
   begin
        if(led)//led不等于0时，说明有请求信号
           begin 
           if(clk_count==199999999)//计数4s 
            begin            
                clk_count=0;                           
                if((floor==1)) 
                    begin 
                        floor=floor+1; //时间到楼层号变化+1
                     end
                else          
                    begin 
                         floor=floor-1; //时间到楼层号变化-1
                    end                     
                state=0;  //待机状态       
                led=4'b0000;//led清零
          end
         else  
            clk_count=clk_count+1;
    end
    else if((key0)&&state==0)  //一楼按下key0且电梯待机
                 begin                
                         if(floor==2)
                           begin
                           led[0]=1; //一楼电梯外灯亮
                           state=2;  //下行状态
                           end
                  end 
                  
    else if((key1)&&state==0)//
                          begin
                              if(floor==1)
                              begin
                                  led[1]=1;//二楼电梯外灯亮
                                  state=1;//上行
                              end
                          end
                       
     else if((key3)&&floor==1)  //在一楼 电梯内按下 
                                 begin
                                    led[3]=1;
                                    state=1; //电梯上行
                                 end 
      else if((key2)&&floor==2)  //在二楼，电梯内按
                                   begin
                                   led[2]=1;
                                   state=2; //电梯下行
                                   end                                 
      end
end
endmodule
