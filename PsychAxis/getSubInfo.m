function subinfo=getSubInfo()
prompt = {'���(Number)','����(Name)','�Ա�(Gender)[1=��(Male), 2=Ů(Female)]',...
    '����(Age)','ʵ�����(Number of Times)[1=��һ��(First time), 2=�ڶ���(Second time)]'};
dlg_title = '������Ϣ(Subinfo)';
num_lines = 1;
defautanswer = {'1','','1','20','1'};
subinfo=inputdlg(prompt,dlg_title,num_lines,defautanswer);
sx=str2double(char(subinfo(3)));
nt=str2double(char(subinfo(5)));
while sx~= 1 && sx~=2
    wrn1=warndlg('�Ա�ѡ��ֻ��Ϊ1��2','Warning');
    WaitSecs(2);
    close(wrn1);
    subinfo = inputdlg(prompt,dlg_title,num_lines,defautanswer);
    while nt~=1 && nt~=2
    wrn2=warndlg('ʵ�����ֻ��Ϊ1��2','Warning');
    WaitSecs(2);
    close(wrn2);
    subinfo = inputdlg(prompt,dlg_title,num_lines,defautanswer);
    return
    end
end
