function [C,D] = gistCalculator(numImages,imType)

%C = Correlation matrix; D = Distance Matrix

currDir = pwd;
%Where is Gist?
addpath('C:\Users\stweis\Documents\MATLAB\gistdescriptor');

%Where is the data?
path = 'C:\Users\stweis\SkyDrive\MVPA_ARROWS\FMRI_Materials\Behavioral_Exp v03\FMRI_Experiment_Scripts\24_Images_for_gist';
cd(path);
%How many images?
% numImages = 252;
%What is the image type and format?
a = dir(horzcat('*',imType,'*png*'));


% GIST Parameters:
clear param
param.imageSize = [800 800]; % set a normalized image size
param.orientationsPerScale = [8 8 8 8]; % number of orientations per scale (from HF to LF)
param.numberBlocks = 4;
param.fc_prefilt = 4;

% Pre-allocate gist:
Nfeatures = sum(param.orientationsPerScale)*param.numberBlocks^2;


gist = zeros([numImages Nfeatures]); 




file = cell(1,numImages);
for i = 1:numImages
    file{i} = a(i).name;
end


% Load first image and compute gist:
img = imread(strcat(path,'\',file{1}));
[gist(1, :), param] = LMgist(img, '', param); % first call

% Loop:
for i = 2:numImages
   img = imread(strcat(path,'\',file{i}));
   gist(i, :) = LMgist(img, '', param); % the next calls will be faster
end

%distances and correlations
C = zeros(numImages,numImages);
D = zeros(numImages,numImages);
for i = 1:numImages
    for j = 1:numImages
        D(i,j) = sum(gist(:,i)-gist(:,j).^2);
        C(i,j) = corr(gist(i,:)',gist(j,:)');
    end
end





cd(currDir);
