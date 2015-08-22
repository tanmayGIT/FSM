% this code is for the FSM on 126 CESR query. This the new technique of
% calculating the graph. Created/Modified on 18/6/2015

clear all;
clc;

 
load('CDP1_Old_Normalize_columnFeature_makeDoubleHeight.mat');
% allAccuracyArr = doAverageForAccuracy(allAccuracyArr3);
[allAccuracyArr,mytotarr] = cellToArrForPlot_1(allAccuracyArr);
[mean_avg_pre,eachPrecisionCDP] = meanAveragePrecision(allAccuracyArr);
disp('CDP');
disp(mean_avg_pre);
[X8,Y8,Z8,M8]  = plotAccuracyGraph_2(mytotarr);
clear allResult;
clear allAccuracyArr;

load('MVM_Updated_12_Old_Normalize_columnFeature_makeDoubleHeight.mat');
% allAccuracyArr = doAverageForAccuracy(allAccuracyArr4);
[allAccuracyArr,mytotarr] = cellToArrForPlot_1(allAccuracyArr);
[mean_avg_pre,eachPrecision] = meanAveragePrecision(allAccuracyArr);
disp('FSM');
disp(mean_avg_pre);
[X9,Y9,Z9,M9]  = plotAccuracyGraph_2(mytotarr);
clear allResult;
clear allAccuracyArr; 


figure();
h(1) = subplot(1,1,1);


plot(Z8,Y8,'-r','LineWidth',1);
hold on;

plot(Z9,Y9,'-b','LineWidth',1);
hold on;

hleg1 = legend('CDP','FSM');
% hleg1 = legend('ESC (0.8362)','MVM (0.6520)','CDP (0.8355)','FSM (0.8028)','OSB (0.7042)','SSDTW (0.8148)');
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
