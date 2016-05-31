

% %calculate within and between correlations

numImages = 504;
numDirections = 7;
numExemplars = 24;
numFormats = 3;

%1=ahead,2=left,3=right,4=shLeft,5=shRight,6=slLeft,7=slRight
directionIndex = [ones(1,(numImages/numDirections)) 2*ones(1,(numImages/numDirections)) 3*ones(1,(numImages/numDirections)) 4*ones(1,(numImages/numDirections)) ...
    5*ones(1,(numImages/numDirections)) 6*ones(1,(numImages/numDirections)) 7*ones(1,(numImages/numDirections))];

%1=image,2=schema,3=word
formatIndex = repmat([ones(1,(numImages/(numFormats*numDirections))) 2*ones(1,(numImages/(numFormats*numDirections))) 3*ones(1,(numImages/(numFormats*numDirections)))],1,(numDirections));


%delete the diagonal (1's)    
identity = eye(numImages);
gistCorrelations = C;
for row = 1:length(identity)
    for column = 1:length(identity)
    if identity(row,column) == 1
        gistCorrelations(row,column) = NaN;
    end
    end
end

%% 


%%%%%
%%This calculates the following averages.
% condensed = zeros(21,21);
% 
% same_dir_diff_format = zeros(1,21);
% sddf_count = 1;
% 
% diff_dir_diff_format = zeros(1,21);
% dddf_count = 1;
% 
% 
% diff_dir_same_format = zeros(1,21);
% ddsf_count = 1;
% 
% same_dir_same_format = zeros(1,21);
% sdsf_count = 1;
% 
% %%This steps through each direction, then format, then direction, then
% %%format. 
% 
% for i = 1:length(unique(directionIndex))
%     for j = 1:3
%         for k = 1:7
%             for m = 1:3
%                 condensed(((j-1)*7)+i,((m-1)*7)+k) = nanmean(nanmean(corrNoDiag(find(directionIndex==i&formatIndex==j),find(directionIndex==k&formatIndex==m))));
%                 if i == k && j ~= m
%                     same_dir_diff_format(1,sddf_count) = condensed(((j-1)*7)+i,((m-1)*7)+k);
%                     sddf_count = sddf_count+1;
%                 elseif i ~=k && j ~= m
%                     diff_dir_diff_format(1,dddf_count) = condensed(((j-1)*7)+i,((m-1)*7)+k);
%                     dddf_count = dddf_count+1;
%                 elseif i ~=k && j == m
%                     diff_dir_same_format(1,ddsf_count) = condensed(((j-1)*7)+i,((m-1)*7)+k);
%                     ddsf_count = ddsf_count+1;  
%                 elseif i ==k && j == m
%                     same_dir_same_format(1,sdsf_count) = condensed(((j-1)*7)+i,((m-1)*7)+k);
%                     sdsf_count = sdsf_count+1;    
%                 end
%             end
%         end
%     end
% end
% 
% same_dir_diff_format_mean = mean(same_dir_diff_format);
% diff_dir_diff_format_mean = mean(diff_dir_diff_format);
% diff_dir_same_format_mean = mean(diff_dir_same_format);
% same_dir_same_format_mean = mean(same_dir_same_format);
%%%%%
%% 


%%This is the same thing, or should be, but steps through each IMAGE. 
%These sizes are arbitrary.
sameDirDiffFormat = zeros(1,6048);
diffDirDiffFormat = zeros(1,36288);
sameDirSameFormat = zeros(1,3024);
diffDirSameFormat = zeros(1,18144);
diffDir = zeros(1,54432);
sameDir = zeros(1,9072);

sddfCount = 1;
dddfCount = 1;
sdsfCount = 1;  
ddsfCount = 1; 
ddCount = 1; 
sdCount = 1;

for image1 = 1:length(gistCorrelations)
    for image2 = 1:length(gistCorrelations)
        dirIsSame = directionIndex(image1) == directionIndex(image2);
        formatIsSame = formatIndex(image1) == formatIndex(image2);
        if (dirIsSame&&~formatIsSame)
            sameDirDiffFormat(1,sddfCount) = gistCorrelations(image1,image2);
            sameDir(1,sdCount) = gistCorrelations(image1,image2);
            sddfCount = sddfCount + 1;
            sdCount = sdCount + 1; 
        elseif (~dirIsSame&&~formatIsSame)
            diffDirDiffFormat(1,dddfCount) = gistCorrelations(image1,image2);
            diffDir(1,ddCount) = gistCorrelations(image1,image2);
            dddfCount = dddfCount + 1;            
            ddCount = ddCount + 1;     
        elseif (dirIsSame&&formatIsSame)
            sameDirSameFormat(1,sdsfCount) = gistCorrelations(image1,image2);
            sameDir(1,sdCount) = gistCorrelations(image1,image2);
            sdsfCount = sdsfCount + 1;
            sdCount = sdCount + 1; 
        elseif (~dirIsSame&&formatIsSame)
            diffDirSameFormat(1,ddsfCount) = gistCorrelations(image1,image2);
            diffDir(1,ddCount) = gistCorrelations(image1,image2);
            ddsfCount = ddsfCount + 1;
            ddCount = ddCount + 1;
        end
    end
end




sameDirDiffFormatMean = nanmean(sameDirDiffFormat);
diffDirDiffFormatMean = nanmean(diffDirDiffFormat);
diffDirSameFormatMean = nanmean(diffDirSameFormat);
sameDirSameFormatMean = nanmean(sameDirSameFormat);
sameDirMean = nanmean(sameDir);
diffDirMean = nanmean(diffDir);


generalize = sameDirDiffFormatMean - diffDirDiffFormatMean;

%% 
%%This will do the same analyses but over a bunch of randomly permuted
%%matrices.
numPerms = 100;




sameDirDiffFormatRandAll = zeros(1,numPerms);
diffDirDiffFormatRandAll = zeros(1,numPerms);
diffDirSameFormatRandAll = zeros(1,numPerms);
sameDirSameFormatRandAll = zeros(1,numPerms);
sameDirRandAll = zeros(1,numPerms);
diffDirRandAll = zeros(1,numPerms);
generalizeRandAll = zeros(1,numPerms);

%These sizes are arbitrary.
sameDirDiffFormatRand = zeros(1,6048);
diffDirDiffFormatRand = zeros(1,36288);
sameDirSameFormatRand = zeros(1,3024);
diffDirSameFormatRand = zeros(1,18144);
diffDirRand = zeros(1,54432);
sameDirRand = zeros(1,9072);

%Find the index for all numbers in the lower triangle without the diagonal.
%We will randomize this for each permutation, then re-assign the gist
%correlations to another cell. Then mirror the lower triangle and change
%the diagonal to NaNs.

lowerIndex = find(tril(ones(size(gistCorrelations)),-1)==1);
for perm = 1:numPerms
    
    randomIndex = lowerIndex(randperm(length(lowerIndex)));  
    gistCorrRand = zeros(size(gistCorrelations));
    for thisRandomIndex = 1:length(randomIndex)
        [row, col] = ind2sub(size(gistCorrelations),lowerIndex(thisRandomIndex));
        gistCorrRand(row,col) = gistCorrelations(randomIndex(thisRandomIndex));
    end
    
    
    %Symmetrize the matrix and turn the diag into nans
    upperGistCorrRand = gistCorrRand';
    gistCorrRand = gistCorrRand + upperGistCorrRand;
    gistCorrRand(1:size(gistCorrRand,1)+1:end) = NaN;
    
    
    
    sddfCountRand = 1;
    dddfCountRand = 1;
    sdsfCountRand = 1;  
    ddsfCountRand = 1; 
    ddCountRand = 1; 
    sdCountRand = 1;
    
    
    for image1 = 1:length(gistCorrRand)
        for image2 = 1:length(gistCorrRand)
            dirIsSame = directionIndex(image1) == directionIndex(image2);
            formatIsSame = formatIndex(image1) == formatIndex(image2);
            if (dirIsSame&&~formatIsSame)
                sameDirDiffFormatRand(1,sddfCountRand) = gistCorrRand(image1,image2);
                sddfCountRand = sddfCountRand + 1;
                sameDirRand(1,sdCountRand) = gistCorrRand(image1,image2);
                sdCountRand = sdCountRand + 1;
            elseif (~dirIsSame&&~formatIsSame)
                diffDirDiffFormatRand(1,dddfCountRand) = gistCorrRand(image1,image2);
                dddfCountRand = dddfCountRand + 1;
                diffDirRand(1,ddCountRand) = gistCorrRand(image1,image2);
                ddCountRand = ddCountRand + 1;
            elseif (dirIsSame&&formatIsSame)
                sameDirSameFormatRand(1,sdsfCountRand) = gistCorrRand(image1,image2);
                sdsfCountRand = sdsfCountRand + 1;
                sameDirRand(1,sdCountRand) = gistCorrRand(image1,image2);
                sdCountRand = sdCountRand + 1;
            elseif (~dirIsSame&&formatIsSame)
                diffDirSameFormatRand(1,ddsfCountRand) = gistCorrRand(image1,image2);
                ddsfCountRand = ddsfCountRand + 1;
                diffDirRand(1,ddCountRand) = gistCorrRand(image1,image2);
                ddCountRand = ddCountRand + 1;
            end
        end
    end

    sameDirDiffFormatRandAll(1,perm) = nanmean(sameDirDiffFormatRand);
    diffDirDiffFormatRandAll(1,perm) = nanmean(diffDirDiffFormatRand);
    diffDirSameFormatRandAll(1,perm) = nanmean(diffDirSameFormatRand);
    sameDirSameFormatRandAll(1,perm) = nanmean(sameDirSameFormatRand);
    sameDirRandAll(1,perm) = nanmean(sameDirRand);
    diffDirRandAll(1,perm) = nanmean(diffDirRand);
    
    generalizeRandAll(1,perm) = sameDirDiffFormatRandAll(1,perm) - diffDirDiffFormatRandAll(1,perm);
    
end
    
sameDirDiffFormatRandMean = mean(sameDirDiffFormatRandAll);
diffDirDiffFormatRandMean = mean(diffDirDiffFormatRandAll);
diffDirSameFormatRandMean = mean(diffDirSameFormatRandAll);
sameDirSameFormatRandMean = mean(sameDirSameFormatRandAll);
sameDirRandMean = mean(sameDirRandAll);
diffDirRandMean = mean(diffDirRandAll);

histogram(generalizeRandAll,1,false);