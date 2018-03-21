#!/bin/bash

## This script cleans the human_Illumina_dataset.fastq dataset and creates fastqc reports before and after

# path to data directory to mount volume (change this to absolute path in your system)
pmisdatos=/Users/ticatla/hubiC/Science/Teaching/Mx/BioinfInvgRepro/BioinfinvRepro/Unidad6/Prac_Uni6/FastqsEjemplo/datos
## Clean data trimming and filtering low quality seqs
echo "Comenzar la limpieza" #Hago el echo para saber donde va mi script cuando lo corro
docker run --rm -v $pmisdatos:/data biocontainers/fastxtools /bin/bash -c "fastx_trimmer -f 1 -l 70 -i human_Illumina_dataset.fastq -v | \
fastq_quality_filter -q 20 -p 90 -o clean_human_data.fastq -v"

# en el comando anterior:
# --rm: borra el contenedor después de que termina de correr.
# /bin/bash -c "<comandos>" sirve para poder utilizar varios comandos unidos con | o & dentro del mismo contenedor

## Create fastqc report before and after
echo "Hacer fastqc analisis"
docker run --rm -v $pmisdatos:/data biocontainers/fastqc fastqc human_Illumina_dataset.fastq clean_human_data.fastq