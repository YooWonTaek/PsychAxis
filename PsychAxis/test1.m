function ret=test1(wptr,i) 
    global t x result;
    fixation = imread('F:\eprime\我的实验\experiment2\cross.bmp');
    blank = imread('F:\eprime\我的实验\experiment2\blank.bmp');            %读取注视点和空白图片

    

    result(i,1).contrast = x;       %保存当前实验的对比度
    
    KbName('UnifyKeyNames');    %定义按键前最好都加上这一句
    leftKey=KbName('2');        %某种情况下按1,另外情况按2，不清楚按3
    rightKey=KbName('1');
    uncertainKey = KbName('3');
    tex = Screen('MakeTexture',wptr,fixation);      %显示注视点
    Screen('DrawTexture',wptr,tex,[]);
    Screen('Flip', wptr);
    WaitSecs(0.3);                                    %注视点显示的时长
    p=randperm(2);                                   %随机生成不同顺序的1和2，用于后面的随机展示垂直或水平的光栅
    if p(1)==1                                       %当数组p第一个为1时就呈现某个刺激
        temp =;
        stimulus = imread(temp);                      %把图片读进来
        tex = Screen('MakeTexture',wptr,stimulus);    %展示刺激
        Screen('DrawTexture',wptr,tex,[]);
        Screen('Flip', wptr);
        WaitSecs(0.016);                                  %刺激呈现时间
    end
    if p(1)==2                                        %当为2时就就呈现另外的
        temp = ;
        stimulus = imread(temp);
        tex = Screen('MakeTexture',wptr,stimulus);
        Screen('DrawTexture',wptr,tex,[]);
        Screen('Flip', wptr);
        WaitSecs(0.016);
    end

        tex = Screen('MakeTexture',wptr,blank);      %展示空白，并等待被试反馈
        Screen('DrawTexture',wptr,tex,[]);
        Screen('Flip', wptr);
        startTime = GetSecs;                    %获取刺激消失后的时间
        while true
            [~,~,keycode]=KbCheck;
            endTime = GetSecs;                  %获取被试反应后的时间
            if keycode(rightKey)
                break;
            end
            if keycode(leftKey)
                break;
            end
       if keycode(uncertainKey)
		      break;
        end
        KbWait;
        reactionTime = endTime - startTime;           %反应时
        ret = x;
        result(i,1).correct = correct;               %保存当前实验的正确与否
        result(i,1).reactionTime = reactionTime;     %保存反应时
   end
