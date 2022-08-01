%%
function dstc = Rating(wptr,nmb,nt,language)
if nargin<2
    warndlg('Rating函数调用参数不足！','Waring');
    dstc=-1;
    return;
end
%%
% clc;    % 清除命令窗口内容
% AssertOpenGL;   % PTB使用OpenGL绘图，此处检测是否支持OpenGL，若不支持则退出
% Screen('Preference','SkipSyncTests', 1);  % 去掉自动检测
% KbName('UnifyKeyNames'); % 统一不同操作系统下的按键标号
%%
scl=cell(1,2);%实验中用到的坐标轴，分为过去和未来两类
tmpnt=cell(1,2);%实验中用到的时间点材料，分为过去和未来两类
block=1;%实验的block数
global result;
dataFoldername='Data';
if ~exist(dataFoldername)
    mkdir(dataFoldername);
end
%确定每个被试每次实验材料的呈现顺序，sqnc为一个(10,10)矩阵,每一列代表一个顺
%序，每2列为一个block,共5个block
%由于实验材料的呈现顺序在被试的两次实验间应该保持一致，故需要保存第一次实验
%中的随机顺序(保存在RatingSequence文件中)供第二次实验使用
sqncpl={Shuffle(repmat([1:10]',1,2*block)),Shuffle(repmat([1:10]',1,2*block))};
sequenceFoldername=sprintf('%s/%s',dataFoldername,'RatingSequence');
if ~exist(sequenceFoldername)
   mkdir(sequenceFoldername);
end
sqncname=sprintf('%s/sqnc%03d.xls',sequenceFoldername,nmb);

if nt==1%如果是第一次实验，则建立并保存此随机顺序矩阵供第二次实验使用
    sqnc=sqncpl;
    xlswrite(sqncname,sqnc{1},1);
    xlswrite(sqncname,sqnc{2},2);
else
    sqnc{1}=xlsread(sqncname,1);
    sqnc{2}=xlsread(sqncname,2);
end

