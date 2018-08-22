function [I_row,J_col,boxRect] = ig_find_matrix_within_larger_matrix(small_matrix, large_matrix, TOPLOT)
%IG_FIND_MATRIX_WITHIN_LARGER_MATRIX		- find small 1D or 2D matrix within larger 1D or 2D matrix
% I_row, J_col	- indices within large_matrix corresponding to small matrix (large_matrix(I_row,J_col) will result in small_matrix)
% boxRect	- [xLeft, yTop, widthInColumns, heightInRows]
% inspired by https://de.mathworks.com/matlabcentral/answers/uploaded_files/33783/normxcorr2_demo.m
% Example:
% large_matrix = rand(20,10)
% small_matrix = large_matrix(2:5,3:4) % start at y 2, x 3
% [I_row,J_col,boxRect] = ig_find_matrix_within_larger_matrix(small_matrix,large_matrix,1) 
% I_row =
%      2     3     4     5
% J_col =
%      3     4
% boxRect =
%      3     2     2     4

if length(size(large_matrix)) > 2 || length(size(small_matrix)) > 2,
	disp('Matrices should be 1D or 2D, exiting!');
	return;
end

if any(size(small_matrix) > size(large_matrix)),
	disp('First matrix should be smaller than 2nd (large) matrix, exiting!');
	return;
end

if nargin < 3,
	TOPLOT = 0;
end

[small_height small_width] = size(small_matrix); % y - height - rows, x - width - columns

correlationOutput = normxcorr2(small_matrix, large_matrix);
[maxCorrValue, maxIndex] = max(abs(correlationOutput(:)));
[yPeak, xPeak] = ind2sub(size(correlationOutput),maxIndex(1));
% Cross-correlation increases the size of the image, 
% so we need to shift to find the peak in original image
corr_offset = [(xPeak-small_width+1) (yPeak-small_height+1)];

% Calculate the rectangle [xLeft, yTop, widthInColumns, heightInRows]
boxRect = [corr_offset(1) corr_offset(2) small_width small_height];
I_row = [corr_offset(2):corr_offset(2)+small_height-1];
J_col = [corr_offset(1):corr_offset(1)+small_width-1];


if TOPLOT
	imagesc(large_matrix);
	colormap(gray);
	axis image
	% Plot the box over the image.
	rectangle('position', [corr_offset(1)-0.5 corr_offset(2)-0.5 small_width small_height], 'edgecolor', 'g', 'linewidth',2);
end
