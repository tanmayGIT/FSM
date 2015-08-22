% the dp path is same as DTW
function [indxcol,indxrow,mini,P] = cdp_2(ref, stream)
[~,N] = size(ref);
Dist = zeros((size(stream,1)),(size(ref,1))); % Initializing the array
for i = 1:(size(stream,1)) %ySize
    for j = 1:(size(ref,1)) % xSize
        total = zeros(N,1);
        for goFeature = 1:N %or M as N & M are same
            total(goFeature,1) = (double((stream(i,goFeature) - ref(j,goFeature))^2));
        end
        Dist(i,j) = sqrt(sum(total));
    end
end
tau = 1;
mini = inf;
P = zeros((size(stream,1)),size(ref,1));

P(1,:) = inf;
P(2,:) = inf;

tic
p = Inf(size(stream,1),1);
minPos  = 1;
for t2 = 3:1:(size(stream,1))
    
    for tau = 1:1:size(ref,1)
        
        if (tau == 1)
            P(t2,tau) = (Dist(t2,tau));
        else
            temp = min(  P(t2-1,tau-1)+(Dist(t2,tau)),    P(t2-1,tau)+(Dist(t2,tau))  );
            P(t2,tau)= min(   temp,    P(t2,tau-1)+(Dist(t2,tau))    );
        end
    end
    compaDeno =  P(t2,tau)/((tau)); 
    if(compaDeno <mini)
        mini = compaDeno;
        minPos = t2;
    end
    p(t2) = compaDeno;
end
indxrow  = zeros(size(ref,1),1);
indxcol = zeros(size(ref,1),1);
if (minPos < size(ref,1))
    minPos = size(ref,1);
end
for rwCol = size(ref,1):-1:1
    indxrow(rwCol,1) = rwCol;
    indxcol(rwCol,1) = minPos;
    minPos = minPos -1 ;
end
return;
end