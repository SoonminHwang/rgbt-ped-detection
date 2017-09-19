---
# KAIST Multispectral Pedestrian Detection Benchmark
By Soonmin Hwang, Jaesik Park, Namil Kim, Yukyung Choi, In So Kweon at RCV Lab. (KAIST)
[Website](http://multispectral.kasit.ac.kr)
![teaserImage](https://sites.google.com/site/pedestrianbenchmark/home/main_img.png)
---

&nbsp;
---
### Dataset Download

> [[Readme]](http://multispectral.kaist.ac.kr/pedestrian/Readme.txt) 
>
>[[All, Video (35.9GB)]](http://multispectral.kaist.ac.kr/pedestrian/data-kaist/videos.tar)
>
>[[All, Annotation (48MB)]](http://multispectral.kaist.ac.kr/pedestrian/data-kaist/annotations.tar)

&nbsp;
---
### Download links for part of our dataset 

**Train**
> **Set 00** / Day / Campus / 5.92GB / 17,498 frames / 11,016 objects [[videos]](http://multispectral.kaist.ac.kr/pedestrian/data-kaist/videos/set00.tar) [[annotations]](http://multispectral.kaist.ac.kr/pedestrian/data-kaist/annotations/set00.tar) 
>
> **Set 01** / Day / Road / 2.82GB / 8,035 frames / 8,550 objects [[videos]](http://multispectral.kaist.ac.kr/pedestrian/data-kaist/videos/set01.tar) [[annotations]](http://multispectral.kaist.ac.kr/pedestrian/data-kaist/annotations/set01.tar)
> 
> **Set 02** / Day / Downtown / 3.08GB / 7,866 frames / 11,493 objects  [[videos]](http://multispectral.kaist.ac.kr/pedestrian/data-kaist/videos/set02.tar) [[annotations]](http://multispectral.kaist.ac.kr/pedestrian/data-kaist/annotations/set02.tar)
>
> **Set 03** / Night / Campus / 2.40GB / 6,668 frames / 7,418 objects  [[videos]](http://multispectral.kaist.ac.kr/pedestrian/data-kaist/videos/set03.tar) [[annotations]](http://multispectral.kaist.ac.kr/pedestrian/data-kaist/annotations/set03.tar)
>
> **Set 04** / Night / Road / 2.88GB / 7,200 frames / 17,579 objects [[videos]](http://multispectral.kaist.ac.kr/pedestrian/data-kaist/videos/set04.tar) [[annotations]](http://multispectral.kaist.ac.kr/pedestrian/data-kaist/annotations/set04.tar)
> 
> **Set 05** / Night / Downtown / 1.01GB / 2,920 frames / 4,655 objects  [[videos]](http://multispectral.kaist.ac.kr/pedestrian/data-kaist/videos/set05.tar) [[annotations]](http://multispectral.kaist.ac.kr/pedestrian/data-kaist/annotations/set05.tar)

&nbsp;

**Test**

> **Set 06** / Day / Campus / 4.78GB / 12,988 frames / 12,086 objects [[videos]](http://multispectral.kaist.ac.kr/pedestrian/data-kaist/videos/set06.tar) [[annotations]](http://multispectral.kaist.ac.kr/pedestrian/data-kaist/annotations/set06.tar)
>
> **Set 07** / Day / Road / 3.04GB / 8,141 frames / 4,225 objects [[videos]](http://multispectral.kaist.ac.kr/pedestrian/data-kaist/videos/set07.tar) [[annotations]](http://multispectral.kaist.ac.kr/pedestrian/data-kaist/annotations/set07.tar)
> 
> **Set 08** / Day / Downtown / 3.50GB / 8,050 frames / 23,309 objects [[videos]](http://multispectral.kaist.ac.kr/pedestrian/data-kaist/videos/set08.tar) [[annotations]](http://multispectral.kaist.ac.kr/pedestrian/data-kaist/annotations/set08.tar)
>
> **Set 09** / Night / Campus / 1.38GB / 3,500 frames / 3,577 objects [[videos]](http://multispectral.kaist.ac.kr/pedestrian/data-kaist/videos/set09.tar) [[annotations]](http://multispectral.kaist.ac.kr/pedestrian/data-kaist/annotations/set09.tar)
>
> **Set 10** / Night / Road / 3.75GB / 8,902 frames / 4,987 objects [[videos]](http://multispectral.kaist.ac.kr/pedestrian/data-kaist/videos/set10.tar) [[annotations]](http://multispectral.kaist.ac.kr/pedestrian/data-kaist/annotations/set10.tar)
> 
> **Set 11** / Night / Downtown / 1.33GB / 3,560 frames / 6,655 objects [[videos]](http://multispectral.kaist.ac.kr/pedestrian/data-kaist/videos/set11.tar) [[annotations]](http://multispectral.kaist.ac.kr/pedestrian/data-kaist/annotations/set11.tar)

&nbsp;

Or you can download extracted png files. (consisting of a few thousands png images)

>
>[train20 (1.6GB)](http://multispectral.kaist.ac.kr/pedestrian/data-kaist/train20.tar)
>
>[test20 (1.6GB)](http://multispectral.kaist.ac.kr/pedestrian/data-kaist/test.tar)

&nbsp;
---
### Toolbox
This is an extended version of Piotr's Computer Vision Matlab Toolbox to deal with multispectral images.   
Original toolbox is [here](https://github.com/pdollar/toolbox)


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

&nbsp;
To reproduce the results in CVPR '15 paper, run 'detector/acfDemoKAIST.m'.

