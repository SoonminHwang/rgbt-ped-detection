function T = TRaw( I )

if(nargin<1 || isempty(I)), T=single([]);   return; end

T = single( I(:,:,4) );

end