%% % Example 3 - display typed text on screen
% written for Psychtoolbox 3  by Aaron Seitz 1/2012

[window, rect]=Screen('OpenWindow',0);  % open screen
ListenChar(2); %makes it so characters typed don't show up in the command window
HideCursor(); %hides the cursor

%Get responses from what subjects typed
KbName('UnifyKeyNames'); %used for cross-platform compatibility of keynaming
% KbQueueCreate; %creates cue using defaults
% KbQueueStart;  %starts the cue

returnKey=40; %define return key (used to end)
deleteKey=42; %define delete key (used to delete)

Screen('TextSize',window,28); %sets textsize for instructions
Screen('DrawText',window,'Type some text. Press ENTER to finish typing.',50,70,1); %draws instructions
Screen('Flip',window);

enterpressed=0; %initializes loop flag
AsteriskBuffer=[]; %initializes buffer
while ( enterpressed==0 )
    [ pressed, firstPress]=KbQueueCheck; %checks for keys
    enterpressed=firstPress(returnKey)%press return key to terminate each response
    if (pressed && ~enterpressed) %keeps track of key-presses and draws text
        if firstPress(deleteKey) %if delete key then erase last key-press
            AsteriskBuffer=AsteriskBuffer(1:end-1); %erase last key-press
        else %otherwise add to buffer
           firstPress(find(firstPress==0))=NaN; %little trick to get rid of 0s
          [endtime Index]=min(firstPress); % gets the RT of the first key-press and its ID
            AsteriskBuffer=[AsteriskBuffer KbName(Index)]; %adds key to buffer
        end
        Screen('TextSize',window,28); %sets textsize for instructions
        Screen('DrawText',window,'Type some text. Press ENTER to finish typing.',50,70,1); %draws instructions
        Screen('TextSize',window,40);  %sets textsize for keys pressed
        DrawFormattedText(window, AsteriskBuffer, 'center','center'); %draws keyspressed
        Screen('Flip',window);
    end;
    WaitSecs(.01); % put in small interval to allow other system events
end;
ListenChar(0); %makes it so characters typed do show up in the command window
ShowCursor(); %shows the cursor
Screen('CloseAll'); %Closes Screen