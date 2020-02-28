function ig_add_prefix_to_toolbox(toolbox_path, prefix, pattern2take, pattern2avoid)
%IG_ADD_PREFIX_TO_TOOLBOX		- add prefix to all instances of functions in the toolbox, in file names and code
% Example: ig_add_prefix_to_toolbox('D:\Sources\MATLAB\bv - Copy', 'bv_', '*.m', 'bvqxt_'); % add bv_ but exclude functions with bvqxt_

if nargin < 3,
    pattern2take = '*.m';
end

if nargin < 4,
    pattern2avoid = '';
end


% recursive function

files = dir([toolbox_path filesep pattern2take]);
d = dir(toolbox_path); d = d([d.isdir]); d(1:2) = [];

for f = 1:numel(files)
    
    fname = files(f).name;
    
    if isempty(strfind(fname,pattern2avoid)),
        if strncmp(prefix,fname,numel(prefix)) % fname already contains prefix
            funcname = fname(numel(prefix)+1:end-2);
        else
            funcname = fname(1:end-2);
        end
        
        % add prefix tp funcname in all files
        disp(['replacing ' funcname ' with ' prefix funcname]);
        for ff = 1:numel(files)
            fname = files(ff).name;
            
            fid = fopen([toolbox_path filesep fname],'rt');
            s = fread(fid);
            fclose(fid);
            
            new_s = regexprep(char(s'), ['\<' funcname '\>'], [prefix funcname]);
            
            fid = fopen([toolbox_path filesep fname],'wt');
            fwrite(fid,new_s);
            fclose(fid);
        end
    end

end

% now rename files
for f = 1:numel(files)
    fname = files(f).name;
    if ~strncmp(prefix,fname,numel(prefix)) && isempty(strfind(fname,pattern2avoid)), % fname does not contains prefix and does not contain pattern2avoid
        newname =   [prefix fname];
        movefile([toolbox_path filesep fname],[toolbox_path filesep newname]);
        disp(['renamed ' toolbox_path filesep fname '->' toolbox_path filesep newname]);
    end
end

% proceed recursively
for k = 1:numel(d),
    ig_add_prefix_to_toolbox([toolbox_path filesep d(k).name], prefix, pattern2take, pattern2avoid);
end


