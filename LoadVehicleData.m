function DataA = LoadVehicleData()
%LoadVehicleData 从Sql Server中HighSpeed_PROC数据库读取车辆数据
%   要求数据为智辰天驰的模型
tic;

datasource = 'HighSpeed_PROC'; %前面设置的数据源名称 
connA = database(datasource,'sa','jky123!'); %SQL Server的用户名和密码
cursorA=exec(connA,'SELECT HSData_DT, Axle_Num, Gross_Load, LWheel_1_W, LWheel_2_W, LWheel_3_W, LWheel_4_W,LWheel_5_W, LWheel_6_W, LWheel_7_W, LWheel_8_W, RWheel_1_W, RWheel_2_W, RWheel_3_W, RWheel_4_W, RWheel_5_W, RWheel_6_W, RWheel_7_W, RWheel_8_W, AxleDis1, AxleDis2, AxleDis3, AxleDis4, AxleDis5,AxleDis6, AxleDis7, Speed FROM HS_Data_PROC ORDER BY HSData_DT'); %数据库名称、表名称
RowLimit = 3000000*10; % RowLimit为每次读取的数据参数的行数，默认为全部读取 
cursA=fetch(cursorA,RowLimit); % 把数据库中的数据读取到Matlab中——fetch
 
%返回数据类型为元包（cell）型，默认为CELL型，要通过 cell2mat() 转换格式
DataA=cursA.Data; %把读取到的数据用变量Data保存.
 
%关闭连接
close(cursorA); 
close(connA);

toc;
end