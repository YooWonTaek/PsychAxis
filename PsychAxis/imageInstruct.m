%%
function ret=imageInstruct(wptr,prefix,postfix,fs,language)
if nargin<4
    warndlg('showInstruct函数调用参数不足！','Waring');
    ret=-1;
    return;
end
%%
for i=1:fs
    imgs(i).('img')=imread([prefix num2str(i) '.' postfix]);
end
%%
if language==1
    curImg=1;
    wrect=Screen('Rect',wptr);
    Screen('PutImage',wptr,imgs(curImg).img);
    Screen('TextSize',wptr, 25);
    Screen('TextStyle', wptr, 0);
    Screen('TextFont',wptr, 'KaiTi');

    trect1=Screen('TextBounds',wptr,double('按<-向后翻页'));
    trect2=Screen('TextBounds',wptr,double('按->向前翻页'));
    trect3=Screen('TextBounds',wptr,[num2str(curImg) '/' num2str(fs)]);

    x1=10; y1= wrect(4)-trect1(4)-10;
    x2= wrect(3)-trect2(3)-10; y2= wrect(4)-trect2(4)-10;
    x3= (wrect(3)-trect3(3))/2; y3= wrect(4)-trect3(4)-10;

    Screen('DrawText',wptr,double('按<-向后翻页'),x1,y1);
    Screen('DrawText',wptr,double('按->向前翻页'),x2 ,y2);
    Screen('DrawText',wptr,[num2str(curImg) '/' num2str(fs)],x3,y3);
    Screen('Flip',wptr);
    leftKey=KbName('LeftArrow');
    rightKey=KbName('RightArrow');
    spaceKey=KbName('space');
    ListenChar(2);
    while true
        [~,~,keyCode]=KbCheck;
        if keyCode(rightKey) && curImg==fs
            break;
        elseif keyCode(leftKey) && curImg>1
            while KbCheck;end
            curImg=curImg-1;
            Screen('PutImage',wptr,imgs(curImg).img);
            trect3=Screen('TextBounds',wptr,[num2str(curImg) '/' num2str(fs)]);
            x3= (wrect(3)-trect3(3))/2; y3= wrect(4)-trect3(4)-10;
            Screen('DrawText',wptr,double('按<-向后翻页'),x1,y1);
            Screen('DrawText',wptr,double('按->向前翻页'),x2 ,y2);
            Screen('DrawText',wptr,[num2str(curImg) '/' num2str(fs)],x3,y3);
            Screen('Flip',wptr);
        elseif (keyCode(rightKey)) && (curImg<fs &&curImg~=3)
            while KbCheck;end
            curImg=curImg+1;
            Screen('PutImage',wptr,imgs(curImg).img);
            trect3=Screen('TextBounds',wptr,[num2str(curImg) '/' num2str(fs)]);
            x3= (wrect(3)-trect3(3))/2; y3= wrect(4)-trect3(4)-10;
            Screen('DrawText',wptr,double('按<-向后翻页'),x1,y1);
            Screen('DrawText',wptr,double('按->向前翻页'),x2 ,y2);
            Screen('DrawText',wptr,[num2str(curImg) '/' num2str(fs)],x3,y3);
            Screen('Flip',wptr);
        elseif (keyCode(rightKey)) && curImg==3%第四张图片停留至少20s
            while KbCheck;end
            curImg=curImg+1;            
            nominalFrameRate = Screen('NominalFrameRate', wptr);
            presSecs = [sort(repmat(1:20, 1, nominalFrameRate), 'descend') 0];            
            trect3=Screen('TextBounds',wptr,[num2str(curImg) '/' num2str(fs)]);
            x3= (wrect(3)-trect3(3))/2; y3= wrect(4)-trect3(4)-10;                    
            for i = 1:length(presSecs)
                numberString = num2str(presSecs(i));
                Screen('PutImage',wptr,imgs(curImg).img);
                Screen('DrawText',wptr,numberString,wrect(3)-100, wrect(2)+40);
                Screen('DrawText',wptr,double('按<-向后翻页'),x1,y1);
                Screen('DrawText',wptr,double('按->向前翻页'),x2 ,y2);
                Screen('DrawText',wptr,[num2str(curImg) '/' num2str(fs)],x3,y3);
                Screen('Flip', wptr);
            end
        end        
    end
    while KbCheck; end
    KbWait;
    ListenChar(0);
