import os, glob
from scipy.io import loadmat
from collections import defaultdict
import numpy as np
from lxml import etree, objectify

import pdb

IMAGE_SIZE = (640, 512)     # KAIST Multispectral Benchmark

def vbb_anno2dict(vbb_file, sub_dir):
    vid_name = os.path.splitext(os.path.basename(vbb_file))[0]
    annos = defaultdict(dict)
    vbb = loadmat(vbb_file)
    # object info in each frame: id, pos, occlusion, lock, posv

    objLists = vbb['A'][0][0][1][0]
    objLbl = [str(v[0]) for v in vbb['A'][0][0][4][0]]

    nFrame = int(vbb['A'][0][0][0][0][0])    
    maxObj = int(vbb['A'][0][0][2][0][0])
    objInit = vbb['A'][0][0][3][0]
    
    # objStr = vbb['A'][0][0][5][0]
    # objEnd = vbb['A'][0][0][6][0]
    # objHide = vbb['A'][0][0][7][0]
    # altered = int(vbb['A'][0][0][8][0][0])
    # log = vbb['A'][0][0][9][0]
    # logLen = int(vbb['A'][0][0][10][0][0])

    # objLists = vbb['A'][0][0][1][0]
    # objLbl = [str(v[0]) for v in vbb['A'][0][0][4][0]]
    # person index
    # person_index_list = np.where(np.array(objLbl) == "person")[0]
    
    for frame_id, obj in enumerate(objLists):
        
        frame_name = '/'.join( [sub_dir, vid_name, 'I{:05d}'.format(frame_id)] )
        annos[frame_name] = defaultdict(list)
        annos[frame_name]["id"] = frame_name            
                    
        if len(obj[0]) > 0:                
            for id, pos, occl, lock, posv in zip(
                        obj['id'][0], obj['pos'][0], obj['occl'][0],
                        obj['lock'][0], obj['posv'][0]):

                id = int(id[0][0]) - 1  # for matlab start from 1 not 0
                pos = pos[0].tolist()
                occl = int(occl[0][0])
                lock = int(lock[0][0])
                posv = posv[0].tolist()                

                annos[frame_name]["label"].append(objLbl[id])
                annos[frame_name]["occlusion"].append(occl)
                annos[frame_name]["bbox"].append(pos)
                        
    return annos


def instance2xml_base(anno, img_size, bbox_type='xyxy'):
    """bbox_type: xyxy (xmin, ymin, xmax, ymax); xywh (xmin, ymin, width, height)"""
    assert bbox_type in ['xyxy', 'xywh']
    
    E = objectify.ElementMaker(annotate=False)
    anno_tree = E.annotation(
        E.folder('KAIST Multispectral Ped Benchmark'),
        E.filename(anno['id']),
        E.source(
            E.database('KAIST pedestrian'),
            E.annotation('KAIST pedestrian'),
            E.image('KAIST pedestrian'),
            E.url('https://soonminhwang.github.io/rgbt-ped-detection/')
        ),
        E.size(
            E.width(img_size[0]),
            E.height(img_size[1]),
            E.depth(4)
        ),
        E.segmented(0),
    )
    for index, bbox in enumerate(anno['bbox']):
        bbox = [float(x) for x in bbox]
        if bbox_type == 'xyxy':
            xmin, ymin, w, h = bbox
            xmax = xmin+w
            ymax = ymin+h
        else:
            xmin, ymin, xmax, ymax = bbox

        E = objectify.ElementMaker(annotate=False)        

        anno_tree.append(
            E.object(
            E.name(anno['label'][index]),
            E.bndbox(
                E.xmin(xmin),
                E.ymin(ymin),
                E.xmax(xmax),
                E.ymax(ymax)
            ),
            E.pose('unknown'),
            E.truncated(0),
            E.difficult(0),
            E.occlusion(anno["occlusion"][index])
            )
        )
    return anno_tree

def parse_anno_file(vbb_inputdir, vbb_outputdir):
    # annotation sub-directories in hda annotation input directory
    assert os.path.exists(vbb_inputdir)
    sub_dirs = os.listdir(vbb_inputdir)
    
    for sub_dir in sub_dirs:
        print( "Parsing annotations (vbb): {}".format(sub_dir) )        
        vbb_files = glob.glob(os.path.join(vbb_inputdir, sub_dir, "*.vbb"))

        for vbb_file in vbb_files:            
            annos = vbb_anno2dict(vbb_file, sub_dir)
            if annos:                
                vbb_outdir = os.path.join(vbb_outputdir, sub_dir, os.path.basename(vbb_file).split('.')[0])
                print( "vbb_outdir: {}".format(vbb_outdir) )
                
                if not os.path.exists(vbb_outdir):
                    os.makedirs(vbb_outdir)

                for filename, anno in sorted(annos.items(), key=lambda x: x[0]):
                    # if "bbox" in anno:
                    anno_tree = instance2xml_base(anno, IMAGE_SIZE)
                    outfile = os.path.join(vbb_outputdir, os.path.splitext(filename)[0]+".xml")                        

                    print( "outfile: {}".format(outfile) )
                    etree.ElementTree(anno_tree).write(outfile, pretty_print=True)

if __name__ == "__main__":
    db_path = os.path.join(os.path.dirname(__file__), '..', 'kaist-rgbt')
    
    vbb_inputdir = os.path.join(db_path, 'annotations-vbb')
    xml_outputdir = os.path.join(db_path, 'annotations-xml')    

    if not os.path.exists(vbb_inputdir):
        os.makedirs(vbb_inputdir)

    os.system( 'curl -O http://multispectral.kaist.ac.kr/pedestrian/data-kaist/annotations-vbb.zip')
    os.system( 'unzip -d %s/annotations-vbb -q annotations-vbb.zip' % db_path )
        
    parse_anno_file(vbb_inputdir, xml_outputdir)    
