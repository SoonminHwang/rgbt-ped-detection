function opts = acfSetTchFeatures( opts, enable )

opts.imreadf = @imreadHistEq;

opts.pPyramid.pChns.pCustom(1).enabled = enable(1);         % T       (T1)
opts.pPyramid.pChns.pCustom(2).enabled = enable(2);         % TM      (T2)
opts.pPyramid.pChns.pCustom(3).enabled = enable(3);         % THOG    (T3)
opts.pPyramid.pChns.pCustom(4).enabled = enable(4);         % TM+TO    (T4)

opts.pPyramid.pChns.pCustom(1).hFunc = @TRaw;
opts.pPyramid.pChns.pCustom(2).hFunc = @TMag;
opts.pPyramid.pChns.pCustom(3).hFunc = @THog;
opts.pPyramid.pChns.pCustom(4).hFunc = @TMagTOri;

opts.pPyramid.pChns.pCustom(1).pFunc = {};
opts.pPyramid.pChns.pCustom(2).pFunc = {};
opts.pPyramid.pChns.pCustom(3).pFunc = {};
opts.pPyramid.pChns.pCustom(4).pFunc = {};

opts.pPyramid.pChns.pCustom(1).name = 'T';
opts.pPyramid.pChns.pCustom(2).name = 'TM';
opts.pPyramid.pChns.pCustom(3).name = 'THOG';
opts.pPyramid.pChns.pCustom(4).name = 'TM+TO';

[ ~, trainSubset, ~ ] = fileparts( opts.trainSet );

chFeats = 'RGB';
for ii = find( [ opts.pPyramid.pChns.pCustom.enabled ] )
%     opts.name = [opts.name '-' opts.pPyramid.pChns.pCustom(ii).name ];
    chFeats= [chFeats '-' opts.pPyramid.pChns.pCustom(ii).name ];
end

if ~exist( fullfile( 'models', 'AcfKAIST', trainSubset, chFeats ), 'dir' ), 
    mkdir( fullfile( 'models', 'AcfKAIST', trainSubset, chFeats ) ); 
end

opts.name = fullfile( 'models', 'AcfKAIST', trainSubset, chFeats, ['AcfKAIST-' chFeats] );

end