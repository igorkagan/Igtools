function ig_convert_all_mat_to_single(rootDir)
    if nargin < 1
        rootDir = uigetdir(pwd, 'Select Root Directory');
        if rootDir == 0
            disp('No directory selected. Exiting.');
            return;
        end
    end

    % Get list of all .mat files in the directory and its subdirectories
    matFiles = getAllMatFiles(rootDir);
    
    % Loop through each .mat file
    for i = 1:length(matFiles)
        matFilePath = matFiles{i};
        fprintf('Processing: %s', matFilePath);
        
        % Load data from the .mat file
        data = load(matFilePath);
        varNames = fieldnames(data);
                
        % Loop through each variable and convert double to single
        hasDouble = false;
        for j = 1:length(varNames)
            varName = varNames{j};
            % Convert only double variables to single
            if isa(data.(varName), 'double')
                hasDouble = true;
                data.(varName) = single(data.(varName));
            end
        end
        
        if hasDouble
            % Save the modified data back to the same file
            save(matFilePath, '-struct', 'data');
            fprintf(' -> converted\n');
        else
            fprintf('\n');
        end
        
    end
end

function matFiles = getAllMatFiles(directory)
    % Recursively get all .mat files in the directory and its subdirectories
    matFiles = {};
    files = dir(directory);
    
    for i = 1:length(files)
        if files(i).isdir && ~strcmp(files(i).name, '.') && ~strcmp(files(i).name, '..')
            % Recursively search in subdirectories
            subDirFiles = getAllMatFiles(fullfile(directory, files(i).name));
            matFiles = [matFiles; subDirFiles];
        elseif ~strcmp(files(i).name, '.') && ~strcmp(files(i).name, '..') && strcmp(files(i).name(end-3:end), '.mat')
            % Add .mat file to the list
            matFiles{end+1, 1} = fullfile(directory, files(i).name);
        end
    end
end