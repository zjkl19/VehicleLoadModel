
DataA=LoadVehicleData();

%totalX 车队x
%totalY 车队轴重
[totalX,totalY]=GetVehicleQueue(DataA);
realLoadQueue=MapXY(fix(totalX),totalY);

influenceLine=readmatrix('influenceLine.xlsx');
bendingMoment=zeros(1,size(realLoadQueue,2)-size(influenceLine,1)+1);
for i=1:size(realLoadQueue,2)-size(influenceLine,1)+1    %每米计算1个弯矩
    bendingMoment(i)=realLoadQueue(i:i+size(influenceLine,1)-1)*influenceLine;
end