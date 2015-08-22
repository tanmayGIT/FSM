clear all;
close all;
clc;

%%%%%%%%%%%%%%%%%  Feature Generation For Complete Dataset %%%%%%%%%%%%%%%
inputImgDir = '/Volumes/Macintosh_HD_2/Word Spotting Dataset/washington_good_set/';
inputFeatureDir = '/Volumes/Macintosh_HD_2/Word Spotting Dataset/washington_good_set/washington_good_set_features/';
files = dir(fullfile(inputImgDir, '*.tif'));
fileNames = {files.name}';
nImagesRef = (length(fileNames));
allFeatures = cell(1,1);
for i = 1:1:nImagesRef
%     tempMat = zeros(1,4);
    imgNm = fileNames{i,1};
    [pathstr,name,ext] = fileparts(imgNm);
%     temImg = imread([inputImgDir,fileNames{i,1}]);
%     justNm = str2num(name(1,9:11));
%     featureNm = ['features_' num2str(justNm) '.dat'];
%     featureDir = [inputFeatureDir featureNm];
%     keepAllFeature = generateFeaturemat(inputImgDir,fileNames,'Old_Normalize','columnFeature','keepOriginalHeight');
%     [f1 f2 f3 f4]= textread(featureDir, '%f %f %f %f', 'headerlines', 1);
%     tempMat = zeros(length(f1),4);
%     tempMat(:,1) = f1;
%     tempMat(:,2) = f2;
%     tempMat(:,3) = f3;
%     tempMat(:,4) = f4;
%     allFeatures{i,1} = tempMat;
end
%%%%%%%%%%%%%%%%%%%%%%   End of feature Generation  %%%%%%%%%%%%%%%%%%


% Read text file "relvance_judgement.txt"
fid = fopen([inputImgDir,'relevance_judgment.txt'],'rt');
nLinesT1 = 0;

while (fgets(fid) ~= -1),
    nLinesT1 = nLinesT1+1;
end
fclose(fid);
[P,Q,R,S] = textread([inputImgDir,'relevance_judgment.txt'],'%d %s %d %d',nLinesT1);


%Read text line "testsuite_images.txt"
fid = fopen([inputImgDir,'testsuite_images.txt'],'rt');
nLinesT2 = 0;

while (fgets(fid) ~= -1),
    nLinesT2 = nLinesT2+1;
end
[A] = textread([inputImgDir,'testsuite_images.txt'],'%s',nLinesT2);
fclose(fid);

randNum = [1633 1797 1846 1484 1052 1429 781 205 206 208 248 249 713 1712];

for ichk=1:1:(length(randNum))
    imgPath = A{(randNum(1,ichk)),1} ;
    [pathstr, name, ext] = fileparts(imgPath) ;
    
    refImgIndex = (randNum(1,ichk));
    % testImgPath = allImgPath{testImgIndex,1};
    refImgRead = imread([inputImgDir,imgPath]);
    % figure,imshow(testImgRead);
    
    imgIndex = getIndexOfImage(name,A);
    storSameImgPath = cell(1,1);
    storMyIndex = zeros(1,1);
    indx1 = find(P == imgIndex);
    indx2 = find(R == imgIndex);
    cnt1 = 1; 
    if(~isempty(indx1))
        for getSame = 1:1:(length(indx1))
            sameImageName = A{(R((indx1(getSame,1)),1)),1};
            fullImagePath = sameImageName;
            storSameImgPath{cnt1,1} = fullImagePath;
            storMyIndex(cnt1,1) = R((indx1(getSame,1)),1);
            % imwrite(sameImg,[imageFolder_1,(int2str(getSame)) '.jpg']);
            cnt1 = cnt1 +1;
        end
    end
    if(~isempty(indx2))
        for getSame = 1:1:(length(indx2))
            sameImageName = A{P((indx2(getSame,1)),1),1};
            fullImagePath = sameImageName;
            storSameImgPath{cnt1,1} = fullImagePath;
            storMyIndex(cnt1,1) = P(indx2(getSame,1));
%             imwrite(sameImg,[imageFolder_1,(int2str(getSame)) '.jpg']);
            cnt1 = cnt1 +1;
        end
    end
    wd = storSameImgPath;
    [~,idx]=unique(wd,'rows');
    withoutduplicatesNm = wd(idx,:);
    withoutduplicatesIndex = storMyIndex(idx,:);
    fileNamesInFolder = A;
    resultArr = matchFeatureOffline_DAS_GW(allFeatures,fileNamesInFolder,name,refImgRead,'DTW','Old_Normalize','columnFeature','keepOriginalHeight');
end