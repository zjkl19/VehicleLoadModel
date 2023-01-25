function output = MapXY(inputX,inputY)
%MAPXY 对totalX和totalY进行映射
%   totalX和totalY对齐
outputX=zeros(1,inputX(1,end));
%outputY=zeros(1,inputX(1,end));
inputX(1)=1;
outputY=zeros(1,max(inputX));
for i=1:size(inputX,2)
    try % 尝试执行的语句
         outputY(inputX(i))=inputY(i);
    catch e % 如果E运行错误， % 执行catch和end之间的代码块 
        disp(e);  
        disp(i);
    end

end

output=outputY;
end

