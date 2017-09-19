function TM = TMag( I )

if(nargin<1 || isempty(I)), TM=single([]);   return; end

channel = 0;
normRad = 5;
normConst = .005;
full = 0;
[TM,~]=gradientMag(single(I(:,:,4)),channel,normRad,normConst,full);

end
