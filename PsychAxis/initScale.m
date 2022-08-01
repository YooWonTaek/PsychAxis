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
%         error(['������Ϣ��' personalinfo{i} '���������ô���']);
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
        error(['��' num2str(i) '��������ô���']);
        return;
    end
    
    scale.item(i).stem=temp{4};%�ʾ������4������
    for j=1:str2double(temp{1})%����1������ѡ����Ŀ
        scale.item(i).option{j}=temp{j+4};
    end
    scale.item(i).value=zeros(1,j);
    scale.item(i).type=str2double(temp{2});%����2������Ŀ����Ϊ��ѡ����ѡ��
    scale.item(i).dir=str2double(temp{3});
end

scale.items2=getScalePara(filename,'items2');
for i=(str2double(scale.items1)+1):(str2double(scale.items1)+str2double(scale.items2))
    temp=textscan(getScalePara(filename,['T' num2str(i)]),'%s','Delimiter','|');
    temp=temp{1};
    if str2double(temp{1})+4>length(temp)%ѡ����Ŀ����+��ɲ�����4�����ô����ܲ�����Ŀ�����򱨴�
        error(['��' num2str(i) '��������ô���']);
        return;
    end
    
    scale.item(i).stem=temp{4};%��ɲ�����ǰ4������
    for j=1:str2double(temp{1})%��һ����������Ŀ��ѡ����Ŀ����
        scale.item(i).option{j}=temp{j+4};
    end
    scale.item(i).value=zeros(1,j);
    scale.item(i).type=str2double(temp{2});
    scale.item(i).dir=str2double(temp{3});
end