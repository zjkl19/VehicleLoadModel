%大樟桥WIM车辆荷载模型数据处理算法
%桥梁概况：跨径3×28m，主梁混凝土：C60，桥面铺装混凝土：C40。该桥缺乏设计图纸，暂定公路-Ⅱ级作为设计荷载（参考20210301中小桥安全监测项目--结题报告）
%1、考虑到质量轻的车辆对桥梁内力影响较小，算法对小于3000kg（或其它质量）的车辆的数据进行剔除
%2、算法认为大樟桥跨径小，且经过长期观察，即使是重车，绝大多数车速也在30km/h以上，故认为不同车辆经过称重系统时间间隔较短时才认为是对桥梁同时进行作用。间隔时间暂定为3s
%对时间间隔≤3s的数据进行聚类（层次聚类）
%3、在每个聚类的结果中：
%3.1：如果只有1个元素（1辆车)，直接按最不利影响线加载
%3.2：如果有2个元素（2辆车）每个车道各取1辆最重车按最不利影响线加载（简化算法）
cutoffValue=3.0;
criGross_Load=3000;    %临界重量，小于等于该重量的数据将被剔除


DataA=LoadVehicleData();
temp=datenum(DataA(:,1))*24*3600;    %时间换算成秒
procData=[temp cell2mat(DataA(:,2:end))];
procData(procData(:,3)<=criGross_Load,:)=[];
temp=procData(:,1);    %基于时间数据进行聚类
D=pdist(temp,'euclid');
LinkD = linkage(D);      %联结稳定点
c = cophenet(LinkD,D);   %查看聚类效果

%figure;
%[H,T] =dendrogram(LinkD,'colorthreshold','default');      %查看谱系图

idx = cluster(LinkD,'cutoff',cutoffValue,'criterion','distance');