%大樟桥WIM车辆荷载模型数据处理算法
%桥梁跨径及材质核实

%桥梁概况：跨径3×28m，主梁混凝土：C60，桥面铺装混凝土：C40。该桥缺乏设计图纸，暂定公路-Ⅱ级作为设计荷载（参考20210301中小桥安全监测项目--结题报告）
%桥梁检测报告：2019 年度福州市专养公路桥梁检查项目-大樟中桥
%1、考虑到质量轻的车辆对桥梁内力影响较小，算法对小于3000kg（或其它质量）的车辆的数据进行剔除
%2、算法认为大樟桥跨径小，且经过长期观察，即使是重车，绝大多数车速也在30km/h以上，故认为不同车辆经过称重系统时间间隔较短时才认为是对桥梁同时进行作用。间隔时间暂定为3s
%对时间间隔≤3s的数据进行聚类（层次聚类）
%3、在每个聚类的结果中：
%3.1：如果只有1个元素（1辆车)，直接按最不利影响线加载
%3.2：如果有2个元素（2辆车）每个车道各取1辆最重车按最不利影响线加载（简化算法）

%备注：结果要另外乘以冲击系数，大樟桥f=5.48，u=0.1767*lnf-0.0157=0.285
tic;

f=5.48;
u=0.1767*log(f)-0.0157;    %0.1767*ln(5.48)-0.0157

cutoffValue=3.0;
criGross_Load=1*1000;    %临界重量(kg)，小于等于该重量的数据将被剔除
span=28;    %桥梁跨径：28m
DataA=LoadVehicleData();

%读取大樟桥2条车道的影响线
influenceLine1=readmatrix('DaZhangInfluenceLine1');    %车辆对车辆正下方车道主梁的影响线
influenceLine2=readmatrix('DaZhangInfluenceLine2');    %车辆对车辆正下方车道主梁相邻主梁的影响线
influenceLine=[influenceLine1 influenceLine2];

HSData_DT_Column=1;
Lane_Id_Column=2;
Axle_Num_Column=3;
Gross_Load_Column=4;
LWheel_1_W_Column=5;    %5~12
RWheel_1_W_Column=13;    %13~20
AxleDis_Column=21;    %21~27
Speed_ColumnColumn=28;

temp=datenum(DataA(:,1))*24*3600;    %时间换算成秒
procData=[temp cell2mat(DataA(:,2:end))];
procData(procData(:,Gross_Load_Column)<=criGross_Load,:)=[];
vehicleLoadEffect=zeros(length(procData),2);    %表示1辆车对1#中梁和2#中梁的效应

