### This script runs admixture for the maize data


## make directory to save output
mkdir -p ../data/admixture


## run admixture for K 1-5
 
for K in 1 2 3 4 5; \
do ./admixture --cv ../data/maicesArtegaetal2015.bed $K | tee ../data/admixture/log${K}.out;
done

## move output Q and P to output
mv {*.P,*.Q} ../data/admixture/

## save the likelihood results of each K to a single file

grep -h CV ../data/admixture/log*.out > ../data/admixture/maices_Kerror.txt
