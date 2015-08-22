% generateFeatureMat  :-  Here is the following operation for generating
% offline features like
% column features and HOG features. Here the input to the function is
% the path of the folder where all other folders are present named after
% the name of the reference images. The folders with the name of the
% reference images having many segmented component images. So using these
% images we will create feature matrix and will save it for future use.



% matchOffline: Here this function will have the facility to match the
% function offline after the features are generated anb stored


tic;
clear all;
% close all;
clc;
% WordMatching('generateFeatureMat','CSER','columnFeature','Old_Normalize','makeDoubleHeight','MVM_Updated_17_5');





%% Experiments for ESC only: ESC SECTION : DON'T TOUCH ME
% WordMatchingESC('generateFeatureMatNewDataset','CSER','columnFeature','Old_Normalize','makeDoubleHeight','SSDTW');

% WordMatchingESC('matchOfflineNewCSER','CSER','columnFeature','Old_Normalize','makeDoubleHeight','SSDTW');
% WordMatchingESC('matchOfflineNewCSER','CSER','columnFeature','Old_Normalize','makeDoubleHeight','MVM');
% WordMatchingESC('matchOfflineNewCSER','CSER','columnFeature','Old_Normalize','makeDoubleHeight','CDP1');
% WordMatchingESC('matchOfflineNewCSER','CSER','columnFeature','Old_Normalize','makeDoubleHeight','MVM_Updated_12');
% WordMatchingESC('matchOfflineNewCSER','CSER','columnFeature','Old_Normalize','makeDoubleHeight','OSB');
% WordMatchingESC('matchOfflineNewCSER','CSER','columnFeature','Old_Normalize','makeDoubleHeight','MVM_Updated_17');
%%






% WordMatching('matchOnlineExperiArtificial','CSER','columnFeature','Old_Normalize','makeDoubleHeight','MVM_Updated_17_4');
% WordMatching('generateFeatureMat','CSER','columnFeature','Old_Normalize','makeDoubleHeight','MVM');
% WordMatching('matchOfflineNewCSER','CSER','columnFeature','Old_Normalize','makeDoubleHeight','DTW');
% WordMatching('generateFeatureMat','CSER','columnFeature','Old_Normalize','makeDoubleHeight');
% clear all;

WordMatching('generateFeatureMatNewDataset','CSER','columnFeature','Old_Normalize','makeDoubleHeight','MVM');
% clear all;
% 
% WordMatching('matchOffline','CSER','columnFeature','Old_Normalize','makeDoubleHeight','MVM_Updated_17_4');
% WordMatching('matchOfflineNewCSER','CSER','columnFeature','Old_Normalize','makeDoubleHeight','CDP1');
% WordMatching('matchOfflineNewCSER','CSER','columnFeature','Old_Normalize','makeDoubleHeight','MVM_Updated_12');
% WordMatching('matchOffline','CSER','columnFeature','Old_Normalize','makeDoubleHeight','DDTW');
% WordMatching('matchOffline','CSER','columnFeature','Old_Normalize','makeDoubleHeight','OSB');
% WordMatching('matchOffline','CSER','columnFeature','Old_Normalize','makeDoubleHeight','MVM');
% % clear all;
% 
% WordMatching('matchOffline','CSER','columnFeature','Old_Normalize','makeDoubleHeight','MVM_Updated_12');
% clear all;

% WordMatching('matchOffline','CSER','columnFeature','Old_Normalize','makeDoubleHeight','DTW');
% clear all;

% WordMatching('matchOffline','CSER','columnFeature','Old_Normalize','keepOriginalHeight','MVM_Updated_12');
% clear all;

% close all;
% WordMatching('matchOffline','CSER','columnFeature','Old_Normalize','makeDoubleHeight','OSB');
% clear all;
% WordMatching('matchOffline','CSER','columnFeature','Old_Normalize','keepOriginalHeight','WDTW');
% clear all;
% WordMatching('matchOffline','CSER','columnFeature','Old_Normalize','makeDoubleHeight','SSDTW');
% clear all;

% close all;


% WordMatching('generateFeatureMat','CSER','HOGFeature','Old_Normalize','makeDoubleHeight');

% WordMatching('matchOffline','CSER','HOGFeature','Old_Normalize','makeDoubleHeight','MVM');
% clear all;
% WordMatching('matchOffline','CSER','HOGFeature','Old_Normalize','makeDoubleHeight','MVM_Updated_7');
% clear all;
% WordMatching('matchOffline','CSER','HOGFeature','Old_Normalize','makeDoubleHeight','WDTW');
% clear all;
% WordMatching('matchOffline','CSER','HOGFeature','Old_Normalize','makeDoubleHeight','SSDTW');
% clear all;
% WordMatching('matchOffline','CSER','HOGFeature','Old_Normalize','makeDoubleHeight','MVM_Updated_3');
% clear all;
% WordMatching('matchOffline','CSER','HOGFeature','Old_Normalize','makeDoubleHeight','DTW');

