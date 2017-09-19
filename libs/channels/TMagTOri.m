function TMTO = TMagTOri( I )

if(nargin<1 || isempty(I)), TMTO=single([]);   return; end

channel = 0;
normRad = 5;
normConst = .005;
full = 0;
[M,O]=gradientMag(single(I(:,:,4)),channel,normRad,normConst,full);
H=gradientHist(M,O,2,6, 1, 0, .2,full);

[h, w, ~] = size( H );
M = imResampleMex( M, h, w, 1 );
TMTO = cat( 3, M, H );
end
