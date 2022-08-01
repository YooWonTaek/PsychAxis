%%
function questionnaire(nmb,wptr,wrect,language)
%根据语言参数选择问卷语言
switch language
    case 2
        filename=fullfile('TimeRating', 'TPENG.txt');         
    case 1
        filename=fullfile('TimeRating', 'TPCN.txt'); 
end
%%
%设置偏好参数
Screen('Preference', 'TextRenderer', 1);
Screen('Preference', 'TextAntiAliasing', 1);
%%
% scr=max(Screen('Screens'));
% [wptr wrect]=Screen('OpenWindow',scr,255);
if language==1
    %%
    Screen('TextSize',wptr, 40);
    Screen('TextStyle', wptr, 1);
    Screen('TextFont',wptr, 'Kai Ti');
    DrawFormattedText(wptr,double(getScalePara(filename,'testname')),'center',15,0);
    DrawFormattedText(wptr,double(getScalePara(filename,'instruction1')),'center',80,0);
    DrawFormattedText(wptr,double('点击鼠标继续'),'center',wrect(4)-100,[0,255,0]);
    Screen('Flip',wptr);
    ShowCursor(0);
    GetClicks;
    %%
    scale=initScale(filename);
    totalitems=str2double(scale.items1)+str2double(scale.items2);
    %%
    curindex=1;
    while true
        if curindex<=str2double(scale.items1)
            if curindex==1
                [value,stime,which]=getChoice1(wptr,scale.item(curindex),true,false,1);
            elseif curindex==str2double(scale.items1);%在问卷第一部分最后一题呈现完毕后，呈现第二部分指导语
                [value,stime,which]=getChoice1(wptr,scale.item(curindex),false,false,1);
                DrawFormattedText(wptr,double(getScalePara(filename,'instruction2')),'center',80,0);
                DrawFormattedText(wptr,double('点击鼠标继续'),'center',wrect(4)-100,[0,255,0]);
                Screen('Flip',wptr);
                GetClicks;
            else
                [value,stime,which]=getChoice1(wptr,scale.item(curindex),false,false,1);
            end
            scale.item(curindex).value=value;
            scale.item(curindex).time=stime;    
        else
            if curindex==totalitems
                [value,stime,which]=getChoice1(wptr,scale.item(curindex),false,true,1);
            else
                [value,stime,which]=getChoice1(wptr,scale.item(curindex),false,false,1);
            end
            scale.item(curindex).value=value;
            scale.item(curindex).time=stime;
        end
        if which==1
            curindex=curindex-1;
        elseif which==2
            curindex=curindex+1;
        elseif which==3
            break;
        end
    end
    DrawFormattedText(wptr,double('本次实验至此全部结束，谢谢您的参与！请联系主试。'),'center','center',0);

    %GetEchoString(wptr,'How',10,10);
    DrawFormattedText(wptr,double('点击鼠标退出'),'center',wrect(4)-100,[0,255,0]);
    Screen('Flip',wptr);
    GetClicks;
    sca
    

%%
elseif language==2
    %%
    Screen('TextSize',wptr, 40);
    Screen('TextStyle', wptr, 1);
    Screen('TextFont',wptr, 'Microsoft YaHei');
    DrawFormattedText(wptr,double(getScalePara(filename,'testname')),'center',15,0);
    DrawFormattedText(wptr,double(getScalePara(filename,'instruction1')),'center',80,0);
    DrawFormattedText(wptr,'click mouse to continue','center',wrect(4)-100,[0,0,255]);
    Screen('Flip',wptr);
    ShowCursor(0);
    GetClicks;
    %%
    scale=initScale(filename);
    totalitems=str2double(scale.items1)+str2double(scale.items2);
    %%
    curindex=1;
    while true
        if curindex<=str2double(scale.items1)
            if curindex==1
                [value,stime,which]=getChoice1(wptr,scale.item(curindex),true,false,2);
            elseif curindex==str2double(scale.items1);
                [value,stime,which]=getChoice1(wptr,scale.item(curindex),false,false,2);
                DrawFormattedText(wptr,double(getScalePara(filename,'instruction2')),'center',80,0);
                DrawFormattedText(wptr,'click mouse to continue','center',wrect(4)-100,[0,0,255]);
                Screen('Flip',wptr);
                GetClicks;
            else
                [value,stime,which]=getChoice1(wptr,scale.item(curindex),false,false,2);
            end
            scale.item(curindex).value=value;
            scale.item(curindex).time=stime;    
        else
            if curindex==totalitems
                [value,stime,which]=getChoice1(wptr,scale.item(curindex),false,true,2);
            else
                [value,stime,which]=getChoice1(wptr,scale.item(curindex),false,false,2);
            end
            scale.item(curindex).value=value;
            scale.item(curindex).time=stime;
        end
        if which==1
            curindex=curindex-1;
        elseif which==2
            curindex=curindex+1;
        elseif which==3
            break;
        end
    end
    % Screen('FrameRect',wptr,255,GrowRect(wrect,-10,-10),3);
    DrawFormattedText(wptr,'The experiment is over, thanks for your attending, \n please contact with our assistant.','center','center',0);

    %GetEchoString(wptr,'How',10,10);
    DrawFormattedText(wptr,'click mouse to exit','center',wrect(4)-100,[0,0,255]);
    Screen('Flip',wptr);
    GetClicks;
    sca
