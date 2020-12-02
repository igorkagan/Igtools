function comment = ig_createHeaderComment_dag(hDocument, eventData)
%IG_CREATEHEADERCOMMENT_DAG		- adds mfile header template to currently open file in matlab editor
%
% USAGE:	
%		After opening MATLAB
%		1) >> EditorMacro('Alt-Control-h', @ig_createHeaderComment_dag);
%			Alternatively, add the above command to startup.m
%		2) PRESS Alt-Control-h while in MATLAB Editor (new or existing file)
% INPUTS:
%		hDocument	- exlanation
%		eventData	- exlanation
% OUTPUTS:	
%		comment		- explanation
%
% REQUIRES:	Igtools/External/EditorMacro (by Yair Altman)
%  
%
% See also EditorMacro
%
%
% Author:	Yair M. Altman: altmany(at)gmail.com
% URL:		http://www.mathworks.com/matlabcentral/fileexchange/24615-editormacro-assign-a-macro-to-a-keyboard-key-stroke-in-the-matlab-editor-and-command-window
%		http://undocumentedmatlab.com/blog/editormacro-assign-a-keyboard-macro-in-the-matlab-editor
% Modified by:	Igor Kagan, 2015
%
% ADDITIONAL INFO:
%
% Alternatives (ignore for now)
% http://www.mathworks.com/matlabcentral/fileexchange/27225-generate-a-new-function-m-file--with-documentation
% "The layout includes $Author, $Date and $Revision tags, which are automatically completed for you. 
% If you use CVS or SVN as your version control system, then checking in your file will automatically cause these fields to be updated."

%% DAG CODE TEMPLATE:
% functionname  - one line function description
%
% USAGE:	
%		usage example1;
%		usage example2;
%		...
% 
% INPUTS:
%		input 1		- explanation
%		...
%
% OUTPUTS:	
%		output1		- explanation
%		...
%
% REQUIRES:	...
%  
% See also ...
%
%
% Author(s):	..., DAG, DPZ
% URL:		http://www.dpz.eu/dag
% 
% Change log:
% yyyymmdd:	Created function (author's firstname familyname)
% ...
% $Revision: 1.0 $  $Date: 2011/01/31 20:47:25 $
%
% ADDITIONAL INFO:
% ...
%%

timestamp = datestr(now,31);
username = getenv('username');
%computer = getenv('computername');  % unused
lineStr = repmat('%',1,25);
comment = sprintf(...
['function ... = ...(...)\n'...
'%%functionname  - one line function description\n'	...
'%%\n'							...
'%% USAGE:\n'						...
'%% usage example1;\n'					...
'%% usage example2;\n'					...
'%%		...\n'					...
'%%\n'							...
'%% INPUTS:\n'						...
'%%		input 1		- explanation\n'		...
'%%		...\n'					...
'%%\n'							...
'%% OUTPUTS:\n'						...	
'%%		output1		- explanation\n'	...
'%%		...\n'					...						
'%%\n'							...
'%% REQUIRES:	...\n'					...
'%%\n'							...
'%% See also ...\n'					...
'%%\n'							...
'%%\n'							...
'%% Author(s):	%s, DAG, DPZ\n'				...
'%% URL:		http://www.dpz.eu/dag\n'	...
'%%\n'							... 
'%% Change log:\n'						...
'%% yyyymmdd:	Created function (Author(s) firstname familyname)\n'...
'%% ...\n'						...
'%% $Revision: 1.0 $  $Date: %s $\n'			...
'%%\n'							...
'%% ADDITIONAL INFO:\n'					...
'%% ...\n'						...
'%s[DAG mfile header version 1]%s \n'],			...
username, timestamp,lineStr,lineStr);

