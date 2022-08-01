%%
function dstc = Rating(wptr,nmb,nt,language)
if nargin<2
    warndlg('Rating�������ò������㣡','Waring');
    dstc=-1;
    return;
end
%%
% clc;    % ������������
% AssertOpenGL;   % PTBʹ��OpenGL��ͼ���˴�����Ƿ�֧��OpenGL������֧�����˳�
% Screen('Preference','SkipSyncTests', 1);  % ȥ���Զ����
% KbName('UnifyKeyNames'); % ͳһ��ͬ����ϵͳ�µİ������
%%
scl=cell(1,2);%ʵ�����õ��������ᣬ��Ϊ��ȥ��δ������
tmpnt=cell(1,2);%ʵ�����õ���ʱ�����ϣ���Ϊ��ȥ��δ������
block=1;%ʵ���block��
global result;
dataFoldername='Data';
if ~exist(dataFoldername)
    mkdir(dataFoldername);
end
%ȷ��ÿ������ÿ��ʵ����ϵĳ���˳��sqncΪһ��(10,10)����,ÿһ�д���һ��˳
%��ÿ2��Ϊһ��block,��5��block
%����ʵ����ϵĳ���˳���ڱ��Ե�����ʵ���Ӧ�ñ���һ�£�����Ҫ�����һ��ʵ��
%�е����˳��(������RatingSequence�ļ���)���ڶ���ʵ��ʹ��
sqncpl={Shuffle(repmat([1:10]',1,2*block)),Shuffle(repmat([1:10]',1,2*block))};
sequenceFoldername=sprintf('%s/%s',dataFoldername,'RatingSequence');
if ~exist(sequenceFoldername)
   mkdir(sequenceFoldername);
end
sqncname=sprintf('%s/sqnc%03d.xls',sequenceFoldername,nmb);

if nt==1%����ǵ�һ��ʵ�飬��������������˳����󹩵ڶ���ʵ��ʹ��
    sqnc=sqncpl;
    xlswrite(sqncname,sqnc{1},1);
    xlswrite(sqncname,sqnc{2},2);
else
    sqnc{1}=xlsread(sqncname,1);
    sqnc{2}=xlsread(sqncname,2);
end

%%
%try 
%2����(��/Ӣ)*2ʱ��߶�(��/��)*2����(��ȥ/δ��)���ʵ����ƣ��������Ժ�ʱ��
%����Ϊ�����ڱ�����switch...case����ȷ��ʵ����Ϸ���
      switch rem(nmb,8) 
          case 0
              if nt==1
               [~,txt]=xlsread('mtrl.xlsx','c1:c20');
               tmpnt{1}=txt(11:20,:);
               tmpnt{2}=txt(1:10,:);
               scl{1}=imread('mtrl1.png');
               scl{2}=imread('mtrl2.png');
               txt=double('��->��ǰ��ҳ');              
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
               txt=double('��->��ǰ��ҳ');  
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
               txt=double('��->��ǰ��ҳ');  
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
               txt=double('��->��ǰ��ҳ'); 
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
               txt=double('��->��ǰ��ҳ');  
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
               txt=double('��->��ǰ��ҳ');  
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
               txt=double('��->��ǰ��ҳ');  
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
               txt=double('��->��ǰ��ҳ');  
              end
      end
 %%     
Trial=1; 
jj=rem(Trial,2)+1;%ȡ1��2���������������������Դμ��ת��
ii=sqnc{jj}(Trial);
% wptr=Screen('OpenWindow',0);
wrect=Screen('Rect',wptr);
Screen('TextFont',wptr, 'KaiTi');
Screen('TextSize',wptr, 50);
%[xx,yy]=WindowCenter(wptr);
diadot=20;%ʱ���ֱ��
diarect=[0 0 diadot diadot];
fixrect = CenterRect(diarect, wrect)+[0 40 0 40];%ʹʱ�������ʱ������
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
    [~,secs,keyCode]=KbCheck;    % ��ȡ��ǰ����״̬
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
%��¼��Ӧʱ�������Ƿ�Ӧ�����ֵ�ʱ�����ϼ�ʱ����ƶ����λ��
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
   end %while ͨ�����������Դ�
%%
%��Ratingdata�ļ����н���Result�ļ��д��Ž���ļ�
resultFoldername='Data/Result/Rating';
if ~exist(resultFoldername)
   mkdir(resultFoldername);
end
resultname=sprintf('%s/Subject%03d.mat',resultFoldername,nmb);
save(resultname,'result');
%%
if language==1
        HideCursor; % �������
%         wptr=Screen('OpenWindow',0);
        imageInstruct(wptr,'ques','png',1,1);    
    elseif language==2
        HideCursor; % �������
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
%     Priority(0); % �ָ�һ�����ȼ�
%     psychrethrow(psychlasterror); % ��ʾ������Ϣ
end 