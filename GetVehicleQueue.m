%计算车队列

%算法
%日期换算成s
%轴距单位mm换算成m
%km/h换算成m/s

tic;

HSData_DT_Column=1;
Gross_Load_Column=3;
LWheel_1_W_Column=4;    %4~11
RWheel_1_W_Column=12;    %12~19
AxleDis_Column=20;    %20~26
Speed_ColumnColumn=27;

temp=datenum(DataA(:,1))*24*3600;    %天换算成秒
procData=[temp cell2mat(DataA(:,2:end))];
procData(:,AxleDis_Column:AxleDis_Column+6)=procData(:,AxleDis_Column:AxleDis_Column+6)/1000;    %mm转换成m
procData(:,Speed_ColumnColumn)=procData(:,Speed_ColumnColumn)/3.6;
totalX=[];    %车队x
totalY=[];    %车队轴重

for i=1:size(procData,1)
    currData=procData(i,:);
    x=[0];    %轴距
    y=[];    %轴重
    if i==1
        prevData=currData;
    else
        prevData=procData(i-1,:);
    end
    %TODO：校核y和x数据的维度
    for j=1:7
        if currData(1,AxleDis_Column+j-1)~=0
            x=[x currData(1,AxleDis_Column+j-1) ];    %轴距
        end
    end
    %根据车速修正
    x=x+currData(1,Speed_ColumnColumn)*(currData(1,HSData_DT_Column)-prevData(1,HSData_DT_Column));    
    %根据上一辆车最后距离修正
    if size(totalX,1)>0
        x=x+totalX(1,end);
    end
    for j=1:8
        if currData(1,LWheel_1_W_Column+j-1)~=0
            y=[y currData(1,LWheel_1_W_Column+j-1)+currData(1,RWheel_1_W_Column+j-1) ];    %轮重
        end
    end
    
    totalX=[totalX x];
    totalY=[totalY y];
end
toc;
%plot(totalX,totalY)
