function [value,stime,whichbutton]=getChoice1(wptr,item,first,last,language)
%getChoice1.m
%2011-6-17
%fengchengzhi@suda.edu.cn
if ~exist('buttons.mat','file')
    error('无法找到文件:buttons.mat');
end
if ~exist('rightarrow','var')
    load buttons
end
Screen('Preference', 'TextRenderer', 1);
Screen('Preference', 'TextAntiAliasing', 1);

wrect=Screen('Rect',wptr);
for i=1:length(item.option)%获取文字长度，用来布局文字
    rs(i,:)=Screen('TextBounds',wptr,double(item.option{i}));
end
maxw=max(rs(:,3));
maxh=max(rs(:,4));
if item.dir
    r1=[0 0 (maxw+maxh)*length(item.option) maxh];
else
    r1=[0 0 maxw+maxh maxh*length(item.option)];
end
r1=CenterRect(r1,wrect);
%r1=OffsetRect(r1,0,100);
rs=ArrangeRects(length(item.option),[0 0 maxw+maxh maxh],r1);
options=length(item.option);
%%
if language==1
    Screen('TextFont',wptr, 'Kai Ti');
        if first && last
            item.option{options+1}=double('提交问卷');
            rs(options+1,:)=[wrect(3)/2-90 wrect(4)-100 wrect(3)/2+90 wrect(4)-100+maxh];
        elseif first
            item.option{options+1}=double('下一项');
            rs(options+1,:)=[wrect(3)-200 wrect(4)-100 wrect(3)-20 wrect(4)-100+maxh];
        elseif last
            item.option{options+1}=double('前一项');
            item.option{options+2}=double('提交问卷');
            rs(options+1,:)=[20 wrect(4)-100 200 wrect(4)-100+maxh];
            rs(options+2,:)=[wrect(3)/2-90 wrect(4)-100 wrect(3)/2+90 wrect(4)-100+maxh];
        else    
            item.option{options+1}=double('前一项');
            item.option{options+2}=double('下一项');
            rs(options+1,:)=[20 wrect(4)-100 200 wrect(4)-100+maxh];
            rs(options+2,:)=[wrect(3)-200 wrect(4)-100 wrect(3)-20 wrect(4)-100+maxh];
        end
elseif language==2
    Screen('TextFont',wptr, 'Microsoft YaHei');
        if first && last
            item.option{options+1}='save answer';
            rs(options+1,:)=[wrect(3)/2-90 wrect(4)-100 wrect(3)/2+90 wrect(4)-100+maxh];
        elseif first
            item.option{options+1}='next';
            rs(options+1,:)=[wrect(3)-200 wrect(4)-100 wrect(3)-20 wrect(4)-100+maxh];
        elseif last
            item.option{options+1}='last';
            item.option{options+2}='save answer';
            rs(options+1,:)=[20 wrect(4)-100 200 wrect(4)-100+maxh];
            rs(options+2,:)=[wrect(3)/2-90 wrect(4)-100 wrect(3)/2+90 wrect(4)-100+maxh];
        else    
            item.option{options+1}='last';
            item.option{options+2}='next';
            rs(options+1,:)=[20 wrect(4)-100 200 wrect(4)-100+maxh];
            rs(options+2,:)=[wrect(3)-200 wrect(4)-100 wrect(3)-20 wrect(4)-100+maxh];
    end
end
    
%%        
tstart=GetSecs;
[~,~,buttons]=GetMouse(wptr);
while any(buttons)
    [~,~,buttons]=GetMouse(wptr);
