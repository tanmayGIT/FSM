function [x,y] = getUpperPixels(line)

% GETLOWERPIXELS. This function iterates from bottom to top and itretrieves
% the first black pixel found for every column. This black pixel correspond
% to the lowest one in the column.

    if ~islogical(line)
        line = im2bw(line);
    end

    x = [];
    y = [];

    count = 1;

    % Horizontal iteration
    for i = 1:size(line,2)
        not_found = 1;
        j = 0;
       
        % Iterate from bottom to top until we reach top or a pixel
        while(not_found == 1 && j < size(line,1))
            j = j + 1;
            not_found = line(j,i);
        end
       
        % Store position
        if(~not_found)
            x(count) = i;
            y(count) = j;
            count = count+1;
        end
    end
   
end
