inputX=[1 7 13 19];
inputY=[16 20 99 -12];

%TODO：inputX和inputY维数校核
%TODO：校核inputX是不是都为整数
%TODO：校核inputX是不是严格单调增
outputX=zeros(1,inputX(1,end));
outputY=zeros(1,inputX(1,end));

for i=1:size(inputX,2)
    outputY(inputX(i))=inputY(i);
end