end
  %%
    resultFoldername='Data/Result/Questionnaire';
    if ~exist(resultFoldername)
      mkdir(resultFoldername);
    end
    resultname1=sprintf('%s/Subject%03dOrder.txt',resultFoldername,nmb);
    if exist(resultname1,'file')
        fileexist=true;
    else
        fileexist=false;
    end
    fid=fopen(resultname1,'a');
    if ~fileexist
        for i=1:str2double(scale.items1)
            fprintf(fid,'%s\t',['T' num2str(i)]);
        end
        for i=(str2double(scale.items1)+1):str2double(scale.items1)+str2double(scale.items2)
            fprintf(fid,'%s\t',['T' num2str(i)]);
        end
        fprintf(fid,'\n');
    end

    for i=1:length(scale.item)
        if scale.item(i).type==1%单选题
            fprintf(fid,'%d\t',find(scale.item(i).value==1));
        elseif scale.item(i).type==2%复选题
            temp=find(scale.item(i).value==1);
            str='';
            for j=1:length(temp)
                str=[str num2str(temp(j)) ','];
            end
            str=str(1:end-1);
            fprintf(fid,'%s\t',str);
        end
    end
    fprintf(fid,'\n');
    fclose(fid);
   %%
    resultFoldername='Data/Result/Questionnaire';
    if ~exist(resultFoldername)
      mkdir(resultFoldername);
    end
    resultname2=sprintf('%s/Subject%03dOption.txt',resultFoldername,nmb);
    if exist(resultname2,'file')
        fileexist=true;
    else
        fileexist=false;
    end
    fid=fopen(resultname2,'a');
    if ~fileexist
        for i=1:str2double(scale.items1)
            fprintf(fid,'%s\t',['T' num2str(i)]);
        end
        for  i=(str2double(scale.items1)+1):str2double(scale.items1)+str2double(scale.items2)
            fprintf(fid,'%s\t',['T' num2str(i)]);
        end
        fprintf(fid,'\n');
    end

    for i=1:length(scale.item)
        if scale.item(i).type==1
            fprintf(fid,'%s\t',scale.item(i).option{scale.item(i).value==1});
        elseif scale.item(i).type==2
            temp=find(scale.item(i).value==1);
            str='';
            for j=1:length(temp)
                str=[str scale.item(i).option{j} ','];
            end
            str=str(1:end-1);
            fprintf(fid,'%s\t',str);
        end
    end
    fprintf(fid,'\n');
    fclose(fid);
    %%
    resultFoldername='Data/Result/Questionnaire';
    if ~exist(resultFoldername)
      mkdir(resultFoldername);
    end
    resultname3=sprintf('%s/Subject%03dTime.txt',resultFoldername,nmb);
    if exist(resultname3,'file')
        fileexist=true;
    else
        fileexist=false;
    end
    fid=fopen(resultname3,'a');
    if ~fileexist

        for i=1:str2double(scale.items1)
            fprintf(fid,'%s\t',['T' num2str(i)]);
        end
        for  i=(str2double(scale.items1)+1):str2double(scale.items1)+str2double(scale.items2)
            fprintf(fid,'%s\t',['T' num2str(i)]);
        end
        fprintf(fid,'\n');
    end

    for i=1:length(scale.item)
        fprintf(fid,'%6.2f\t',scale.item(i).time);
    end
    fprintf(fid,'\n');
    fclose(fid);
    return;
clear;
leftarrow=imread('leftarrow.png');
rightarrow=imread('rightarrow.png');
checkbox0=imread('checkbox0.png');
checkbox1=imread('checkbox1.png');
radiobutton0=imread('radiobutton0.png');
radiobutton1=imread('radiobutton1.png');
savebutton=imread('save.png');
save buttons