end
selected=0;
while ~selected
    DrawFormattedText(wptr,double(item.stem),'center',wrect(4)/4,0);
    [x,y,buttons]=GetMouse(wptr);
    for i=1:length(item.option)
        [cx,cy]=RectCenter([rs(i,1)+maxh rs(i,2),rs(i,3),rs(i,4)]);
        cx=rs(i,1)+maxh;
        cy=rs(i,2);
        if IsInRect(x,y,rs(i,:))
            switch i
                case options+1
                        if first && last
                            Screen('PutImage',wptr,savebutton,[rs(i,1) rs(i,2),rs(i,1)+maxh,rs(i,4)]);
                        elseif first
                            Screen('PutImage',wptr,rightarrow,[rs(i,1) rs(i,2),rs(i,1)+maxh,rs(i,4)]);
                        elseif last
                            Screen('PutImage',wptr,leftarrow,[rs(i,1) rs(i,2),rs(i,1)+maxh,rs(i,4)]);
                        else
                            Screen('PutImage',wptr,leftarrow,[rs(i,1) rs(i,2),rs(i,1)+maxh,rs(i,4)]);
                        end                            
                        if any(buttons) && any(item.value) && first && last
                            selected=1;
                            whichbutton=3;
                        elseif any(buttons) && any(item.value) && first
                            selected=1;
                            whichbutton=2;
                        elseif any(buttons) && any(item.value) && last
                            selected=1;
                            whichbutton=1;
                        elseif any(buttons) && any(item.value)
                            selected=1;
                            whichbutton=1;
                        elseif any(buttons)
                            beep;
                        end
                case options+2
                        if last
                            Screen('PutImage',wptr,savebutton,[rs(i,1) rs(i,2),rs(i,1)+maxh,rs(i,4)]);
                        else
                            Screen('PutImage',wptr,rightarrow,[rs(i,1) rs(i,2),rs(i,1)+maxh,rs(i,4)]);
                        end
                        if any(buttons) && any(item.value) && last
                            selected=1;
                            whichbutton=3;
                        elseif any(buttons) && any(item.value)
                            selected=1;
                            whichbutton=2;
                        elseif any(buttons)
                            beep;
                        end
                otherwise
                    if item.type==1
                        if item.value(i)
                            Screen('PutImage',wptr,radiobutton1,[rs(i,1) rs(i,2),rs(i,1)+maxh,rs(i,4)]);
                        else
                            Screen('PutImage',wptr,radiobutton0,[rs(i,1) rs(i,2),rs(i,1)+maxh,rs(i,4)]);
                        end
                        if any(buttons)
                            item.value(:)=0;
                            item.value(i)=1;
                        end
                    elseif item.type==2
                        if item.value(i)
                            Screen('PutImage',wptr,checkbox1,[rs(i,1) rs(i,2),rs(i,1)+maxh,rs(i,4)]);
                        else
                            Screen('PutImage',wptr,checkbox0,[rs(i,1) rs(i,2),rs(i,1)+maxh,rs(i,4)]);
                        end
                        if any(buttons)
                            if item.value(i)
                                item.value(i)=0;
                            else
                                item.value(i)=1;
                            end
                            while any(buttons) % wait for release
                                [x1,y1,buttons] = GetMouse;
                            end
                            
                        end
                    end
            end
            DrawFormattedText(wptr,double(item.option{i}),cx,cy,[0 0 255]);
        else
            switch i
                case options+1
                        if first && last
                            Screen('PutImage',wptr,savebutton,[rs(i,1) rs(i,2),rs(i,1)+maxh,rs(i,4)]);
                        elseif first
                            Screen('PutImage',wptr,rightarrow,[rs(i,1) rs(i,2),rs(i,1)+maxh,rs(i,4)]);
                        elseif last
                            Screen('PutImage',wptr,leftarrow,[rs(i,1) rs(i,2),rs(i,1)+maxh,rs(i,4)]);
                        else
                            Screen('PutImage',wptr,leftarrow,[rs(i,1) rs(i,2),rs(i,1)+maxh,rs(i,4)]);
                        end                            
                case options+2
                        if last
                            Screen('PutImage',wptr,savebutton,[rs(i,1) rs(i,2),rs(i,1)+maxh,rs(i,4)]);
                        else
                            Screen('PutImage',wptr,rightarrow,[rs(i,1) rs(i,2),rs(i,1)+maxh,rs(i,4)]);
                        end
                otherwise
                    if item.type==1
                        if item.value(i)
                            Screen('PutImage',wptr,radiobutton1,[rs(i,1) rs(i,2),rs(i,1)+maxh,rs(i,4)]);
                        else
                            Screen('PutImage',wptr,radiobutton0,[rs(i,1) rs(i,2),rs(i,1)+maxh,rs(i,4)]);
                        end
                    elseif item.type==2
                        if item.value(i)
                            Screen('PutImage',wptr,checkbox1,[rs(i,1) rs(i,2),rs(i,1)+maxh,rs(i,4)]);
                        else
                            Screen('PutImage',wptr,checkbox0,[rs(i,1) rs(i,2),rs(i,1)+maxh,rs(i,4)]);
                        end
                    end
            end
            DrawFormattedText(wptr,double(item.option{i}),cx,cy,0);
        end
    end
    Screen('Flip',wptr);
end
Screen('Flip',wptr);
tend=GetSecs;
stime=tend-tstart;
value=item.value;
