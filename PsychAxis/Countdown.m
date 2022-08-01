% Clear the workspace and the screen
close all;
clearvars;
sca

% Randomly seed the random number generation
rng('shuffle');

% Here we call some default settings for setting up Psychtoolbox
PsychDefaultSetup(2);

% Skip sync tests for demo purposes only
Screen('Preference', 'SkipSyncTests', 2);

% Get the screen numbers
screens = Screen('Screens');

% Select the external screen if it is present, else revert to the native
% screen
screenNumber = max(screens);

% Define black
black = BlackIndex(screenNumber);

% Open an on screen window and color it grey
[window, wrect] = PsychImaging('OpenWindow', screenNumber, black);

% Get the size of the on screen window in pixels
% For help see: Screen WindowSize?
% [screenXpixels, screenYpixels] = Screen('WindowSize', window);

% Get the centre coordinate of the window in pixels

% [xCenter, yCenter] = RectCenter(wrect);

% We set the text size to be nice and big here
Screen('TextSize', window, 80);
nominalFrameRate = Screen('NominalFrameRate', window);
presSecs = [sort(repmat(1:10, 1, nominalFrameRate), 'descend') 0];
for i = 1:length(presSecs)
    numberString = num2str(presSecs(i));
    DrawFormattedText(window, numberString, wrect(3)-100, wrect(2)+40, [87,87,86]);
    Screen('Flip', window);
end

% Wait a second before closing the screen
WaitSecs(1);

% Clear the screen
close all;
clear all;
sca
