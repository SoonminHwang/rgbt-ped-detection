---
## KAIST Multispectral Pedestrian Detection Benchmark

By Soonmin Hwang, Jaesik Park, Namil Kim, Yukyung Choi, In So Kweon at RCV Lab. (KAIST) [[Website](http://multispectral.kaist.ac.kr)]
![teaserImage](misc/teaser.png)


We developed imaging hardware consisting of a color camera, a thermal camera and a beam splitter to capture the aligned multispectral (RGB color + Thermal) images. With this hardware, we captured various regular traffic scenes at day and night time to consider changes in light conditions.

The KAIST Multispectral Pedestrian Dataset consists of 95k color-thermal pairs (640x480, 20Hz) taken from a vehicle. All the pairs are manually annotated (person, people, cyclist) for the total of 103,128 dense annotations and 1,182 unique pedestrians. The annotation includes temporal correspondence between bounding boxes like Caltech Pedestrian Dataset. More infomation can be found in our CVPR 2015 [[paper](misc/CVPR15_Pedestrian_Benchmark.pdf)] [[Ext. Abstract](misc/CVPR15_Pedestrian_Benchmark_ext.pdf)].

&nbsp;
---
### Usage

0. Clone this repository.

	git clone --recursive https://github.com/soonminhwang/rgbt-ped-detection


0. First, download multispectral dataset.

    cd data/scripts
    chmod +x fetch_dataset_kaist_cvpr15.py & ./fetch_dataset_kaist_cvpr15.py


0. Or you can get direct links for download [here](data/README.md).


0. Then just run `acfDemoKAIST.m` in MATLAB



### Preview
[![Set00, Day-Campus](http://img.youtube.com/vi/a6KKFGNkNNE/0.jpg)](https://youtu.be/a6KKFGNkNNE)
[![Set04, Night-Road](http://img.youtube.com/vi/GSc9Lu3TQyQ/0.jpg)](https://youtu.be/GSc9Lu3TQyQ)
[![Set05, Night-Downtown](http://img.youtube.com/vi/AerQFTuMFsg/0.jpg)](https://youtu.be/AerQFTuMFsg)


### Toolbox
This repository includes an extension of [Piotr's Computer Vision Matlab Toolbox](https://github.com/pdollar/toolbox).
We modify some codes to deal with 4-ch RGB+T images, e.g. `${PIOTR_TOOLBOX}/channels/chnsCompute.m`.
All the modifications are in `libs/`.



&nbsp;
---
### Citation
If you use our extended toolbox or dataset in your research, please consider citing:

	@inproceedings{hwang2015multispectral,
		Author = {Soonmin Hwang and Jaesik Park and Namil Kim and Yukyung Choi and In So Kweon},
		Title = {Multispectral Pedestrian Detection: Benchmark Dataset and Baselines},
		Booktitle = {Proceedings of IEEE Conference on Computer Vision and Pattern Recognition (CVPR)},
		Year = {2015}
	}