for ii=1:size(procData,1)
    vehicleLoad=zeros(span*10+1,span*10+1);
    vehicleLoad(1,1)=procData(ii,LWheel_1_W_Column)+procData(ii,RWheel_1_W_Column);
    vehicleLoad(1,1+round(procData(ii,AxleDis_Column)/100))=procData(ii,LWheel_1_W_Column+1)+procData(ii,RWheel_1_W_Column+1);
    
    if procData(ii,Axle_Num_Column)>=3    %防止后续变量被覆盖，下同
        vehicleLoad(1,1+round(procData(ii,AxleDis_Column)/100)+round(procData(ii,AxleDis_Column+1)/100)+round(procData(ii,AxleDis_Column+2)/100))=procData(ii,LWheel_1_W_Column+2)+procData(ii,RWheel_1_W_Column+2);
    end
    if procData(ii,Axle_Num_Column)>=4
        vehicleLoad(1,1+round(procData(ii,AxleDis_Column)/100)+round(procData(ii,AxleDis_Column+1)/100)+round(procData(ii,AxleDis_Column+2)/100)+round(procData(ii,AxleDis_Column+3)/100))=procData(ii,LWheel_1_W_Column+3)+procData(ii,RWheel_1_W_Column+3);
    end
    if procData(ii,Axle_Num_Column)>=5
        vehicleLoad(1,1+round(procData(ii,AxleDis_Column)/100)+round(procData(ii,AxleDis_Column+1)/100)+round(procData(ii,AxleDis_Column+2)/100)+round(procData(ii,AxleDis_Column+3)/100)+round(procData(ii,AxleDis_Column+4)/100))=procData(ii,LWheel_1_W_Column+4)+procData(ii,RWheel_1_W_Column+4);
    end
    if procData(ii,Axle_Num_Column)>=6
        vehicleLoad(1,1+round(procData(ii,AxleDis_Column)/100)+round(procData(ii,AxleDis_Column+1)/100)+round(procData(ii,AxleDis_Column+2)/100)+round(procData(ii,AxleDis_Column+3)/100)+round(procData(ii,AxleDis_Column+4)/100)+round(procData(ii,AxleDis_Column+5)/100))=procData(ii,LWheel_1_W_Column+5)+procData(ii,RWheel_1_W_Column+5);
    end
    if procData(ii,Axle_Num_Column)>=7
        vehicleLoad(1,1+round(procData(ii,AxleDis_Column)/100)+round(procData(ii,AxleDis_Column+1)/100)+round(procData(ii,AxleDis_Column+2)/100)+round(procData(ii,AxleDis_Column+3)/100)+round(procData(ii,AxleDis_Column+4)/100)+round(procData(ii,AxleDis_Column+5)/100)+round(procData(ii,AxleDis_Column+6)/100))=procData(ii,LWheel_1_W_Column+6)+procData(ii,RWheel_1_W_Column+6);
    end
    if procData(ii,Axle_Num_Column)>=8
        vehicleLoad(1,1+round(procData(ii,AxleDis_Column)/100)+round(procData(ii,AxleDis_Column+1)/100)+round(procData(ii,AxleDis_Column+2)/100)+round(procData(ii,AxleDis_Column+3)/100)+round(procData(ii,AxleDis_Column+4)/100)+round(procData(ii,AxleDis_Column+5)/100)+round(procData(ii,AxleDis_Column+6)/100)+round(procData(ii,AxleDis_Column+7)/100))=procData(ii,LWheel_1_W_Column+7)+procData(ii,RWheel_1_W_Column+7);
    end
    
    for jj=2:span*10+1
        vehicleLoad(jj,1:jj-1)=0;
        vehicleLoad(jj,jj:span*10+1)=vehicleLoad(1,1:span*10+1-jj+1);
    end
    vehicleLoadEffect(ii,:)=max(vehicleLoad*influenceLine);
end

procData=[procData vehicleLoadEffect/100];    %数据拼接，并且将最后2列的弯矩单位改成KN*m
temp=procData(:,1);    %基于时间数据进行聚类

div=4;
temp=procData(1:length(procData)/div,:);

D=pdist(temp,'euclid');
LinkD = linkage(D);      %联结稳定点
c = cophenet(LinkD,D);   %查看聚类效果

%figure;
%[H,T] =dendrogram(LinkD,'colorthreshold','default');      %查看谱系图

idx = cluster(LinkD,'cutoff',cutoffValue,'criterion','distance');

maxC=max(idx);    %最大聚类数
bendingMoment=zeros(1,maxC);
for ii=1:maxC    %对每个聚类结果进行处理
    cdata=procData(idx==ii,:);    %cdata:每个聚类结果
    
    if size(cdata,1)==1    %如果只有1辆车
        if cdata(1,Lane_Id_Column)==1
            bendingMoment(ii)=cdata(1,end-1);
        else
            bendingMoment(ii)=cdata(1,end-2);
        end
        
    else    %如果>=2辆车
        if sum(cdata(:,Lane_Id_Column)==1)==0    %如果没有车道1的车
            bendingMoment(ii)=max(cdata(:,end));
        elseif sum(cdata(:,Lane_Id_Column)==2)==0    %如果没有车道2的车
            bendingMoment(ii)=max(cdata(:,end-1));
        else   %两个车道的车都有，各取相应车道1辆效应最大的车的效应叠加
            l1=cdata;l2=cdata;
            l1(l1(:,Lane_Id_Column)==2,:)=[];
            l2(l2(:,Lane_Id_Column)==1,:)=[];
            
            bendingMoment(ii)=max(l1(:,end-1))+max(l2(:,end));
        end
    end
end

bendingMoment=bendingMoment*(1+u);
toc;



