export PATH=/home/duhq/miniconda3/envs/R4-server/bin:$PATH;

echo "Rscript $1 $2 $3 $4 $5 $6"

Rscript "$1" "$2" "$3" "$4" "$5" $6
