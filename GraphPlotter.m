clear all;
clc;

load('MVM_Updated_17_Old_Normalize_columnFeature_ESC_v1_makeDoubleHeight.mat');
% allAccuracyArr = doAverageForAccuracy(allAccuracyArr);
% allAccuracyArr = cellToArrForPlot(allAccuracyArr);
% [X6,Y6,Z6,M6]  = plotAccuracyGraph(allAccuracyArr);

[allAccuracyArr,mytotarr] = cellToArrForPlot_1(allAccuracyArr);
mean_avg_pre = meanAveragePrecision(allAccuracyArr);
disp('ESC');
disp(mean_avg_pre);
[X6,Y6,Z6,M6]  = plotAccuracyGraph_2(mytotarr);
clear allResult;
clear allAccuracyArr;



load('MVM_Old_Normalize_columnFeature_ESC_v1_makeDoubleHeight.mat');
% allAccuracyArr = doAverageForAccuracy(allAccuracyArr2);
[allAccuracyArr,mytotarr] = cellToArrForPlot_1(allAccuracyArr);
mean_avg_pre = meanAveragePrecision(allAccuracyArr);
disp('MVM');
disp(mean_avg_pre);
[X7,Y7,Z7,M7]  = plotAccuracyGraph_2(mytotarr);
clear allResult;
clear allAccuracyArr;

 
load('CDP1_Old_Normalize_columnFeature_ESC_v1_makeDoubleHeight.mat');
% allAccuracyArr = doAverageForAccuracy(allAccuracyArr3);
[allAccuracyArr,mytotarr] = cellToArrForPlot_1(allAccuracyArr);
mean_avg_pre = meanAveragePrecision(allAccuracyArr);
disp('CDP');
disp(mean_avg_pre);
[X8,Y8,Z8,M8]  = plotAccuracyGraph_2(mytotarr);
clear allResult;
clear allAccuracyArr;

load('MVM_Updated_12_Old_Normalize_columnFeature_ESC_v1_makeDoubleHeight.mat');
% allAccuracyArr = doAverageForAccuracy(allAccuracyArr4);
[allAccuracyArr,mytotarr] = cellToArrForPlot_1(allAccuracyArr);
mean_avg_pre = meanAveragePrecision(allAccuracyArr);
disp('FSM');
disp(mean_avg_pre);
[X9,Y9,Z9,M9]  = plotAccuracyGraph_2(mytotarr);
clear allResult;
clear allAccuracyArr; 

load('OSB_Old_Normalize_columnFeature_ESC_v1_makeDoubleHeight.mat');
% allAccuracyArr = doAverageForAccuracy(allAccuracyArr5);
[allAccuracyArr,mytotarr] = cellToArrForPlot_1(allAccuracyArr);
mean_avg_pre = meanAveragePrecision(allAccuracyArr);
disp('OSB');
disp(mean_avg_pre);
[X10,Y10,Z10,M10]  = plotAccuracyGraph_2(mytotarr);
clear allResult;
clear allAccuracyArr;

% load('OSB_Old_Normalize_columnFeature_makeDoubleHeight.mat');
% % allAccuracyArr = doAverageForAccuracy(allAccuracyArr4);
% allAccuracyArr = cellToArrForPlot(allAccuracyArr);
% [X11,Y11,Z11,M11]  = plotAccuracyGraph(allAccuracyArr);
% 
% clear allAccuracyArr;

load('SSDTW_Old_Normalize_columnFeature_ESC_v1_makeDoubleHeight.mat');
% allAccuracyArr = doAverageForAccuracy(allAccuracyArr5);
[allAccuracyArr,mytotarr] = cellToArrForPlot_1(allAccuracyArr);
mean_avg_pre = meanAveragePrecision(allAccuracyArr);
disp('SSDTW');
disp(mean_avg_pre);
[X12,Y12,Z12,M12]  = plotAccuracyGraph_2(mytotarr);
clear allResult;
clear allAccuracyArr;

clear allAccuracyArr;

figure();
h(1) = subplot(1,1,1);

plot(Z6,Y6,'-m','LineWidth',1);
hold on;

plot(Z7,Y7,'-g','LineWidth',1);
hold on;

plot(Z8,Y8,'-r','LineWidth',1);
hold on;

plot(Z9,Y9,'-b','LineWidth',1);
hold on;
% 
plot(Z10,Y10,'-k','LineWidth',1);
hold on;
% 
% plot(Z11,Y11,'-c','LineWidth',1);
% hold on;
% 
plot(Z12,Y12,'-c','LineWidth',1);
hold on;
% hleg1 = legend('MVM','CDP','FSM','OSB','SSDTW');
hleg1 = legend('ESC (0.8362)','MVM (0.6520)','CDP (0.8355)','FSM (0.8028)','OSB (0.7042)','SSDTW (0.8148)');
line([0 1],[0 1],'LineWidth',1, 'LineStyle','--'),hold on
hold off;

set(hleg1,'Location','NorthEast')
set(hleg1,'FontSize',12)


% set(gca,'XTick', [20,40,60,80,100])
% set(gca,'XTickLabel',{'20','40','60','80','100'})
% set(gca,'YMinorGrid','on','YMinorTick','on');
set(hleg1,'Location','SouthEast')
% set(hleg1,'FontSize',6)
% set(gca,'XMinorGrid','on','XMinorTick','on');
set(gca,'FontSize',10);
% text(Xlabel, trainRetrieve,'\rightarrow sin(-\pi\div4)',...
%      'HorizontalAlignment','right')
set(gca,'YTick',0:0.1:1);
% set(gca,'YTick', [200,400,600,800,1000,1200,1400,1600,1800,2000,2200,2381])
set(gca,'YTickLabel',{'0','0.1','0.2','0.3','0.4','0.5','0.6','0.7','0.8','0.9','1.0'})

xl = xlabel('Recall');
yl = ylabel('Precision');
set(xl,'FontSize',12);
set(yl,'FontSize',12);

axis([0 1 0 1])
