function [line] = removeBlackCorners(line)

% REMOVEBLACKCORNERS eliminates the black corners created by imrotate or
% any transformation in Matlab

    bw = line;

    [n m, ~] = size(line);

    steps_X = [+1, -1, +1, -1];
    steps_Y = [+1, +1, -1, -1];
   
    start_X = [1, n, 1, n];
    end_X = [n, 1, n, 1];
   
    start_Y = [1, 1, m, m];
    end_Y = [m, m, 1, 1];
   
    for c = 1:4        
        for i = start_X(c): steps_X(c) : end_X(c)
            for j = start_Y(c) : steps_Y(c) : end_Y(c)
                if bw(i,j,:) ~= 0
                    line(i,j,:) = 255;
                    break
                else
                    line(i,j,:) = 255;
                end
            end
        end
    end


end