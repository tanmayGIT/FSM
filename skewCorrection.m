function [final_line, slope, baseline] = skewCorrection(line)

% SKEWCORRECT. This function takes a line as input and it returnes a new
% line with corrected skew and the baseline.

    bw_line = line; %im2bw(line, 0.8);
    [x, y] = getLowerPixels(bw_line);
     
    % Filter irrelevant pixels (those could create noise)
%     [x, y] = filterPixels(x, y, bw_line);

    % Linear regression
    p = polyfit(x, y, 1);

    width = size(line,2);

    % Show the image and baseline
    x_axis = (1:1:width);
%     f = polyval(p, x_axis);
%     figure(5), imshow(line);
%     hold on;
%     plot(x_axis, f, 'r');
%     scatter(x, y, 'x');
%     title('Linear regression (red line) of the lower pixels (blue points)');

    % Compute angle
    slope = atan(p(1))*180/pi;
   
    % Rotate image
    corrected_line = imrotate(line, slope);
   
    % Remove black pixels created by imrotate
    final_line = corrected_line;%removeBlackCorners(corrected_line);
   
    bw_line = im2bw(final_line);
    % Compute the new baseline
    [x,y] = getLowerPixels(bw_line);
%     [x, y] = filterPixels(x, y, bw_line);
    p = polyfit(x, y, 1);
    f = polyval(p, x_axis);
   
    baseline = f(ceil(size(f,2) / 2)) + 3;
         
%     % Show the image and baseline
%     x_axis = (1:1:size(final_line,2));
%     figure(6), imshow(final_line);
%     hold on, plot(x_axis, baseline, 'r');
%     title('Line with skew corrected');
%     scatter(x,y,'x');

end

