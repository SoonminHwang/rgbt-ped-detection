urlRoot = 'http://multispectral.kaist.ac.kr/pedestrian/data-kaist/';

urlwrite( [urlRoot 'md5_checksum_small_files_from_KAIST.txt'], ...
 'md5_checksum_small_files_from_KAIST.txt' );

fp = fopen('md5_checksum_small_files_from_KAIST.txt');
info = textscan(fp, '%s %s %s');
fclose(fp);

mkdir( '../kaist-rgbt' );

for ii = 1:length(info{1})
    if ~exist( info{1}{ii}, 'file' )
        fprintf( 'Downloading: %s\n', info{1}{ii} );
    end
    
    if system( sprintf('curl -LO %s', info{3}{ii} ) )       
        fprintf('Use matlab func. urlwrite\n');
        urlwrite( info{3}{ii}, info{1}{ii} );
    end
    
    fprintf( 'Unzip: %s\n', info{1}{ii} );    
    
    if ~system( sprintf('unzip -d ../kaist-rgbt -q %s', info{1}{ii} ) )    
        fprintf('use matlab func. unzip\n');
        unzip( info{1}{ii}, '../kaist-rgbt' );
    end

	% Skip md5 checksum
end


