classdef DataBasePara<handle
    %DATABASEPARA 此处显示有关此类的摘要
    %   数据库参数

    properties(Access=public)
        Property1
    end
    
    methods(Access=public)
        function obj = DataBasePara()
            %DATABASEPARA 构造此类的实例
            %   此处显示详细说明
        end
        
        function outputArg = method1(obj,inputArg)
            %METHOD1 此处显示有关此方法的摘要
            %   此处显示详细说明
            outputArg = obj.Property1 + inputArg;
        end
    end
end

