export PATH=/home/duhq/miniconda3/envs/R4/bin:$PATH;

Rscript /home/duhq/BioUI_script/plot_nwk.R ${1} $(find ${1}/output/*/*.nwk)
