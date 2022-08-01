%Name:TimeRating
%Author:LIU Yuanze
%E-mail:liuyuanze@mail.bnu.edu.cn
%2019-08-10
%Introduction:To test if the tense feature in English and Chinese would
%affect the users' temporal psychological distance in both future and past
%orientation, and in both far and near scale.
%Tips: An Image Resolusion of 1680*1050 is recommended for better display.

%%
clc;    % 清除命令窗口内容
AssertOpenGL;   % PTB使用OpenGL绘图，此处检测是否支持OpenGL，若不支持则退出
Screen('Preference','SkipSyncTests', 1);  % 去掉自动检测
KbName('UnifyKeyNames'); % 统一不同操作系统下的按键标号
%%
%获取被试信息
subinfo=getSubInfo;       
if isempty(subinfo)
    return
end
%读入被试的编号和实验次序
nmb=str2double(char(subinfo(1)));
nt=str2double(char(subinfo(5)));
%%
try
    %%
    switch nmb %根据被试编号和实验次数确定后续实验材料语言，体现被试间平衡
    case {0,4,6,2}
        if nt==1
            language=1;%1为中文
        else
            language=2;%2为英文
        end
    case {3,7,5,1}
        if nt==1
            language=2;
        else
            language=1;
        end
    end
%%
scr=max(Screen('Screens'));
[wptr, wrect]=Screen('OpenWindow',scr,255);
    if language==1%选择指导语语言类型
        HideCursor; 
%         wptr=Screen('OpenWindow',0);
        imageInstruct(wptr,'intro','png',7,language);
        ShowCursor;
        Rating(wptr,nmb,nt,language);
        questionnaire(nmb,wptr,wrect,language);
    elseif language==2
        HideCursor; 
%         wptr=Screen('OpenWindow',0);
        imageInstruct(wptr,'introE','png',7,language);
        ShowCursor;
        Rating(wptr,nmb,nt,language);
        questionnaire(nmb,wptr,wrect,language);
    end
%%
resultFoldername='Data/Subinfo';
if ~exist(resultFoldername)
   mkdir(resultFoldername);
end
resultname=sprintf('%s/Subject%03d.mat',resultFoldername,nmb);
save(resultname,'subinfo');
%%
catch  % try中的程序执行出错后执行以下语句
    sca; 
    ShowCursor; 
    fclose('all'); 
    Priority(0); % 恢复一般优先级
    psychrethrow(psychlasterror); % 显示出错信息
end % try ... catch 
