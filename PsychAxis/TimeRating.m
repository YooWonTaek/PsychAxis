%Name:TimeRating
%Author:LIU Yuanze
%E-mail:liuyuanze@mail.bnu.edu.cn
%2019-08-10
%Introduction:To test if the tense feature in English and Chinese would
%affect the users' temporal psychological distance in both future and past
%orientation, and in both far and near scale.
%Tips: An Image Resolusion of 1680*1050 is recommended for better display.

%%
clc;    % ������������
AssertOpenGL;   % PTBʹ��OpenGL��ͼ���˴�����Ƿ�֧��OpenGL������֧�����˳�
Screen('Preference','SkipSyncTests', 1);  % ȥ���Զ����
KbName('UnifyKeyNames'); % ͳһ��ͬ����ϵͳ�µİ������
%%
%��ȡ������Ϣ
subinfo=getSubInfo;       
if isempty(subinfo)
    return
end
%���뱻�Եı�ź�ʵ�����
nmb=str2double(char(subinfo(1)));
nt=str2double(char(subinfo(5)));
%%
try
    %%
    switch nmb %���ݱ��Ա�ź�ʵ�����ȷ������ʵ��������ԣ����ֱ��Լ�ƽ��
    case {0,4,6,2}
        if nt==1
            language=1;%1Ϊ����
        else
            language=2;%2ΪӢ��
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
    if language==1%ѡ��ָ������������
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
catch  % try�еĳ���ִ�г����ִ���������
    sca; 
    ShowCursor; 
    fclose('all'); 
    Priority(0); % �ָ�һ�����ȼ�
    psychrethrow(psychlasterror); % ��ʾ������Ϣ
end % try ... catch 
