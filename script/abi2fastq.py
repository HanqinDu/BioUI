# coding: utf-8

# #### Load Packages

import os
import sys
from Bio import SeqIO
import math
import pylab as plt
import numpy as np
import pandas as pd
import matplotlib.patches as patches


seperate_pattern = sys.argv[1]


os.mkdir("fastq")


output_seq = []

for abi in os.listdir("abi"):
    records = SeqIO.parse("abi/" + abi, "abi")
    
    for record in records:
        for i in [n for n,x in enumerate(record.letter_annotations["phred_quality"]) if x > 41]:
            record.letter_annotations["phred_quality"][i] = 41
        count = SeqIO.write(record, "fastq/" + abi.replace(".ab1",".fastq"), "fastq")


# #### Concat All fastq


fastq_list = os.listdir("fastq")
fastq_list.sort()

with open("reads_all.fastq", "w") as new_file:
    for name in fastq_list:
        with open("fastq/" + name) as f:
            for line in f:
                new_file.write(line)
                
new_file.close()
f.close()


# #### Construct forward and reverse reads


import re

fastq_header = [re.sub(seperate_pattern + ".*$", "", x) for x in fastq_list]

forward_file = open("R1.fastq", "w")
reverse_file = open("R2.fastq", "w")
pair_file = open("pair.txt", "w")
unpaired_file = open("unpair.txt", "w")



for header in set(fastq_header):
    loc_target = [n for n,e in enumerate(fastq_header) if header == e]
    
    if(len(loc_target) < 2):
        unpaired_file.write("cannot find the paired read for: " + fastq_list[loc_target[0]] + "\n")
        unpaired_file.write("\n")
    
    elif(len(loc_target) > 2):
        unpaired_file.write("more than two files have the same header: " + [fastq_list[n] + ", " for n in loc_target] + "\n")
        unpaired_file.write("\n")
    
    else:
        pair_file.write(fastq_list[loc_target[0]] + "\t")
        with open("fastq/" + fastq_list[loc_target[0]]) as f:
            for line in f:
                forward_file.write(line)
            f.close()
                
        pair_file.write(fastq_list[loc_target[1]] + "\n")
        with open("fastq/" + fastq_list[loc_target[1]]) as f:
            for line in f:
                reverse_file.write(line)
            f.close()



forward_file.close()
reverse_file.close()
pair_file.close()
unpaired_file.close()




# #### Plot Fastq Quality

def plot_fastq_qualities(filename, ax=None, limit=10000):

    fastq_parser = SeqIO.parse(filename, "fastq")
    res=[]
    c=0
    for record in fastq_parser:
        score=record.letter_annotations["phred_quality"]
        res.append(score)
        c+=1
        if c>limit:
            break
    df = pd.DataFrame(res)
    l = len(df.T)+1

    if ax==None:
        f,ax=plt.subplots(figsize=(12,5))
    
    rect_red  = patches.Rectangle((0,0),l,20,linewidth=0,facecolor='r',alpha=.4)
    rect_yellow = patches.Rectangle((0,20),l,8,linewidth=0,facecolor='yellow',alpha=.4)
    rect_green    = patches.Rectangle((0,28),l,13,linewidth=0,facecolor='g',alpha=.4)
    ax.add_patch(rect_red)
    ax.add_patch(rect_yellow)
    ax.add_patch(rect_green)
    
    
    df.mean().plot(ax=ax,c='black')
    boxprops = dict(linestyle='-', linewidth=1, color='black')
    df.plot(kind='box', ax=ax, grid=False, showfliers=False,
            color=dict(boxes='black',whiskers='black')  )
    ax.set_xticks(np.arange(0, l, round(l/10)))
    ax.set_xticklabels(np.arange(0, l, round(l/10)))
    ax.set_xlabel('position(bp)')
    ax.set_xlim((0,l))
    ax.set_ylim((0,41))
    ax.set_title('per base sequence quality')    
    return(f,ax)





f,ax = plot_fastq_qualities('reads_all.fastq')
f.savefig("quality.svg")

