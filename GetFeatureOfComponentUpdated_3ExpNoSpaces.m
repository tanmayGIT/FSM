% Here foreground pixel is denoted by 1 and background pixel is denoted by 0
function [nospaceRefinedStorFearureMat,nospaceLukUpTableForRealIndex] = GetFeatureOfComponentUpdated_3ExpNoSpaces(componentImg,fullImg)

[nRows,nCols] = size(componentImg);
storFeatureMat = zeros(nCols,8);
storTopIndex = zeros(nCols,3);
storBottomIndex = zeros(nCols,3);

storForeGroundCGforCol = zeros(nCols,3);
if(~isempty(componentImg))
    foreGroundColCnt = 0;
    for getCol = 1:1:nCols
        calTransition = 0;
        nEdgePixels = 0;
        pixelFlag = 0;
        sumEdgePixels = zeros(nRows,1);
        storRwColOfEdgePixels = zeros(nRows,2);
        for getRwPixels = 1:1:nRows % starting from minimum row to maximum row, sum all pixels in between them
            if((componentImg(getRwPixels,getCol)) == 1)
                if(pixelFlag == 0)
                    storTopIndex(getCol,1) = (getRwPixels); % storing the row
                    storTopIndex(getCol,2) = (getCol); % storing the col
                    storTopIndex(getCol,3) = (getRwPixels-1)^2; % as it is on the same col, so cols are not participated in disance calculation
                    pixelFlag = 1;
                elseif(pixelFlag == 1)
                    storBottomIndex(getCol,1) = (getRwPixels); % storing the row
                    storBottomIndex(getCol,2) = (getCol); % storing the col
                    storBottomIndex(getCol,3) = (getRwPixels-nRows)^2; % calculation of distance
                end
                sumEdgePixels(getRwPixels,1) = (255 -  (fullImg(getRwPixels, getCol))); % for edge pixels only
                nEdgePixels = nEdgePixels + 1;
                storRwColOfEdgePixels(nEdgePixels,1) = getRwPixels;
                storRwColOfEdgePixels(nEdgePixels,2) = getCol;
            end
            
            if(getRwPixels> 1)
                if ((((componentImg((getRwPixels),(getCol))==1))&&...
                        ((componentImg(((getRwPixels)-1),(getCol))==0))))% AS WE WANT ONLY BACK GROUND TO INK TRANSITION     
                    calTransition = calTransition+1;
                end
            end
        end        
        if(nEdgePixels == 1) % If only one pixel exists in the col, then bottom pixel will also be same as top pixel
            storBottomIndex(getCol,1) = storTopIndex(getCol,1);
            storBottomIndex(getCol,2) = storTopIndex(getCol,2);
            storBottomIndex(getCol,3) = (getRwPixels-nRows)^2;
        end
        if(nEdgePixels > 0)
            storRwColOfEdgePixels = storRwColOfEdgePixels(1:(nEdgePixels),:);
            cgOfRw = (sum(storRwColOfEdgePixels(:,1))) /(size(storRwColOfEdgePixels,1));
            cgOfCol = storRwColOfEdgePixels(1,2);
            
            foreGroundColCnt = foreGroundColCnt +1;
            storForeGroundCGforCol(foreGroundColCnt,1) = round(cgOfRw);
            storForeGroundCGforCol(foreGroundColCnt,2) = round(cgOfCol);
            storForeGroundCGforCol(foreGroundColCnt,3) = getCol;
            % Binary level features
            storFeatureMat(getCol,1) = sum(sumEdgePixels)/nRows;
            storFeatureMat(getCol,2) = nEdgePixels/nRows; % projection profile 
            storFeatureMat(getCol,3) = storTopIndex(getCol,3)/(size(componentImg,1));% storing the upper profile; as we are calculating the
            storFeatureMat(getCol,4) = storBottomIndex(getCol,3)/(size(componentImg,1)); % storing the lower profile;as we are calculating the
            storFeatureMat(getCol,5) = ( storBottomIndex(getCol,3) - storTopIndex(getCol,3) )/(size(componentImg,1));
            storFeatureMat(getCol,6) = calTransition / 10;
            storFeatureMat(getCol,7) = cgOfRw/nRows; 
        end
    end
    
    storForeGroundCGforCol = storForeGroundCGforCol(1:foreGroundColCnt,:);
    for ii = 1:1:foreGroundColCnt    
        if(ii > 1)
            if(((componentImg((storForeGroundCGforCol(ii,1)),(storForeGroundCGforCol(ii,2))) == 0) &&...
                    (componentImg((storForeGroundCGforCol(ii-1,1)),(storForeGroundCGforCol(ii-1,2))) == 1)) ||...
                    ((componentImg((storForeGroundCGforCol(ii,1)),(storForeGroundCGforCol(ii,2))) == 1) &&...
                    (componentImg((storForeGroundCGforCol(ii-1,1)),(storForeGroundCGforCol(ii-1,2))) == 0)))
                storFeatureMat((storForeGroundCGforCol(ii,1)),8) = 3; % stroing the transition of the CG of each forground pixels in the column
            else
                storFeatureMat((storForeGroundCGforCol(ii,1)),8) = 2; % if there is no transition but this col have foreground pixel
            end
        end
    end
    
    % For spline interpolation 
    non0Rw = find(storFeatureMat(:,1));
    Xinter = non0Rw;

    for pii = 1:1:5
        Yinter = storFeatureMat(non0Rw,pii);
        Xreq = setdiff(1:nCols,Xinter,'rows');
        Yereq = interp1(Xinter,Yinter,Xreq,'nearest');
        storFeatureMat(Xreq,pii) = Yereq;
    end
    
    refinedStorFearureMat = zeros(nCols,(size(storFeatureMat,2)));
    lukUpTableForRealIndex = zeros(nCols,1);
    
    for h = 1:1:nCols
        refinedStorFearureMat(h,:) = storFeatureMat(h,:);
        lukUpTableForRealIndex(h,1) = h;    
    end
    
    for h = 1:1:nCols
        for gh = 1:1:size(storFeatureMat,2)
            val = refinedStorFearureMat(h,gh);
            if(isnan(val))
                refinedStorFearureMat(h,gh) = 0;
            end
        end
    end
    
    nospaceRefinedStorFearureMat = refinedStorFearureMat(storForeGroundCGforCol(:,3),:);
    nospaceLukUpTableForRealIndex = lukUpTableForRealIndex(storForeGroundCGforCol(:,3),:);
    
end
return;
end
function outmom = raw_moments(im,i,j)
    outmom = sum(sum( ((1:size(im,1))'.^j * (1:size(im,2)).^i) .* im ));
end

function cmom = central_moments(im,i,j)
    rawm00 = raw_moments(im,0,0);
    centroids = [raw_moments(im,1,0)/rawm00 , raw_moments(im,0,1)/rawm00];
    cmom = sum(sum( (([1:size(im,1)]-centroids(2))'.^j * ...
                     ([1:size(im,2)]-centroids(1)).^i) .* im ));
end