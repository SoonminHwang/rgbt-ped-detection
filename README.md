---
## KAIST Multispectral Pedestrian Detection Benchmark

By Soonmin Hwang, Jaesik Park, Namil Kim, Yukyung Choi, In So Kweon at RCV Lab. (KAIST) [[Website](http://multispectral.kasit.ac.kr)]
![teaserImage](https://sites.google.com/site/pedestrianbenchmark/home/main_img.png)


&nbsp;
---
### Usage

First, download multispectral dataset.

    cd data/scripts
    chmod +x fetch_dataset_kaist_cvpr15.py & ./fetch_dataset_kaist_cvpr15.py

Then just run `acfDemoKAIST.m` in MATLAB



### Toolbox
This is an extended version of [Piotr's Computer Vision Matlab Toolbox](https://github.com/pdollar/toolbox).
We modify some codes to deal with 4-ch RGB+T images, e.g. ${PIOTR_TOOLBOX}/channels/chnsCompute.m.



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


