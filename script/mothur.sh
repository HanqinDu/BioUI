#!/bin/bash

. /home/duhq/miniconda3/etc/profile.d/conda.sh;
conda activate mothur;

mothur "$1"