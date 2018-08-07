function ig_add2axis_label(label,str,add_to_front,varargin)
%IG_ADD2AXIS_LABEL		- add string to existing axis label

if nargin < 3,
	add_to_front = 0;
end

label_h = get(gca,label);
old_str = get(label_h,'String');
if add_to_front
	set(label_h,'String',[str old_str],varargin{:});
else
	set(label_h,'String',[old_str str],varargin{:});
end
