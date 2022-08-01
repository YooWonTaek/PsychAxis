% filename is:: drawTextPictures.m

% clear
clc; clear; close all;

% prepare imgFolder
imgFolderName = 'ImagesR';

if ~exist(imgFolderName)
    mkdir(imgFolderName);
end

% prepare
% strCells = {'Rat'; 'Ox'; 'Tiger'; 'Rabbit'; 'Dragon'; 'Snake'; 'Horse'; 'Goat'; 'Monkey'; 'Roaster'; 'Dog'; 'Pig'};
% textFileName = 'wordsList.txt';
% strCells = textread(textFileName, '%s', 'delimiter','\n');

% excel read
xlsFileName = 'wordsList.xlsx';
[num strCells raw] = xlsread(xlsFileName, 'Sheet1', 'B2:B13');


% LOOP: index is i
for i = 1:length(strCells)

    
     tmpWord = strCells{i};
% create a figure
hFigure = figure(1);
set(hFigure, 'position',[100 50 300 300]);

% create an axes
hAxes = axes('parent',hFigure);
set(hAxes, 'units','pixels', 'position',[1 1 300 300]);

% generate a black image matrix
imgMatrix = zeros(300, 300, 3); % 3== rgb

% show the black image
imshow(imgMatrix, 'parent',hAxes);


% text
text(150,150,tmpWord, 'HorizontalAlign','center', 'fontsize',36, 'fontname','Microsoft YaHei', 'color','w');

hFrame = getframe(gcf);
imgText = hFrame.cdata;

% save
jpgFileName = sprintf('%s/%s.jpg',imgFolderName, tmpWord);
imwrite(imgText, jpgFileName,'jpg');



end