%%
else
    curImg=1;
    wrect=Screen('Rect',wptr);
    Screen('PutImage',wptr,imgs(curImg).img);
    Screen('TextSize',wptr, 25);
    Screen('TextStyle', wptr, 0);
    Screen('TextFont',wptr, 'Microsoft YaHei');

    trect1=Screen('TextBounds',wptr,'press<- for last page');
    trect2=Screen('TextBounds',wptr,'press->for next page');
    trect3=Screen('TextBounds',wptr,[num2str(curImg) '/' num2str(fs)]);

    x1=10; y1= wrect(4)-trect1(4)-10;
    x2= wrect(3)-trect2(3)-10; y2= wrect(4)-trect2(4)-10;
    x3= (wrect(3)-trect3(3))/2; y3= wrect(4)-trect3(4)-10;

    Screen('DrawText',wptr,'press<- for last page',x1,y1);
    Screen('DrawText',wptr,'press-> for next page',x2 ,y2);
    Screen('DrawText',wptr,[num2str(curImg) '/' num2str(fs)],x3,y3);
    Screen('Flip',wptr);
    leftKey=KbName('LeftArrow');
    rightKey=KbName('RightArrow');
    spaceKey=KbName('space');
    ListenChar(2);
    while true
        [~,~,keyCode]=KbCheck;
        if keyCode(rightKey) && curImg==fs
            break;
        elseif keyCode(leftKey) && curImg>1
            while KbCheck;end
            curImg=curImg-1;
            Screen('PutImage',wptr,imgs(curImg).img);
            trect3=Screen('TextBounds',wptr,[num2str(curImg) '/' num2str(fs)]);
            x3= (wrect(3)-trect3(3))/2; y3= wrect(4)-trect3(4)-10;
            Screen('DrawText',wptr,'press<- for last page',x1,y1);
            Screen('DrawText',wptr,'press-> for next page',x2 ,y2);
            Screen('DrawText',wptr,[num2str(curImg) '/' num2str(fs)],x3,y3);
            Screen('Flip',wptr);
        elseif (keyCode(rightKey)) && (curImg<fs && curImg~=3)
            while KbCheck;end
            curImg=curImg+1;
            Screen('PutImage',wptr,imgs(curImg).img);
            trect3=Screen('TextBounds',wptr,[num2str(curImg) '/' num2str(fs)]);
            x3= (wrect(3)-trect3(3))/2; y3= wrect(4)-trect3(4)-10;
            Screen('DrawText',wptr,'press<- for last page',x1,y1);
            Screen('DrawText',wptr,'press-> for next page',x2 ,y2);
            Screen('DrawText',wptr,[num2str(curImg) '/' num2str(fs)],x3,y3);
            Screen('Flip',wptr);
        elseif (keyCode(rightKey)) && curImg==3
            while KbCheck;end
            curImg=curImg+1;            
            nominalFrameRate = Screen('NominalFrameRate', wptr);
            presSecs = [sort(repmat(1:20, 1, nominalFrameRate), 'descend') 0];            
            trect3=Screen('TextBounds',wptr,[num2str(curImg) '/' num2str(fs)]);
            x3= (wrect(3)-trect3(3))/2; y3= wrect(4)-trect3(4)-10;                    
            for i = 1:length(presSecs)
                numberString = num2str(presSecs(i));
                Screen('PutImage',wptr,imgs(curImg).img);
                Screen('DrawText',wptr,numberString,wrect(3)-100, wrect(2)+40);
                Screen('DrawText',wptr,double('press<- for last page'),x1,y1);
                Screen('DrawText',wptr,double('press-> for next page'),x2 ,y2);
                Screen('DrawText',wptr,[num2str(curImg) '/' num2str(fs)],x3,y3);
                Screen('Flip', wptr);
           end        
    end
while KbCheck; end
KbWait;
ListenChar(0);
end
%%
%clear imgs;
ret=0;
end

