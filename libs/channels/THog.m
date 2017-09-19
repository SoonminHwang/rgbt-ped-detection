function H = THog( I )

if(nargin<1 || isempty(I)), H=single([]);   return; end

binSize = 2;
H = fhog( im2single(I(:,:,4)), binSize );

end