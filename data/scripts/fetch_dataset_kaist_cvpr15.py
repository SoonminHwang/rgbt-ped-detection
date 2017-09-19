#!/usr/bin/python
import os
import sys
import hashlib

wget_cmd = 'wget --content-disposition --no-check-certificate '
os.system( 'wget http://multispectral.kaist.ac.kr/pedestrian/data-kaist/md5_checksum_small_files_from_KAIST.txt')
os.system( 'mkdir ../kaist-rgbt')

md5 = {}
with open( 'md5_checksum_small_files_from_KAIST.txt', 'r') as f:
	lines = [ line.rstrip('\n').split('\t') for line in f.readlines() ]
	
	for ii, line in enumerate(lines):
		file, md5, url = line
		cmd = wget_cmd + '"%s"' % url

		print '[%d/%d] Download %s' % (ii, len(lines), file)
		if os.path.exists(file):
			print 'File %s exists. Skip.' % file
		else:
			os.system(cmd)

		dstDir = file.split('.')[0]
		if 'set' in dstDir:
			_set, _vid = dstDir.split('_')
			dstDir = os.path.join('images', _set, _vid)

		if os.path.exists( dstDir ):
			print 'Extracted folder already exists. Skip.\n\n'
			continue
		else:
			print 'Check md5 checksum for %s...' % file,
			sys.stdout.flush()

			md5_download = hashlib.md5(open(file, 'rb').read()).hexdigest()
			if md5_download != md5:
				print '[Error] m5d checksum is not correct. (%s)' % file,
				continue
			print 'done.'

			print 'Extract %s...' % file,
			sys.stdout.flush()
			os.system( 'unzip -d ../kaist-rgbt -q %s' % file )
			print 'done.\n\n'
			sys.stdout.flush()

