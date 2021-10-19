#!/bin/bash

cd "$( cd "$( dirname "${BASH_SOURCE[0]}" )" >/dev/null 2>&1 && pwd )"

dataset_root=${1}

if [ "$#" -ne 1 ]; then
     echo "Usage: ./download_dataset.sh DATASET_DOWNLOAD_PATH"
     exit 2
fi

# Check if directory exists
if [[ ! -d "${dataset_root}" ]]
then	
 	echo "Invalid destination path: ${dataset_root}."	
	exit 2
fi

echo "" 
echo "Downloading dataset to ${dataset_root}"
echo ""
filename="kaist-cvpr15.tar.gz"
url="https://kaist-cvpr15-dataset.s3.ap-northeast-2.amazonaws.com/${filename}"
wget --directory-prefix=${dataset_root} ${url}

echo ""
echo "Extract dataset (takes > 10 mins)"
echo ""
tar zxvf ${dataset_root}/${filename} -C ${dataset_root}


symlink_dst=$(dirname ${BASH_SOURCE[0]})
echo ""
echo "Add a symbolic link to : ${symlink_dst}/../kaist-rgbt"
echo ""
ln -s ${dataset_root}/kaist-cvpr15 ../kaist-rgbt

echo ""
echo "Done."
echo "" 
