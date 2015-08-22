clear all;

clc;

% load('DTW_Old_Normalize_HOGFeature_makeDoubleHeight.mat')
% [X,Y,Z]  = plotAccuracyGraph(allAccuracyArr);
% clear allAccuracyArr;

% load('MVM_MVMComponent_ImgOld_Normalize_HOGFeature_makeDoubleHeight.mat')
% [X0,Y0,Z0]  = plotAccuracyGraph(allAccuracyArr);
% clear allAccuracyArr;
% % % 
% % % 
% load('MVM_Old_Normalize_HOGFeature_makeDoubleHeight.mat')
% [X1,Y1,Z1]  = plotAccuracyGraph(allAccuracyArr);
% clear allAccuracyArr;
% % 
% % % 
% 
% 
% 
% load('MVM_Updated_3_Old_Normalize_HOGFeature_makeDoubleHeight.mat');
% [X2,Y2,Z2]  = plotAccuracyGraph(allAccuracyArr);
% clear allAccuracyArr;
% 
% 
% 
% 
% 
% load('MVM_Updated_10_MVMComponent_ImgOld_Normalize_HOGFeature_makeDoubleHeight.mat');
% [X3,Y3,Z3]  = plotAccuracyGraph(allAccuracyArr);
% clear allAccuracyArr;
% 
% load('MVM_Updated_7_Old_Normalize_HOGFeature_makeDoubleHeight.mat');
% [X4,Y4,Z4]  = plotAccuracyGraph(allAccuracyArr);
% clear allAccuracyArr;

load('DTW_Old_Normalize_columnFeature_keepOriginalHeight_allImages.mat');
[X5,Y5,Z5]  = plotAccuracyGraph(allAccuracyArr);
clear allAccuracyArr;

load('SSDTW_Old_Normalize_columnFeature_keepOriginalHeight_allImages.mat');
[X6,Y6,Z6]  = plotAccuracyGraph(allAccuracyArr);
clear allAccuracyArr;
 
load('WDTW_Old_Normalize_columnFeature_keepOriginalHeight_allImages.mat');
[X7,Y7,Z7]  = plotAccuracyGraph(allAccuracyArr);
clear allAccuracyArr;
% 
load('MVM_Updated_3_Old_Normalize_columnFeature_keepOriginalHeight_allImages.mat');
[X8,Y8,Z8]  = plotAccuracyGraph(allAccuracyArr);
clear allAccuracyArr;
% % 
load('MVM_Updated_7_Old_Normalize_columnFeature_keepOriginalHeight_allImages.mat');
[X9,Y9,Z9]  = plotAccuracyGraph(allAccuracyArr);
clear allAccuracyArr;

load('MVM_Old_Normalize_columnFeature_keepOriginalHeight_allImages.mat');
[X10,Y10,Z10]  = plotAccuracyGraph(allAccuracyArr);
clear allAccuracyArr;

figure();
h(1) = subplot(1,1,1);

% q = plot(X9,Y9,'-');
q = plot(X5,Y5,'-',X6,Y6,'-',X7,Y7,'-',X8,Y8,'-',X9,Y9,'-',X10,Y10,'-');
% q = plot(X5,Y5,'-',X8,Y8,'-*c',X9,Y9,'-m',X10,Y10,'-b');
% q = plot(X,Y,'-',X0,Y0,'-',X1,Y1,'-',X2,Y2,'-',X3,Y3,'-',X4,Y4,'-');
% q = plot(X,Y,X0,Y0,'-');
% hleg1 = legend('MVM Updated-10-1-HOG(new jumpcost)','MVM Updated-10-2-HOG','MVM Updated-10-3-HOG','MVM Updated-10-4-HOG','MVM Updated-10-5-HOG');
hleg1 = legend('DTW-ColumnFeature','SSDTW-ColumnFeature','WDTW-ColumnFeature','MVM-Updated-3-ColumnFeature','MVM-Updated-7-ColumnFeature','MVM-ColumnFeature');
% hleg1 = legend('DTW-HOG-ComponentAccuracy','MVM-HOG-ComponentAccuracy','Updated MVM-7-HOGFeature','MVMUpdated-HOGFeature-ComponentAccuracy','DTW-ColumnFeaturre');
% hleg1 = legend('MVM Updated 3', 'with weight 0.9','with weight 1.0');

set(hleg1,'Location','NorthEast')
set(hleg1,'FontSize',8)
% q = plot(X1,Y1,'-',X2,Y2,':',X10,Y10,'-',X11,Y11,'-',X8,Y8,'-');
% legend('DDTW With Word Normalization','PDTW With Word Normalization','PDDTW With Word Normalization','DTW-CW With Word Normalization');
% hleg1 = legend('WDTW With Word Normalization');
% set(hleg1,'Location','NorthWest')
% set(hleg1,'FontSize',6)
%
% hleg2 = legend('WDTW With  Normalization');
% set(hleg2,'Location','NorthWest')
% set(hleg2,'FontSize',6)
%
% hleg3 = legend('WDTW With Word Normalization');
% set(hleg3,'Location','NorthWest')
% set(hleg3,'FontSize',6)
%
% hleg4 = legend('WDTW With Word Normalization');
% set(hleg4,'Location','NorthWest')
% set(hleg4,'FontSize',6)

set(gca,'XTick', [20,40,60,80,100])
set(gca,'XTickLabel',{'20','40','60','80','100'})
% set(gca,'YMinorGrid','on','YMinorTick','on');
set(gca,'XMinorTick','on','XMinorTick','on');
set(gca,'FontSize',10);
% text(Xlabel, trainRetrieve,'\rightarrow sin(-\pi\div4)',...
%      'HorizontalAlignment','right')
set(gca,'YTick',0:0.1:1);
% set(gca,'YTick', [200,400,600,800,1000,1200,1400,1600,1800,2000,2200,2381])
set(gca,'YTickLabel',{'0','0.1','0.2','0.3','0.4','0.5','0.6','0.7','0.8','0.9','1.0'})

xl = xlabel('No. of considered Nearest Neighbour');
yl = ylabel('Retrieval Accuracy');
set(xl,'FontSize',12);
set(yl,'FontSize',12);
axis([1 100 0 1])
% set(p,'Color','Green','LineWidth',1)
% get(gcf,'Position')
% set(gcf,'Position',[403 246 300 250]);