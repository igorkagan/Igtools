function ig_merge_pdfs(pdf_path,merged_pdf_name)
%IG_MERGE_PDFS		- merge pdfs, using pdftk tools 
% http://www.pdflabs.com/tools/pdftk-the-pdf-toolkit/

if nargin < 2,
	merged_pdf_name = 'merged.pdf';
end

ori_dir = pwd;

cd('C:\Program Files (x86)\pDFtk\bin');

eval(['!pdftk ' pdf_path '\*.pdf cat output  ' pdf_path '\' merged_pdf_name]);


cd(ori_dir);

