## Pasos tutorial ensamblado genomas

Alan Michael TORRES

1. SSH desde terminal al servidor mostrado en las notas.

2. Crear carpeta con tu apellido, i.e:


`mkdir TORRES`


3. Copiar lecturas desde la carpeta “data”

`cp data/* TORRES/`

4. Ingresar a la carpeta que corresponda, ie:

`cd TORRES/`

5. Ejecutar fastqc

`fastqc -f fastq *.gz`

6. Crear carpetas para almacenar secuencias rasuradas

```
mkdir PAIRED
mkdir UNPAIRED
```

7. Ejecutar trimmomatic:

```
java -jar /opt/trinityrnaseq-Trinity-v2.4.0/trinity-plugins/Trimmomatic-0.36/trimmomatic.jar PE -threads 12 -phred33 6_S4_R1_paired.fastq.gz 6_S4_R2_paired.fastq.gz PAIRED/6_S4_R1_paired.fastq.gz UNPAIRED/6_S4_R1_unpaired.fastq.gz PAIRED/6_S4_R2_paired.fastq.gz UNPAIRED/6_S4_R2_unpaired.fastq.gz ILLUMINACLIP:/opt/trinityrnaseq-Trinity-v2.4.0/trinity-plugins/Trimmomatic-0.36/adapters/all_adapters.fasta:2:30:10 MINLEN:50 AVGQUAL:28
```

8. Ejecutar spades, a5_pipeline y cap3:

```
spades.py -o spades -t 4 -1 mutant_R1.fastq.gz -2 mutant_R2.fastq.gz

/opt/a5_miseq_linux_20160825/bin/a5_pipeline.pl mutant_R1.fastq.gz mutant_R2.fastq.gz --threads=4 A5-assembly-mutant

```

9. Transformar archivos fastq a fasta

```
/d2p10tb/databases/db/viromescan/seqtk/seqtk seq -a mutant_R1.fastq.gz > mutant_R1.fasta
/d2p10tb/databases/db/viromescan/seqtk/seqtk seq -a mutant_R2.fastq.gz > mutant_R2.fasta
cat mutant_R1.fasta mutant_R2.fasta > mutant_R1-2.fasta
/opt/iassembler/iAssembler-v1.3.2.x64/bin/cap3 mutant_R1-2.fasta
```

9. Evaluar la calidad con seqstats de cada ensamblado:

```
/opt/hmmer-2.3/squid/seqstat spades/scaffolds.fasta
/opt/hmmer-2.3/squid/seqstat A5-assembly-mutant.contigs.fasta
/opt/hmmer-2.3/squid/seqstat mutant_R1-2.fasta.cap.contigs
```

10. En la carpeta del usuario buscar un archivo `wildtype.fna` y copiarlo a `PAIRED`. 

11. Ejecutar QUAST:

```
/opt/miniconda2/lib/python2.7/site-packages/quast-5.0.2-py2.7.egg/EGG-INFO/scripts/quast.py  -o QUAST-3-assemblers -r wildtype.fna mutant_R1-2.fasta.cap.contigs spades/scaffolds.fasta A5-assembly-mutant.contigs.fasta
```
