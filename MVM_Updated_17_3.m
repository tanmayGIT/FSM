% In this code, the code is completely same as MVM_Updated_17_2 but here I
% just changed the size of the matrices. Now the matrices are of the same
% size i.e. not extra row is added here 

function [pathCost,pathTarget,indxcol,indxrow,distSum,jumpcost] = MVM_Updated_17_3(refSample,testSample,weight,straight)
pathTarget = 1;
[noOfSamplesInRefSample,N] = size(refSample);
[noOfSamplesInTestSample,M] = size(testSample);

if(noOfSamplesInRefSample == 0)
    disp('This is unwanted/unknown error');
end

if(N == M)
    Dist = zeros(noOfSamplesInRefSample,noOfSamplesInTestSample);
    pathCost = inf(noOfSamplesInRefSample,noOfSamplesInTestSample);
    pathTargetRw = zeros(noOfSamplesInRefSample,noOfSamplesInTestSample);
    pathTargetCol = zeros(noOfSamplesInRefSample,noOfSamplesInTestSample);
    jumpMat = zeros(noOfSamplesInRefSample,noOfSamplesInTestSample); % the value in this matrix wil be 1 if it is nit jumping any row, other wise it will be -1
    
    for i=1:noOfSamplesInRefSample
        for jick=1:noOfSamplesInTestSample
            total = zeros(N,1);
            for goFeature = 1:N
                total(goFeature,1) = (double((refSample(i,goFeature)-testSample(jick,goFeature))^2));
            end
            
            Dist(i,jick) = sqrt(sum(total));
        end
    end
    fullElasticity = noOfSamplesInTestSample;
    elasticity = (noOfSamplesInTestSample - noOfSamplesInRefSample);
    if(elasticity == 0)
        elasticity = 2;
    end
    
    if (~exist('jumpcost','var'))
        statmatx = min(Dist,[],2);
        [~,~,statmatx] = find(statmatx);
        if(isempty(statmatx))
            jumpcost = 0;
        else
            jumpcost = ( (mean(statmatx)+ 1*std(statmatx)) );
        end
    end
    if(jumpcost<1) % Only add unity matrix, if and only if jumpcost <1 
        grac = ones(noOfSamplesInRefSample,noOfSamplesInTestSample);
        Dist = Dist + grac;  %  0.335^3 = 0.0376 : bcoz of this reason we need to add by 1, so if we are using power for calculating jumpCost then it is necessary to add by 1 otherwise the technique will not work
        statmatx = min(Dist,[],2);
        [~,~,statmatx] = find(statmatx);
        if(isempty(statmatx))
            jumpcost = 0;
        else
            jumpcost = ( (mean(statmatx)+ 1*std(statmatx)) );
        end
    end
        
    if(noOfSamplesInTestSample >= noOfSamplesInRefSample)
        pathCost(1,:) =   Dist(1,:) ;
        jumpMat(1,:) = 1;
