function [ImCombo] = backgroundMaker(pathFront, imageFront, imageBack)

%%This function takes an image and combines it with a background. 

[front, ~, alpha] = imread(horzcat(pathFront,'\',imageFront));
back = imread(horzcat('C:\Users\stweis\SkyDrive\MVPA_ARROWS\FMRI_Materials\Behavioral_Exp v03\FINAL_24_IMAGES\scrambled\',imageBack));
alpha = repmat(alpha, [1 1 3]);
front = im2double(front);
alpha = im2double(alpha);
back = im2double(back);
x = 1;
y = 1;

% Let's combine the images.
img3 = back;
img3(y:y+size(front,1)-1, x:x+size(front,2)-1, :) = ...
    front .* alpha + ...
    back(y:y+size(front,1)-1, x:x+size(front,2)-1, :) .* (1 - alpha);

% And display the result.
name = imageFront(1:end-4);
imwrite(img3,horzcat(name,'.png'),'png');