function output = MapXY(inputX,inputY)
%MAPXY ��totalX��totalY����ӳ��
%   totalX��totalY����
outputX=zeros(1,inputX(1,end));
%outputY=zeros(1,inputX(1,end));
inputX(1)=1;
outputY=zeros(1,max(inputX));
for i=1:size(inputX,2)
    try % ����ִ�е����
         outputY(inputX(i))=inputY(i);
    catch e % ���E���д��� % ִ��catch��end֮��Ĵ���� 
        disp(e);  
        disp(i);
    end

end

output=outputY;
end

