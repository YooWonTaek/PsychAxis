function answer=getScalePara(filename,str)
fid=fopen(filename,'r');
temp=textscan(fid,'%s','Delimiter','=');
temp=temp{1};
answer='';
for i=1:length(temp)
    if strcmpi(strtrim(temp{i}),strtrim(str))
        answer=temp{i+1};
        break;
    end
end
fclose(fid);
if isempty(answer)
    sca;
    error(['�ļ���' filename '��û���ҵ�[' str ']�������Ϣ�����飡']);
end