%%
%try 
%2语言(中/英)*2时间尺度(长/短)*2方向(过去/未来)混合实验设计，其中语言和时间
%方向为被试内变量，switch...case用于确定实验材料分配
      switch rem(nmb,8) 
          case 0
              if nt==1
               [~,txt]=xlsread('mtrl.xlsx','c1:c20');
               tmpnt{1}=txt(11:20,:);
               tmpnt{2}=txt(1:10,:);
               scl{1}=imread('mtrl1.png');
               scl{2}=imread('mtrl2.png');
               txt=double('按->向前翻页');              
              else
               [~,txt]=xlsread('mtrl.xlsx','e1:e20'); 
               tmpnt{1}=txt(11:20,:);
               tmpnt{2}=txt(1:10,:);
               scl{1}=imread('mtrl3.png');
               scl{2}=imread('mtrl4.png');
               txt=double('press -> to continue'); 
              end
           case 4
              if nt==1
               [~,txt]=xlsread('mtrl.xlsx','h1:h20');
               tmpnt{1}=txt(11:20,:);
               tmpnt{2}=txt(1:10,:);
               scl{1}=imread('mtrl2.png');
               scl{2}=imread('mtrl1.png');
               txt=double('按->向前翻页');  
              else
               [~,txt]=xlsread('mtrl.xlsx','j1:j20'); 
               tmpnt{1}=txt(11:20,:);
               tmpnt{2}=txt(1:10,:);
               scl{1}=imread('mtrl4.png');
               scl{2}=imread('mtrl3.png');
               txt=double('press -> to continue');
              end
          case 2
              if nt==1
               [~,txt]=xlsread('mtrl.xlsx','g1:g20'); 
               tmpnt{1}=txt(11:20,:);
               tmpnt{2}=txt(1:10,:);
               scl{1}=imread('mtrl2.png');
               scl{2}=imread('mtrl1.png');
               txt=double('按->向前翻页');  
              else
               [~,txt]=xlsread('mtrl.xlsx','i1:i20'); 
               tmpnt{1}=txt(11:20,:);
               tmpnt{2}=txt(1:10,:);
               scl{1}=imread('mtrl4.png');
               scl{2}=imread('mtrl3.png');
               txt=double('press -> to continue');
              end
          case 6
              if nt==1
               [~,txt]=xlsread('mtrl.xlsx','b1:b20'); 
               tmpnt{1}=txt(11:20,:);
               tmpnt{2}=txt(1:10,:);
               scl{1}=imread('mtrl2.png');
               scl{2}=imread('mtrl1.png');
               txt=double('按->向前翻页'); 
              else
               [~,txt]=xlsread('mtrl.xlsx','D1:D20'); 
               tmpnt{1}=txt(11:20,:);
               tmpnt{2}=txt(1:10,:);
               scl{1}=imread('mtrl3.png');
               scl{2}=imread('mtrl4.png');
               txt=double('press -> to continue'); 
              end
          case 7
              if nt==1
               [~,txt]=xlsread('mtrl.xlsx','j1:j20');
               tmpnt{1}=txt(11:20,:);
               tmpnt{2}=txt(1:10,:);
               scl{1}=imread('mtrl4.png');
               scl{2}=imread('mtrl3.png');
               txt=double('press -> to continue'); 
              else
               [~,txt]=xlsread('mtrl.xlsx','h1:h20');
               tmpnt{1}=txt(11:20,:);
               tmpnt{2}=txt(1:10,:);
               scl{1}=imread('mtrl2.png');
               scl{2}=imread('mtrl1.png');
               txt=double('按->向前翻页');  
              end
          case 3
              if nt==1
               [~,txt]=xlsread('mtrl.xlsx','e1:e20');
               tmpnt{1}=txt(11:20,:);
               tmpnt{2}=txt(1:10,:);
               scl{1}=imread('mtrl3.png');
               scl{2}=imread('mtrl4.png');
               txt=double('press -> to continue'); 
              else
               [~,txt]=xlsread('mtrl.xlsx','c1:c20');
               tmpnt{1}=txt(11:20,:);
               tmpnt{2}=txt(1:10,:);
               scl{1}=imread('mtrl1.png');
               scl{2}=imread('mtrl2.png');
               txt=double('按->向前翻页');  
              end
          case 1
              if nt==1
               [~,txt]=xlsread('mtrl.xlsx','i1:i20'); 
               tmpnt{1}=txt(11:20,:);
               tmpnt{2}=txt(1:10,:);
               scl{1}=imread('mtrl4.png');
               scl{2}=imread('mtrl3.png');
               txt=double('press -> to continue'); 
              else
               [~,txt]=xlsread('mtrl.xlsx','g1:g20'); 
               tmpnt{1}=txt(11:20,:);
               tmpnt{2}=txt(1:10,:);
               scl{1}=imread('mtrl2.png');
               scl{2}=imread('mtrl1.png');
               txt=double('按->向前翻页');  
              end
          case 5
              if nt==1
               [~,txt]=xlsread('mtrl.xlsx','D1:D20'); 
               tmpnt{1}=txt(11:20,:);
               tmpnt{2}=txt(1:10,:);
               scl{1}=imread('mtrl3.png');
               scl{2}=imread('mtrl4.png');
               txt=double('press -> to continue'); 
              else
               [~,txt]=xlsread('mtrl.xlsx','b1:b20'); 
               tmpnt{1}=txt(11:20,:);
               tmpnt{2}=txt(1:10,:);
               scl{1}=imread('mtrl1.png');
               scl{2}=imread('mtrl2.png');
               txt=double('按->向前翻页');  
              end
      end
 %%     
