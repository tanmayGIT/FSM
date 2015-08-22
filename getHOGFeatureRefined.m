function [updatedFeatureMat,updatedRealColInfo] = getHOGFeatureRefined(greyImg,binImg,avgWidth)
[nRw,nCol] = size(greyImg);
avgWidth = round(avgWidth);
% Now we try to divide the image using avgWidth, if the image width can be
% truly divided by the avgWidth, then it is very good but it is a bit hard
% to happen
% So, here our techique is to get the residue after division by avgWidth, if
% the residue is 0 then it is well and good if not then we look into the
% reside and see whether the residue is less than (avgWidth/2), if it is
% then that residue would be added with the last slice and if not then we
% will consider anothe slice and the width of the slice will be equal to
% the residue

% Number of cells do you want
% H = 4;% Number of cells in Y direction or in height
% W = 2;% Number of cells in X direction or in width
%
% % Number of cells do you want per block
% % Try to keek this parameter as even as we want that 50% overlap
% % between the blocks
% h = 2;
% w = 2;
%
% % Number of orientation
% nOri = 9;
%
% nFeaturePerSlice = ((H-h+1)*(W-w+1)) * (h*w) * nOri;

% divRem = rem(nCol,avgWidth);
% nSlice = (nCol - divRem)/avgWidth;

BlockSize = [2 2];
BlockOverlap = ceil(BlockSize/2) ;
CellSize = [8 8];
NumBins = 9;
BlocksPerImage = floor(([nRw avgWidth]./CellSize-BlockSize)./(BlockSize-BlockOverlap)+ 1);
N = prod([BlocksPerImage BlockSize NumBins]);

featureMat = zeros(1,N+2);
realColInfo = zeros(1,2); % This wil keep the information start column and end column of slice

% when the (divRem < (avgWidth/2))
% if((addedSlice == 0)&&(divRem ~= 0))
eachslice = 1;
for j = 1:(round(avgWidth/2)):(nCol-(avgWidth)) % so basically here we are subtracting the last slice, as the last slice will be bigger in width
    if(j <nCol)
        slicedImg = greyImg(:,j:(j+avgWidth-1));
        slicedBinImg = binImg(:,j:(j+avgWidth-1));
        if(nnz(slicedBinImg)> ( ((size(slicedBinImg,1))*(size(slicedBinImg,2)))*(10/100) ) )
            [topRw,botRow,leftCol,rightCol,~] = getBoundaryOfSlice(slicedBinImg);
            cgX = round((botRow-topRw)/2);
            cgY = round((rightCol-leftCol)/2);
            %             slicedImg = slicedImg(topRw:botRow,leftCol:rightCol);
            sliceFeature = extractHOGFeatures(slicedImg,'UseSignedOrientation',true);
            sliceFeature(1,N+1) = cgX;
            sliceFeature(1,N+2) = cgY;
            %             sliceFeature = getBlocksFromSlice(slicedImg,H,W,h,w,nOri);
            featureMat(eachslice,:) = sliceFeature;
            realColInfo(eachslice,1) = j;
            realColInfo(eachslice,2) = (j+avgWidth-1);
            eachslice = eachslice +1;
        end
    end
end
lastJ = j+avgWidth;
slicedImg = greyImg(:,(lastJ-(round(avgWidth/2))):end);
slicedImg = imresize(slicedImg,[nRw,avgWidth]);
slicedBinImg = binImg(:,(lastJ-(round(avgWidth/2))):end);
slicedBinImg = imresize(slicedBinImg,[nRw,avgWidth]);

if(nnz(slicedBinImg)> ( ((size(slicedBinImg,1))*(size(slicedBinImg,2)))*(10/100) ) )
    [topRw,botRow,leftCol,rightCol,~] = getBoundaryOfSlice(slicedBinImg);
    cgX = round((botRow-topRw)/2);
    cgY = round((rightCol-leftCol)/2);
    %         slicedImg = slicedImg(topRw:botRow,leftCol:rightCol);
    sliceFeature = extractHOGFeatures(slicedImg,'UseSignedOrientation',true);
    sliceFeature(1,N+1) = cgX;
    sliceFeature(1,N+2) = cgY;
    %         sliceFeature = getBlocksFromSlice(slicedImg,H,W,h,w,nOri);
    featureMat(eachslice,:) = sliceFeature;
    realColInfo(eachslice,1) = lastJ;
    realColInfo(eachslice,2) = nCol;
end
updatedRealColInfo = zeros(1,2);
updatedFeatureMat = zeros(1,N+2);
no_0 = 1;
for remove0 = 1:1:length(realColInfo)
    if(realColInfo(remove0,1) ~= 0)
        updatedRealColInfo(no_0,:) = realColInfo(remove0,:);
        updatedFeatureMat(no_0,:) = featureMat(remove0,:);
        no_0 = no_0 +1;
    end
end

return;
end

function [topRw,botRow,leftCol,rightCol,pixelList] = getBoundaryOfSlice(beforeRLSATest)
[sz1,sz2] = size(beforeRLSATest);
topRw =  1;
botRow = sz1;
leftCol = 1;
rightCol = sz2;
% Finding the top row
flag = 0;
for topI = 1:1:sz1
    for topJ = 1:1:sz2
        if(beforeRLSATest(topI,topJ) == 1)
            topRw = topI;
            flag = 1;
            break;
        end
    end
    if(flag == 1)
        break;
    end
end

% Finding the bottom row
flag = 0;
for topI = sz1:-1:1
    for topJ = 1:1:sz2
        if(beforeRLSATest(topI,topJ) == 1)
            botRow = topI;
            flag = 1;
            break;
        end
    end
    if(flag == 1)
        break;
    end
end
% Finding the left col
flag = 0;

for topJ = 1:1:sz2
    for topI = 1:1:sz1
        if(beforeRLSATest(topI,topJ) == 1)
            leftCol = topJ;
            flag = 1;
            break;
        end
    end
    if(flag == 1)
        break;
    end
    
end
% Finding the right Col
flag = 0;

for topJ = sz2:-1:1
    for topI = 1:1:sz1
        if(beforeRLSATest(topI,topJ) == 1)
            rightCol = topJ;
            flag = 1;
            break;
        end
    end
    if(flag == 1)
        break;
    end
end

pixelList = zeros(1,2);
t1 = 1;
for i = topRw:1:botRow
    for j = leftCol:1:rightCol
        if(beforeRLSATest(i,j)~=0)
            pixelList(t1,1) = j;
            pixelList(t1,2) = i;
            t1 = t1+1;
        end
    end
end

% componentImg = beforeRLSATest(topRw:botRow,leftCol:rightCol);
return
end