function script_labeling_KAIST_dataset( pth, setNum, vidNum )
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% KAIST Multi-spectral Recognition Dataset
%                                Yukyung Choi et al. 2016.
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%
% When the 'pngreadc.mexw64' makes a problem,
%   do followings:
%       >> clear mex; d = fileparts(which(mfilename));
%       >> delete( fullfile(d, videos, private, *png*) );
%
% - {rootPath} for KAIST dataset
%   - Set00 (AM05)
%       - V000 (North)
%           - T8  (Splitter)
%           - RGB (Splitter)       
%       - V001 (West)
%       - V002 (East)
%   - Set01
%   - Set02
%   - Set03
%   - Set04
%   - Set05
%   - Set06
%   - Set07

d = fileparts(which(mfilename));
addpath( genpath( d ) );


if nargin < 3, return; end
if ~exist( pth, 'dir' ), pth = '../data/kaist-rgbt-ped/videos'; end

name = sprintf( '%s/Set%02d/V%03d/', pth, setNum, vidNum );

targetObjs = { 'person', 'car', 'people', 'ignore' };
occTypes = {'No-occ', 'Partial-occ', 'Heavy-occ'};
seqNames = { [ name 'RGB' ], [ name 'T8' ] };

hFig = vbbLabeler2( targetObjs, occTypes, seqNames );
uiwait( hFig );

tmpFiles = dir( 'tmp*' );
arrayfun( @(x) delete( x.name ), tmpFiles, 'uniformoutput', false );
