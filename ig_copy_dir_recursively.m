function ig_copy_dir_recursively(source_folder, target_folder, dir_patterns2exclude, file_patterns2exclude, patterns2include)
%IG_COPY_DIR_RECURSIVELY		- copy directories and files from source folder to target folder
% ig_copy_dir_recursively('Y:\IgorBackup\D\MRI\Human.Caltech\IK','C:\Temp\IK','run0','.dcm');
% ig_copy_dir_recursively('D:\MRI\Human\fMRI-reach-decision\Experiment\TAL\CLSC','Y:\MRI\Human\fMRI-reach-decision\Experiment\TAL\CLSC','hum_','.dcm');

if nargin < 3,
    dir_patterns2exclude = '';
end

if nargin < 4,
    file_patterns2exclude = '';
end

if nargin < 5,
    patterns2include = '*';
end

d = dir([source_folder filesep patterns2include]);

if size(d,1) > 2, % not empty
    mkdir(target_folder);
    for k = 3:length(d)
        if d(k).isdir && isempty(regexp(d(k).name,dir_patterns2exclude, 'once'))
            ig_copy_dir_recursively([source_folder filesep d(k).name], [target_folder filesep d(k).name], dir_patterns2exclude, file_patterns2exclude, patterns2include);
        elseif ~d(k).isdir && isempty(regexp(d(k).name,file_patterns2exclude, 'once'))
            fprintf('copying %s -> %s\n',[source_folder filesep d(k).name],[target_folder filesep d(k).name]);
            copyfile([source_folder filesep d(k).name],[target_folder filesep d(k).name]);
        end
        
    end
end
