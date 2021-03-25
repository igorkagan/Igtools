function ig_check_files(file_list)
%IG_CHECK_FILES		- checks if files exist

for f = 1:length(file_list),
    if ~exist(file_list{f},'file'),
        disp([file_list{f} ' does not exist.']);
    end
end

