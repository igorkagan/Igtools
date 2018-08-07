function add_vertical_line(x,varargin)
mfile_name = mfilename; disp_ig_warning(mfile_name);
ylim = get(gca,'ylim');
line([x x],[ylim(1) ylim(2)],varargin{:});

