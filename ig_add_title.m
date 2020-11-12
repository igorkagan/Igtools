function ig_add_title(str,add_to_front,varargin)
%IG_ADD_TITLE		- add string to existing title

if nargin < 2,
	add_to_front = 0;
end

old_str = get(get(gca,'Title'),'String');
if add_to_front
    if size(old_str,1) > 1
        title(char(char(str),char(old_str)),varargin{:});
    else
        title([str old_str],varargin{:});
    end
else
    if size(old_str,1) > 1
        title(char(char(old_str),char(str)),varargin{:});
    else
        title([old_str str],varargin{:});
    end
end
