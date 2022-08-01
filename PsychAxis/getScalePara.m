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
    error(['文件：' filename '中没有找到[' str ']的相关信息，请检查！']);
end