Trial=1; 
jj=rem(Trial,2)+1;%取1或2，用来控制语言类型在试次间的转换
ii=sqnc{jj}(Trial);
% wptr=Screen('OpenWindow',0);
wrect=Screen('Rect',wptr);
Screen('TextFont',wptr, 'KaiTi');
Screen('TextSize',wptr, 50);
%[xx,yy]=WindowCenter(wptr);
diadot=20;%时间点直径
diarect=[0 0 diadot diadot];
fixrect = CenterRect(diarect, wrect)+[0 40 0 40];%使时间点落在时间轴上
fixrect0=CenterRect(diarect, wrect)+[0 40 0 40];

trect0=Screen('TextBounds',wptr,txt);
x0= (wrect(3)-trect0(3))/2; y0= wrect(4)-trect0(4)-10;
Screen('PutImage',wptr,scl{jj});
Screen('DrawText',wptr,txt,x0 ,y0);
Screen('DrawText',wptr,double(tmpnt{jj}{ii}),200,200,0);
Screen('FillOval',wptr,[0 0 0],fixrect0);
Screen('Flip',wptr);
trialStart = GetSecs;
rightKey=KbName('RightArrow');
escapeKey=KbName('ESCAPE');
ListenChar(2);
   while true
    [~,secs,keyCode]=KbCheck;    % 提取当前按键状态
    [xMouse,~,buttons]=GetMouse(wptr);
        if buttons(1) 
           fixrect(1)=xMouse-diadot/2;
           fixrect(3)=xMouse+diadot/2;
           Screen('DrawText',wptr,txt,x0 ,y0);
           Screen('DrawText',wptr,double(tmpnt{jj}{ii}),200,200,0);
           Screen('PutImage',wptr,scl{jj}); 
           Screen('FillOval',wptr,[0 0 0],fixrect);
           Screen('Flip',wptr);       
        end
        if keyCode(rightKey) && Trial==20*block+1
            break
        elseif keyCode(escapeKey)
            break
        elseif (keyCode(rightKey)) && Trial<=20*block
            while KbCheck;end
%记录反应时、被试是否反应、呈现的时间点材料及时间点移动后的位置
            result(nmb).Order(nt).Subject(Trial).RT=secs-trialStart;   
            result(nmb).Order(nt).Subject(Trial).Responce=1;
            result(nmb).Order(nt).Subject(Trial).TimePoint=tmpnt{jj}{ii};
            result(nmb).Order(nt).Subject(Trial).X=xMouse;
            if Trial==20*block
                break
            else
            Trial=Trial+1;
            jj=rem(Trial,2)+1;
            ii=sqnc{jj}(Trial);
            Screen('DrawText',wptr,txt,x0 ,y0);
            Screen('DrawText',wptr,double(tmpnt{jj}{ii}),200,200,0);
            Screen('PutImage',wptr,scl{jj});
            Screen('FillOval',wptr,[0 0 0],fixrect0);
            Screen('Flip',wptr);
            end
        end
   end %while 通过按键递增试次
%%
%在Ratingdata文件夹中建立Result文件夹储放结果文件
resultFoldername='Data/Result/Rating';
if ~exist(resultFoldername)
   mkdir(resultFoldername);
end
resultname=sprintf('%s/Subject%03d.mat',resultFoldername,nmb);
save(resultname,'result');
%%
if language==1
        HideCursor; % 隐藏鼠标
%         wptr=Screen('OpenWindow',0);
        imageInstruct(wptr,'ques','png',1,1);    
    elseif language==2
        HideCursor; % 隐藏鼠标
%         wptr=Screen('OpenWindow',0);
        imageInstruct(wptr,'quesE','png',1,2);        
end
%%
while KbCheck; end
KbWait;
ListenChar(0);
clear imgs;
%sca;       

%catch % try...catch
%     sca; 
%     ShowCursor; 
%     fclose('all'); 
%     Priority(0); % 恢复一般优先级
%     psychrethrow(psychlasterror); % 显示出错信息
end 