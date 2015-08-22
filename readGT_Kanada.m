clear all;
close all;
clc;
inputDir = '/Volumes/Macintosh_HD_2/Word Spotting Dataset/Next Collection/Indian Language /Kannada/TxtGroundTruth/TxtGroundTruth/';
files = dir(fullfile(inputDir, '*.doc'));
fileNames = {files.name}';
imgPath = strcat(inputDir,'/');
nFiles = (length(fileNames));
for goEachRefImg = 1:1:nFiles
    imageFilePathRef = [inputDir,fileNames{goEachRefImg}];
    [~, refName, ~] = fileparts(imageFilePathRef);
    % Read text file "relvance_judgement.txt"
    txtFile = saveWordAsText(imageFilePathRef);
    [file,status,errMsg] = officedoc(imageFilePathRef, 'open', 'mode','read');
    nLinesT1 = 0;
    while (fgets(fid) ~= -1),
        nLinesT1 = nLinesT1+1;
    end
    tline = fgets(fid);
    [P,Q,R,S] = textread([inputImgDir,'relevance_judgment.txt'],'%d %s %d %d',nLinesT1);
    fclose(fid);
end