function I = imreadHistEq( rgbFile, lwirFile )
RGB = imread( rgbFile );
T = rgb2gray( imread( lwirFile ) );
I = cat(3, RGB, T);
% I(:,:,4) = histeq(I(:,:,4));
I(:,:,4) = I(:,:,4) .* (255.0 / 141);
end