%       for performing one to many matching in the first row itself
%       There is no meaning of doing this, as the following condition will not ever be satisfied
%         for tt = 2:1:noOfSamplesInRefSample
%             takeMin = max(1,tt-1);
%             if( (pathCost(1,tt) >= (pathCost(1,takeMin) + Dist(1,tt)))  )
%                 pathCost(1,tt) =   pathCost(1,takeMin) + Dist(1,tt) ;
%                 pathTargetRw(1,tt) = 1;
%                 pathTargetCol(1,tt) = tt-1;
%                 jumpMat(1,tt) = 1;
%             end
%         end
        for i = 2:1:noOfSamplesInRefSample
            if(i == 2)
                stopMotherRight = min((i-1+(fullElasticity)),noOfSamplesInTestSample);
                stopMotherLeft = max(((i-1)-(fullElasticity)),1);
            else
                stopMotherRight = min((i-1+(elasticity)),noOfSamplesInTestSample);
                stopMotherLeft = max(((i-1)-(elasticity)),1);
            end
            for k = stopMotherLeft:1:stopMotherRight
                stopj = min(((k+1+elasticity)-(abs(k-(i-1)))),noOfSamplesInTestSample);
                stopLeft  = max(k,1);
                for j = (stopLeft):1:stopj
                    if ((j-(k+1)) <= 0)
                        costJump = 0;
                    else
                        costJump = jumpcost*(weight*(abs(j-(k+1))));
                    end
                    if(jumpcost~=0)
                        [valMn,indxMn] = min([Dist(i,j),(jumpcost)]);
                    else
                        indxMn = 1;
                        valMn = Dist(i,j);
                    end
                    if( (jumpMat(i-1,k) == 1)&&(indxMn == 1) ) % the normal condition
                        if ( pathCost(i,j) > (pathCost(i-1,k) + costJump + valMn) )
                            pathCost(i,j) = pathCost(i-1,k) + costJump + valMn;
                            pathTargetRw(i,j) = i-1;
                            pathTargetCol(i,j) = k;
                            jumpMat(i,j) = 1;
                        end
                    elseif( (jumpMat(i-1,k) == 1)&&(indxMn == 2) )
                        if ( pathCost(i,j) > (pathCost(i-1,k) + costJump + valMn) )
                            pathCost(i,j) = pathCost(i-1,k) + costJump + valMn;
                            pathTargetRw(i,j) = i-1;
                            pathTargetCol(i,j) = k;
                            jumpMat(i,j) = -1;
                        end
                    elseif( (jumpMat(i-1,k) == -1) && (indxMn == 1) ) % when we want to skip the outlier
                        if ( pathCost(i,j) > (pathCost(i-1,k) + costJump + valMn) )
                            pathCost(i,j) = pathCost(i-1,k) + costJump + valMn;
                            pathTargetRw(i,j) = pathTargetRw(i-1,k); % keeping the value which was at the skipped cell
                            pathTargetCol(i,j) = pathTargetCol(i-1,k);
                            jumpMat(i,j) = 1;
                        end
                    elseif( (jumpMat(i-1,k) == -1) && (indxMn == 2) )
                        if ( pathCost(i,j) > (pathCost(i-1,k) + costJump + valMn) )
                            pathCost(i,j) = pathCost(i-1,k) + costJump + valMn;
                            pathTargetRw(i,j) = pathTargetRw(i-1,k); % keeping the value which was at the skipped cell
                            pathTargetCol(i,j) = pathTargetCol(i-1,k);
                            jumpMat(i,j) = -1;
                        end
                    end
                    takeMin = max(1,j-1);
                    if( (pathCost(i,j) >= (pathCost(i,takeMin) + Dist(i,j)))  )
                        pathCost(i,j) =   pathCost(i,takeMin) + Dist(i,j) ;
                        pathTargetRw(i,j) = i;
                        pathTargetCol(i,j) = j-1;
                        jumpMat(i,j) = 1;
                    end
                end
            end
        end
        
        lastElasticity = max((noOfSamplesInRefSample),1);
        [minVal,~] = min(pathCost(noOfSamplesInRefSample,lastElasticity:noOfSamplesInTestSample));
        tempArr = pathCost(noOfSamplesInRefSample,lastElasticity:noOfSamplesInTestSample);
        ind = find(tempArr == minVal);
        indices = max(ind); % Taking the distant element
        
        mincol = (lastElasticity-1)+indices;
        minrow = noOfSamplesInRefSample;
        Wrapped =[];
        
        while (minrow>=1 && mincol>=1)
            if(jumpMat(minrow,mincol) == -1) % by this way, you can skip the last element of target also
                mincolTemp = pathTargetCol(minrow,mincol); % going to the previous link
                minrow = pathTargetRw(minrow,mincol); % going to the previous link
                mincol = mincolTemp; % going to the previous link
            else
                Wrapped = cat(1,[minrow,mincol],Wrapped);
                if(minrow == 1)&&(mincol == 1)
                    break;
                end
                mincolTemp = pathTargetCol(minrow,mincol);
                minrow = pathTargetRw(minrow,mincol);
                mincol = mincolTemp;
            end
        end
        indxrow = Wrapped(:,1);
%         indxrow = indxrow(2:end,1);
        indxcol = Wrapped(:,2);
%         indxcol = indxcol(2:end,1);
        distSum = pathCost(indxrow(end,1),indxcol(end,1));
        distSum = ((distSum))/(size(indxcol,1));
%         indxrow = indxrow - 1;
        return
    end
end