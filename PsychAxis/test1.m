function ret=test1(wptr,i) 
    global t x result;
    fixation = imread('F:\eprime\�ҵ�ʵ��\experiment2\cross.bmp');
    blank = imread('F:\eprime\�ҵ�ʵ��\experiment2\blank.bmp');            %��ȡע�ӵ�Ϳհ�ͼƬ

    

    result(i,1).contrast = x;       %���浱ǰʵ��ĶԱȶ�
    
    KbName('UnifyKeyNames');    %���尴��ǰ��ö�������һ��
    leftKey=KbName('2');        %ĳ������°�1,���������2���������3
    rightKey=KbName('1');
    uncertainKey = KbName('3');
    tex = Screen('MakeTexture',wptr,fixation);      %��ʾע�ӵ�
    Screen('DrawTexture',wptr,tex,[]);
    Screen('Flip', wptr);
    WaitSecs(0.3);                                    %ע�ӵ���ʾ��ʱ��
    p=randperm(2);                                   %������ɲ�ͬ˳���1��2�����ں�������չʾ��ֱ��ˮƽ�Ĺ�դ
    if p(1)==1                                       %������p��һ��Ϊ1ʱ�ͳ���ĳ���̼�
        temp =;
        stimulus = imread(temp);                      %��ͼƬ������
        tex = Screen('MakeTexture',wptr,stimulus);    %չʾ�̼�
        Screen('DrawTexture',wptr,tex,[]);
        Screen('Flip', wptr);
        WaitSecs(0.016);                                  %�̼�����ʱ��
    end
    if p(1)==2                                        %��Ϊ2ʱ�;ͳ��������
        temp = ;
        stimulus = imread(temp);
        tex = Screen('MakeTexture',wptr,stimulus);
        Screen('DrawTexture',wptr,tex,[]);
        Screen('Flip', wptr);
        WaitSecs(0.016);
    end

        tex = Screen('MakeTexture',wptr,blank);      %չʾ�հף����ȴ����Է���
        Screen('DrawTexture',wptr,tex,[]);
        Screen('Flip', wptr);
        startTime = GetSecs;                    %��ȡ�̼���ʧ���ʱ��
        while true
            [~,~,keycode]=KbCheck;
            endTime = GetSecs;                  %��ȡ���Է�Ӧ���ʱ��
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
        reactionTime = endTime - startTime;           %��Ӧʱ
        ret = x;
        result(i,1).correct = correct;               %���浱ǰʵ�����ȷ���
        result(i,1).reactionTime = reactionTime;     %���淴Ӧʱ
   end
