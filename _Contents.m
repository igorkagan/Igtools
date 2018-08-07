% Igtools
% Version 2 08-Aug-2018
% Copyright 2002-2018 Igor Kagan, http://igorkagan.org
% $ Created on 08-Aug-2018 01:28:24 $
%  
%CC				- clear all; close all;
%IG_ADD2AXIS_LABEL		- add string to existing axis label
%IG_ADD_DIAGONAL_LINE		- add diagonal line to current axis 
%IG_ADD_EQUALITY_LINE		- add equality line
%IG_ADD_FILENAME_PREFIX		- add filename prefix
%IG_ADD_H1_LINE			- add h1 line
%IG_ADD_LINEAR_REGRESSION_LINE	- add linear regression line
%IG_ADD_MULTIPLE_VERTICAL_LINES	- add multiple vertical lines
%IG_ADD_RASTER			- add raster (short vertical line) plot for spike train to current axis
%IG_ADD_TITLE			- add string to existing title
%IG_ADD_VERTICAL_LINE		- add vertical line
%IG_ADD_ZERO_LINES		- add zero lines
%IG_ANALYZE_TRIAL_SEQUENCE	- analyze trial sequence
%IG_ARGIN_ERROR			- handles errors in argin
%IG_ASSIGN_STRUCT_FIELDS	- assign struct fields
%IG_BAR				- bar plot
%IG_BAR_MEAN_SE			- plots mean and sterr/std of a vector as a bar with error bars
%IG_CELLCMP			- compares two cell arrays
%IG_CHECK_NARGIN		- checks number of arguments in function
%IG_CLEAN_CONVOLVE		- clean convolve
%IG_CLOSE_CHILDLESS_FIGURES	- close childless figures
%IG_CM2DEG			- convert cm to degrees of visual angle
%IG_CM2MINARC			- convert cm to minutes of arc (minarc)
%IG_COHEN_D_NORAWDATA		- cohen d norawdata
%IG_COLORMAP2IND		- convert colormap to indices
%IG_COMASS			- finds center of mass of a uniform density polygon
%IG_CONDITION_PROBABILITY_TO_SEQUENCE		- condition probability to sequence
%IG_COPY_DIR			- copy all files in directory "fromdir" to directory "todir" except avoid
%IG_COPY_SPECIFIC_DIR		- copy specific_dir in directory "fromdir" to directory "todir"
%IG_COUNT2PER			- convert counts to percentages
%IG_CREATE_STRUCT_FIELDS	- create struct fields
%IG_CREATEHEADERCOMMENT_DAG	- adds mfile header template to currently open file in matlab editor
%IG_CV2				- coefficient of variation for 2 values
%IG_DDE2E			- DDE to Excel
%IG_DEG2CM			- convert deg to cm
%IG_DEG2RAD			- convert degrees to radians
%IG_DEL_COPY_DIR		- delete all files in "fromdir" directory except avoid, which is copied to directory "todir
%IG_DELGUI			- delete all GUI objects from figure
%IG_DISP			- disp only if verbose is not assigned
%IG_DMPLOT			- double marker plot
%IG_ELLIPSE			- draws ig_ellipse (a,b) at (x,y)
%IG_ERRORBAND			- errorband plot
%IG_ERRORBAR			- errorbar plot
%IG_FIGURE			- open figure with some predetermined settings and figure name
%IG_FIGURE_NAME			- add figure name
%IG_FIND_THRESHOLD_CROSSINGS	- finds crossings of threshold from below to above up_threshold and from above to below 
%IG_FULLRECTIFY			- full wave rectification
%IG_GET_FIGURE_AXES		- get figure axes
%IG_GET_HANDLE_TYPE		- get handles to a certain object type
%IG_GET_MULTICOMPARE_SIGNIFICANCE		- get multicompare significance
%IG_GRABIMAGE			- delete all objects from gca except for image (gco) (or any gco)
%IG_HARMONAL			- harmonic analysis of 1D signal, e.g. spike train
%IG_HIST2PER			- convert histogram count to percentages
%IG_IMAGE2PATCH			- converts MATLAB image to collection of patches
%IG_INSERT_VALUES_INTO_VECTOR	- insert values into vector
%IG_INSTALL			- add current directory to MATLAB path
%IG_INTERSECT3			- intersect between 3 sets
%IG_INTERSECT_CELLNAMES		- find intersection between two columns of cellnames from excel file
%IG_MAKE_CONTENTS		- creates or updates the Contents.m file in the current directory
%IG_MAKE_RASTER			- draws raster (short vertical line) plot for spike train
%IG_MAKE_TRAIN			- spike arrival times vector to spike train vector (0,1)
%IG_MEAN_NEG			- mean negative: replace positive entries in vector with NaN
%IG_MERGE_PDFS			- merge pdfs, using pdftk tools 
%IG_MINARC2CM			- convert minarc to cm
%IG_MLABEL			- add mlabel (xlabel, ylabel, title)
%IG_MOVEFILE			- movefile using java
%IG_MTT				- mtt: uses mtfft from neuran (old version of chronux)
%IG_MTT_TRIALS			- mtt trials: uses mtfft from neuran (old version of chronux)
%IG_NANSTE			- nanste (standard error ignoring NaNs)
%IG_NORMAL			- normalize vector s between mini and maxi
%IG_NORMALIZE			- normalize vector or 2D array
%IG_NUM2PER			- convert count to percentages
%IG_ORIENT_ALL			- orient all
%IG_PLOT_HISTY			- plot histogram on Y axis
%IG_PRINT_ALL			- print or save to file all MATLAB figures
%IG_PROBIT			- probit function
%IG_RECTIFY			- rectify the input
%IG_REMOVE_CONDITIONS4ANOVA	- remove conditions for anova
%IG_RENAME_FILES		- rename files
%IG_REPLACE_CONDITIONS4ANOVA	- replace conditions4anova
%IG_REPLACE_STR_IN_TEXTFILE	- replace str in textfile
%IG_REPLACE_STRING_IN_ALL_STRUCT_FIELDS		- replace string in all struct fields
%IG_RETURN_STRUCT_FIELDS	- return struct fields
%IG_RUNNING_AVERAGE		- running average
%IG_SACCADE_DIRECTION		- saccade direction
%IG_SAVEAS_ALL			- saveas all
%IG_SET_ALL_AXES		- set all axes to specific Xlim/Ylim/Zlim limit
%IG_SET_AXES_EQUAL_LIM		- set axes Xlim or Ylim to equal (min max of all)
%IG_SET_CAXIS_EQUAL_LIM		- set CAXIS equal (min max of all)
%IG_SET_CAXIS_EQUAL_LIM_FIGURES	- set caxis equal lim in all figures
%IG_SET_STRUCTURE_FIELDS_GUI	- set structure fields gui
%IG_SET_XY_AXES_EQUAL		- set axes Xlim and Ylim  equal (min max of all)
%IG_SINMODEL			- sine waveform fit (for use with nlinfit)
%IG_SMOOTH			- smooth signal by convolving with Gaussian bell
%IG_SPECTRUM			- spectrum
%IG_ST				- "st" on the current plot
%IG_STD				- std NaN or MATLAB, DIM correct
%IG_STERR_DBM			- standard error of difference between means
%IG_STRIP_PATH			- remove path from full filename
%IG_STRUCT2STRING		- struct2string
%IG_STRUCT_COMPARE		- compares two struct and returns several outputs
%IG_STRUCTCMP1			- compares two structures 
%IG_TILE_WINDOWS		- tile MATLAB figure windows
%IG_TIME_MS2S			- time ms2s (not really working?)
%IG_VECTOR_TO_CONSECUTIVE_INTEGERS		- converts an arbitrary vector to vector of consecutive integers, starting from start_value
%IG_VF				- visual field estimation
