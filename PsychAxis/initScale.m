function scale=initScale(filename)
clear scale;
scale.testname=getScalePara(filename,'testname');
scale.instruction1=getScalePara(filename,'instruction1');
scale.instruction2=getScalePara(filename,'instruction2');
% personalinfo=textscan(getScalePara(filename,'personalinfo'),'%s','Delimiter','|');
% personalinfo=personalinfo{1};
% for i=1:length(personalinfo)
%     temp=textscan(getScalePara(filename,personalinfo{i}),'%s','Delimiter','|');
%     temp=temp{1};
%     if str2double(temp{1})+4>length(temp)
%         error(['个人信息【' personalinfo{i} '】参数设置错误']);
%         return;
%     end
%     scale.personalinfo(i).name=personalinfo{i};
%     scale.personalinfo(i).dir=str2double(temp{3});
%     scale.personalinfo(i).stem=temp{4};
%     
%     for j=1:str2double(temp{1})
%         scale.personalinfo(i).option{j}=temp{j+4};
%     end
%     scale.personalinfo(i).value=zeros(1,j);
%     scale.personalinfo(i).type=str2double(temp{2});
% end
scale.items1=getScalePara(filename,'items1');
for i=1:str2double(scale.items1)
    temp=textscan(getScalePara(filename,['T' num2str(i)]),'%s','Delimiter','|');
    temp=temp{1};
    if str2double(temp{1})+4>length(temp)
        error(['第' num2str(i) '题参数设置错误']);
        return;
    end
    
    scale.item(i).stem=temp{4};%问卷题项共有4个参数
    for j=1:str2double(temp{1})%参数1决定了选项数目
        scale.item(i).option{j}=temp{j+4};
    end
    scale.item(i).value=zeros(1,j);
    scale.item(i).type=str2double(temp{2});%参数2决定题目类型为单选题或多选题
    scale.item(i).dir=str2double(temp{3});
end

scale.items2=getScalePara(filename,'items2');
for i=(str2double(scale.items1)+1):(str2double(scale.items1)+str2double(scale.items2))
    temp=textscan(getScalePara(filename,['T' num2str(i)]),'%s','Delimiter','|');
    temp=temp{1};
    if str2double(temp{1})+4>length(temp)%选项数目参数+题干参数（4）不得大于总参数数目，否则报错
        error(['第' num2str(i) '题参数设置错误']);
        return;
    end
    
    scale.item(i).stem=temp{4};%题干参数是前4个参数
    for j=1:str2double(temp{1})%第一个参数的数目是选项数目参数
        scale.item(i).option{j}=temp{j+4};
    end
    scale.item(i).value=zeros(1,j);
    scale.item(i).type=str2double(temp{2});
    scale.item(i).dir=str2double(temp{3});
end