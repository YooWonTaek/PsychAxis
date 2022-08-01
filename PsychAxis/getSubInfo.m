function subinfo=getSubInfo()
prompt = {'编号(Number)','姓名(Name)','性别(Gender)[1=男(Male), 2=女(Female)]',...
    '年龄(Age)','实验次序(Number of Times)[1=第一次(First time), 2=第二次(Second time)]'};
dlg_title = '被试信息(Subinfo)';
num_lines = 1;
defautanswer = {'1','','1','20','1'};
subinfo=inputdlg(prompt,dlg_title,num_lines,defautanswer);
sx=str2double(char(subinfo(3)));
nt=str2double(char(subinfo(5)));
while sx~= 1 && sx~=2
    wrn1=warndlg('性别选项只能为1或2','Warning');
    WaitSecs(2);
    close(wrn1);
    subinfo = inputdlg(prompt,dlg_title,num_lines,defautanswer);
    while nt~=1 && nt~=2
    wrn2=warndlg('实验次序只能为1或2','Warning');
    WaitSecs(2);
    close(wrn2);
    subinfo = inputdlg(prompt,dlg_title,num_lines,defautanswer);
    return
    end
end
