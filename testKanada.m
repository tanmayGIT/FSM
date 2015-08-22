% close all;
% clear all;
% clc;
% 
% % Select the folder containing the reference images
% dirInput = '/Volumes/Macintosh_HD_2/Word Spotting Dataset/Next Collection/Indian Language /Kannada/test2/';
% files = dir(fullfile(dirInput, '*.TIF'));
% fileNamesRef = {files.name}';
% imgPathRef = strcat(dirInput,'/');
% nImagesRef = (length(fileNamesRef));
% h = fspecial('average', [3 3]);
% gaussfilter = fspecial('gaussian',[3 3], 0.5);
% for goEachRefImg = 1:1:nImagesRef
%     imageFilePathRef = [imgPathRef,fileNamesRef{goEachRefImg}];
%     [~, refName, ~] = fileparts(imageFilePathRef);
%     binImg  = imread(imageFilePathRef);
%     binImg = imcomplement(binImg);
%     greyImg = binImg;
%     for ui = 1:1:5
%         greyImg = imfilter(greyImg, h);
%     end  
%     greyImg = imfilter(greyImg, gaussfilter, 'replicate');
%     greyImg = imsharpen(greyImg,'Radius',3,'Amount',3);
%     imshow(greyImg);
% end


close all;
clear all;
clc;

% Select the folder containing the reference images
dirInput = '/Volumes/Macintosh_HD_2/Word Spotting Dataset/Next Collection/Indian Language /Kannada/test2/';
files = dir(fullfile(dirInput, '*.TIF'));
fileNamesRef = {files.name}';
imgPathRef = strcat(dirInput,'/');
nImagesRef = (length(fileNamesRef));
h = fspecial('average', [3 3]);
gaussfilter = fspecial('gaussian',[3 3], 0.5);
for goEachRefImg = 1:1:nImagesRef
    imageFilePathRef = [imgPathRef,fileNamesRef{goEachRefImg}];
    [~, refName, ~] = fileparts(imageFilePathRef);
    binImg  = imread(imageFilePathRef);
    angle = slantDetection(binImg);
    final_line = slantCorrection(binImg, angle);
    newBinImg = zeros(1,1);
    for ii = 1:1:size(final_line,1)
        for jj = 1:1:size(final_line,2)
            if(final_line(ii,jj) == 0)
                newBinImg(ii,jj) = 0;
            else
                newBinImg(ii,jj) = 1;
            end
        end
    end
    [final_line, slope, baseline] = skewCorrection(newBinImg);
    binImg = final_line;
    greyImg = zeros(1,1);
    for ii = 1:1:size(binImg,1)
        for jj = 1:1:size(binImg,2)
            if(binImg(ii,jj) == 0)
                greyImg(ii,jj) = 255;
            else
                greyImg(ii,jj) = 0;
            end
        end
    end
    for ui = 1:1:5
        greyImg = imfilter(greyImg, h);
    end  
    greyImg = imfilter(greyImg, gaussfilter, 'replicate');
   if(size(binImg,3)==3)
        binImg = rgb2gray(binImg);
    end
    strokeWidth = averageStrokeWidth(binImg);
%     greyImg = imsharpen(greyImg,'Radius',3,'Amount',1);
    imshow(mat2gray(greyImg));
    appearanceBasedFeatures(greyImg, binImg,round(strokeWidth))
%    [featureMat,lukUpTableForRealIndex] = getHOGFeatureRefined(greyImg,binImg,round(strokeWidth));
end