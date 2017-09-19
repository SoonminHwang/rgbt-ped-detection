% Demo for aggregate channel features object detector on KAIST dataset.
%
% See also acfReadme.m
%
% Piotr's Computer Vision Matlab Toolbox      Version 3.40
% Copyright 2014 Piotr Dollar.  [pdollar-at-gmail.com]
% Licensed under the Simplified BSD License [see external/bsd.txt]
%
% 2015.06.02. Modified by Soonmin Hwang [smhwang-at-rcv.kaist.ac.kr]
% 2017.09.17. Update

%% extract training and testing images and ground truth
dataDir='data/kaist-rgbt/';
addpath( genpath( 'pdollar-toolbox' ) );
addpath( genpath( 'libs' ) );

% for s=1:2
%   if(s==1), type='test'; skip=[]; else type='train'; skip=20; end
%   dbInfo2(['kaist-' type]); if(s==2), type=['train' int2str2(skip,2)]; end
%   if(exist([dataDir type '/annotations'],'dir')), continue; end
%   dbExtract2(dataDir, type,1,200);
% end

% type='test-day';
% dbInfo2(['kaist-' type]);
% if(~exist([dataDir type '/annotations'],'dir')), dbExtract2(dataDir, type,1,skip); end  
  
% type='test-night';
% dbInfo2(['kaist-' type]);
% if(~exist([dataDir type '/annotations'],'dir')), dbExtract2(dataDir, type,1,skip); end  

%% set up opts for training detector (see acfTrain)
opts=acfTrain2(); opts.modelDs=[50 20.5]; opts.modelDsPad=[64 32];
opts.pPyramid.smooth=.5;
opts.pPyramid.pChns.pColor.smooth=0; opts.nWeak=[32 128 512 2048];
opts.pBoost.pTree.maxDepth=2; 
opts.pBoost.pTree.fracFtrs=1/16; 
opts.nNeg=5000; 
opts.pPyramid.pChns.pGradHist.softBin=1; opts.pJitter=struct('flip',1);

% opts.posGtDir=[dataDir 'train' int2str2(skip,2) '/annotations'];
% opts.posImgDir=[dataDir 'train' int2str2(skip,2) '/images'];
opts.trainSet = [dataDir 'imageSets/train20.txt'];
opts.posGtDir=[dataDir 'annotations'];
opts.posImgDir=[dataDir 'images'];

opts.name='models/AcfKAIST-RGB';
% opts.name='models/AcfKAIST-RGB-T-TM-THOG';

pLoad={'lbls',{'person'},'ilbls',{'people','person?','cyclist'},'squarify',{3,.41}};
opts.pLoad = [pLoad 'hRng',[45 inf], 'vType', {'none'} ];

%% To handle thermal channel
opts.imreadf = @imreadHistEq;

opts.pPyramid.pChns.pCustom(1).enabled = 0;         % T       (T1)
opts.pPyramid.pChns.pCustom(2).enabled = 0;         % TM      (T2)
opts.pPyramid.pChns.pCustom(3).enabled = 0;         % THOG    (T3)

opts.pPyramid.pChns.pCustom(1).hFunc = @TRaw;
opts.pPyramid.pChns.pCustom(2).hFunc = @TMag;
opts.pPyramid.pChns.pCustom(3).hFunc = @THog;

opts.pPyramid.pChns.pCustom(1).name = 'T';
opts.pPyramid.pChns.pCustom(2).name = 'TM';
opts.pPyramid.pChns.pCustom(3).name = 'THOG';

%% train detector (see acfTrain)
detector = acfTrain2( opts );

%% modify detector (see acfModify)
pModify=struct('cascThr',0,'cascCal',.025);
detector=acfModify(detector,pModify);

%% run detector on a sample image (see acfDetect)
% Evaluation on Day & Night
% imgDir = [dataDir 'test/images'];       gtDir = [dataDir 'test/annotations'];         type = '';
% % Evaluation on Day
% imgDir = [dataDir 'test-day/images'];   gtDir = [dataDir 'test-day/annotations'];       type = '-day';
% % Evaluation on Night
imgDir = [dataDir 'images']; gtDir = [dataDir 'annotations'];
testSet = [dataDir 'imageSets/test20.txt'];

imgNms =bbGt2('getSubsetFiles',{imgDir, imgDir, gtDir}, testSet);

idx = 102;
I = imreadHistEq(imgNms{1,idx}, imgNms{2,idx});
tic, bbs=acfDetect2(I,detector); toc
figure(1); imshow(I(:,:,1:3)); bbApply('draw',bbs); pause(.1);

%% test detector and plot roc (see acfTest)
[~,~,gt,dt]=acfTest2('name',opts.name,'imgDir',imgDir,...
  'gtDir',gtDir,'pLoad',[pLoad, 'hRng',[45 inf],...
  'vType',{{'none','partial'}},'xRng',[5 635],'yRng',[5 475]],...
  'pModify',pModify,'reapply',0,'show',5,...
  'lims', [3.1e-3 3.1e1 .2 1],'type', type, 'clr', 'g');
