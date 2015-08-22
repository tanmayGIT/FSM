function totlArr = cellToArrForPlot(cellArr)
totCellLen = length(cellArr);
totlArr = cell(totCellLen,1);
for p = 1:1:totCellLen
    myArr = cellArr{p,1};
    width = 3;
    onlyArr = zeros(length(myArr),width);
    for i = 1:1:length(myArr)
        onlyArr(i,1) = myArr{i,1};
        onlyArr(i,2) = myArr{i,2};
        onlyArr(i,3) = myArr{i,3};
    end
    totlArr{p,1} = onlyArr;
end
return;
end