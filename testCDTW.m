% today (20/11/14) I am experimenting FSM again with all the sequences considered lng
% time back. The sequences from 1 to 7 are the toy examples for FSM . Don't delete it 
% ever from this code as it is useful always to perform the experiment. 
clear all;
% close all;
clc;
query0 = [10,3,4,5];
target0 = [10,10,3,4,5];

query1 = [1,2,8,16,16];
target1 = [1,2,8,16,9,25,37];

query2 = [1,2,8,4,6,8,5,6,7];
target2 = [1,2,23,8,6,8,9,32,8];

query3 = [1,2,8,8,8];
target3 = [1,2,9,95,79,26,39,31];

%  query4 is working fine
query4 = [1,2,8,8];
target4 = [1,2,15,15,15,8,8];

% query5 is working well here
query5 = [1,2,8,6,8];
target5 = [1,2,9,3,3,5,9];

% query6 is working well here
query6 = [1,2,8,16,81];
target6 = [1,2,9,9,9,25,37];

% query7 is working well here
query7 = [10,2,8,8];
target7 = [10,10,95,2,95,8,95,8,95];


%% designed to check OSB version of FSM
query8 = [1,2,3,49,12,9];
target8 = [1,1,2,3,9,12,12,9,9];

query9 = [1,2,3,49,12,9];
target9 = [123,233,23,233,143,73, 1,2,3,49,12,9,123,233,23,233,143,73]; % for SSDTW 

query9_1 = [1,2,3,49,34,12,9];
target9_1 = [123,233,23,233,143,73,1,2,3,49,12,9,123,233,23,233,143,73]; % for SSDTW 

query9_2 = [1,2,3,49,34,12,9];
target9_2 = [123,233,23,233,143,73, 1,2,3,49,64,12,9,123,233,23,233,143,73]; % for SSDTW 

query9_3 = [1,2,3,49,64,34,12,9];
target9_3 = [123,233,23,233,143,73, 1,2,3,49,12,9,123,233,23,233,143,73]; % for SSDTW 

query9_4 = [1,25,2,3,49,64,34,12,9];
target9_4 = [123,233,23,233,143,73, 1,2,3,49,12,9,123,233,23,233,143,73]; % for SSDTW 

query10 = [2,8,64,49,12,8];
target10 = [2,9,5,8,5,9,233,23,233,143,73];

query11 = [2 8 6 8 4 5 6];
target11 = [2 8 6 8 66 565 4 5 6];
 
query12 = [11 1 29 4 6 9 22 79 36];
target12 = [77 22 9 21 5 27 3 19 25 5 8 63 31];

query13 = [11 1 29 4 6 9 22 22 22];
target13 = [77 22 9 21 5 27 3 19 25 5 8 63 31];



query14 =  [1 1 1 1];
target14 = [8 8 8 8 8 1 1 1 8 8 8 8 8 8];

query15 =  [1 1 1 1];
target15 = [8 8 8 8 8 8 1 1 2 1 8 8 8 8];

query16 =  [1 1 1 1];
target16 = [8 8 8 8 8 1 2 1 8 8 8 8 8 8];

query17 =  [1 1 1 1];
target17 = [8 8 8 8 8 1 1 8 8 8 8 8 8 8];

query18 =  [1 1 1 1];
target18 = [8 8 8 8 8 1 2 8 8 8 8 8 8 8];

query19 =  [1 1 1 1];
target19 = [8 8 8 8 1 1 2 1 1 1 8 8 8 8];

query20 =  [1 1 1 1];
target20 = [8 8 8 8 1 1 8 1 1 1 8 8 8 8 8];




%%
%  [indxcol,indxrow,mini] = cdp_1(query9', target9');
% [res2,~,dist,pathMat] = cdp_2(query', target');


% [~,~,indxcol,indxrow,dist] = MinimalVarianceMatching(query2', target2',1);
% [~,indxcol,indxrow] = DynamicTimeWarping(query2', target2',1);

% [pathCost1,pathTarget1,indxcol1,indxrow1,distSum1,jumpcost1] = MVM_Updated_17_6_normTech_1(query11', target11',1);
[pathCost,pathTarget,indxcol,indxrow,distSum,jumpcost] = MVM_Updated_17_4(query8', target8',1);
% [pathCost,pathTarget,indxcol,indxrow,distSum,jumpcost] = MVM_Updated_7(query', target',1);

% [pathCost1,pathTarget1,indxcol1,indxrow1,distSum1,jumpcost1] = MVM_Updated_21(query', target',1);
