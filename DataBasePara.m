classdef DataBasePara<handle
    %DATABASEPARA �˴���ʾ�йش����ժҪ
    %   ���ݿ����

    properties(Access=public)
        Property1
    end
    
    methods(Access=public)
        function obj = DataBasePara()
            %DATABASEPARA ��������ʵ��
            %   �˴���ʾ��ϸ˵��
        end
        
        function outputArg = method1(obj,inputArg)
            %METHOD1 �˴���ʾ�йش˷�����ժҪ
            %   �˴���ʾ��ϸ˵��
            outputArg = obj.Property1 + inputArg;
        end
    end
end

