% Demo for aggregate channel features object detector on KAIST dataset.
%
% See also acfReadme.m
%
% Piotr's Computer Vision Matlab Toolbox      Version 3.40
% Copyright 2014 Piotr Dollar.  [pdollar-at-gmail.com]
% Licensed under the Simplified BSD License [see external/bsd.txt]
%
% 2015.06.02. Modified by Soonmin Hwang [smhwang-at-rcv.kaist.ac.kr]
% 2017.10.11. Update

%% extract training and testing images and ground truth
dataDir='data/kaist-rgbt/';
addpath( genpath( 'pdollar-toolbox' ) );
addpath( genpath( 'libs' ) );

%% set up opts for training detector (see acfTrain)
opts=acfTrain2(); opts.modelDs=[50 20.5]; opts.modelDsPad=[64 32];
opts.pPyramid.smooth=.5;
opts.pPyramid.pChns.pColor.smooth=0; opts.nWeak=[32 128 256 512 1024 2048];
opts.pBoost.pTree.maxDepth=4; 
opts.pBoost.pTree.fracFtrs=1/16; 
opts.nNeg=50000;
opts.nAccNeg = 100000;
opts.nPerNeg = 20;
opts.pPyramid.pChns.pGradHist.softBin=1; opts.pJitter=struct('flip',1);

% opts.trainSet = [dataDir 'imageSets/train20.txt'];
opts.trainSet = [dataDir 'imageSets/train04.txt'];
opts.posGtDir=[dataDir 'annotations'];
opts.posImgDir=[dataDir 'images'];

pLoad={'lbls',{'person'},'ilbls',{'people','person?','cyclist'},'squarify',{3,.41}};
opts.pLoad = [pLoad 'hRng',[45 inf], 'vType', {'none'} ];

%% Set thermal features
opts = acfSetTchFeatures(opts, [1 0 1 0]);  % T, TM, THOG, TM+TO

%% train detector (see acfTrain)
detector = acfTrain2( opts );

%% modify detector (see acfModify)
pModify=struct('cascThr',0,'cascCal',.025);
detector=acfModify(detector,pModify);

%% run detector on a sample image (see acfDetect)
imgDir = [dataDir 'images']; gtDir = [dataDir 'annotations'];
testSet = [dataDir 'imageSets/test20.txt'];

imgNms =bbGt2('getSubsetFiles',{imgDir, imgDir, gtDir}, testSet);

idx = 102;
I = imreadHistEq(imgNms{1,idx}, imgNms{2,idx});
tic, bbs=acfDetect2(I,detector); toc
figure(1); imshow(I(:,:,1:3)); bbApply('draw',bbs); pause(.1);

%% test detector and plot roc (see acfTest)
% Reasonable
[~,~,gt,dt]=acfTest2('name',opts.name,'imgDir',imgDir,...
  'gtDir',gtDir,'pLoad',[pLoad, 'hRng',[45 inf],...
  'vType',{{'none','partial'}},'xRng',[5 635],'yRng',[5 475]],...
  'pModify',pModify,'reapply',0,'show',2,...
  'lims', [3.1e-3 3.1e1 .2 1], 'clr', 'g', 'subset', testSet, ...
  'figName', 'Reasonable-all');