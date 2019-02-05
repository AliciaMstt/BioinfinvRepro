# Unidad 5: Genética de poblaciones con software especializado

Los **datos crudos** son las secuencias tal cual salen de la plataforma de secuenciación (Illumina, IonTorrent, PacBio, entre otros). Es decir los **reads** (lecturas).  Este tipo de datos son con los que alimentamos a nuestra pipeline de ensamblado o mapeo a genoma de referencia para eventualmente *llamar SNPs* y poder tener los diferentes alelos para miles de loci (genotipos) en cada uno de nuestros individuos.

En la siguiente sección del curso nos enfocaremos en cómo limpiar las secuencias, ensamblar *de novo*, mapear a un genoma de referencia y llamar SNPS. Pero antes en esta sección veremos la parte que en general verdaderamente nos interesa: hacer análisis de genética de poblaciones con los SNPs.

Los SNPs son **datos procesados** que ya contienen significado biológico (genotipos). Dependiendo del **tipo de procesamiento** y del **software** que se utilizó los datos procesados podrán pasar del formato .fastq (y considerarse meramente *reads*) a un **formato específico**, que muchas veces están vinculados a un sofware. Los datos procesados en dicho formato específico serán a su vez el *input* de nuevos análisis, por ejemplo de genómica de poblaciones, genómica comparativa, filogenética, entre otros. 

Muchos formatos están asociados a un programa en particular, aunque los más usados son relativamente convencionales y ya pueden ser utilizados por otros programas y herramientas, por ejemplo paquetes de R o Biocondoctor.

Otros programas tienen sus propios formatos y hay que transformarlos manualmente (bueno, con la línea de comando) para analizarlos con otro software (lo cual puede ser doloroso).

Aquí nos vamos a enfocar en los formatos (y programas)[Plink](https://www.cog-genomics.org/plink/1.9/) y [VCF ](http://www.1000genomes.org/wiki/Analysis/variant-call-format), pues son bastante estándares, varios paquetes de R los pueden leer e incluyen su propio programa para realizar algunos análisis de genética de poblaciones.



## VCF
"Variant Call Format"
[Ref](http://samtools.github.io/hts-specs/VCFv4.2.pdf)

Formato para representar una posición en el genoma (posiblemente con variantes) y su información asociada. También puede contener información de genotipos de varias muestras para cada posición. 

Programa asociado: [VCFtools](https://vcftools.github.io/index.html) y [BCFtools](https://github.com/samtools/bcftools)

Ejemplo:

```
##fileformat=VCFv4.2
##fileDate=20090805
##source=myImputationProgramV3.1
##reference=file:///seq/references/1000GenomesPilot-NCBI36.fasta
##contig=<ID=20,length=62435964,assembly=B36,md5=f126cdf8a6e0c7f379d618ff66beb2da,species="Homo sapiens",taxonomy=x>
##phasing=partial
##INFO=<ID=NS,Number=1,Type=Integer,Description="Number of Samples With Data">
##INFO=<ID=DP,Number=1,Type=Integer,Description="Total Depth">
##INFO=<ID=AF,Number=A,Type=Float,Description="Allele Frequency">
##INFO=<ID=AA,Number=1,Type=String,Description="Ancestral Allele">
##INFO=<ID=DB,Number=0,Type=Flag,Description="dbSNP membership, build 129">
##INFO=<ID=H2,Number=0,Type=Flag,Description="HapMap2 membership">
##FILTER=<ID=q10,Description="Quality below 10">
##FILTER=<ID=s50,Description="Less than 50% of samples have data">
##FORMAT=<ID=GT,Number=1,Type=String,Description="Genotype">
##FORMAT=<ID=GQ,Number=1,Type=Integer,Description="Genotype Quality">
##FORMAT=<ID=DP,Number=1,Type=Integer,Description="Read Depth">
##FORMAT=<ID=HQ,Number=2,Type=Integer,Description="Haplotype Quality">
#CHROM POS     ID        REF    ALT     QUAL FILTER INFO                              FORMAT      NA00001        NA00002        NA00003
20     14370   rs6054257 G      A       29   PASS   NS=3;DP=14;AF=0.5;DB;H2           GT:GQ:DP:HQ 0|0:48:1:51,51 1|0:48:8:51,51 1/1:43:5:.,.
20     17330   .         T      A       3    q10    NS=3;DP=11;AF=0.017               GT:GQ:DP:HQ 0|0:49:3:58,50 0|1:3:5:65,3   0/0:41:3
20     1110696 rs6040355 A      G,T     67   PASS   NS=2;DP=10;AF=0.333,0.667;AA=T;DB GT:GQ:DP:HQ 1|2:21:6:23,27 2|1:2:0:18,2   2/2:35:4
20     1230237 .         T      .       47   PASS   NS=3;DP=13;AA=T                   GT:GQ:DP:HQ 0|0:54:7:56,60 0|0:48:4:51,51 0/0:61:2
20     1234567 microsat1 GTC    G,GTCT  50   PASS   NS=3;DP=9;AA=G                    GT:GQ:DP    0/1:35:4       0/2:17:2       1/1:40:
```



## Plink

También representa SNPs de hasta miles de individuos, pero con menos información de cada variante. Está enfocado en el análisis de familias y los fenotipos asociados a individuos, pero es útil para manejo de datos en general y muchos otros programas lo cupan de input [Ref](https://www.cog-genomics.org/plink/1.9/)

Programa asociado: [Plink](http://pngu.mgh.harvard.edu/~purcell/plink/) y [Plink1.9](https://www.cog-genomics.org/plink/1.9/)

En realidad hay varios [tipos de formato plink](https://www.cog-genomics.org/plink/1.9/formats), y normalmente no son uno sino **varios archivos**. 

La manera de manejar los formatos cambió un poco entre las versiones <1.9 y 1.9. Siguen siendo compatibles, pero aguas.

**Plink text (`ped`)**

Consta de min 2 archivos: 

`.ped` que contiene los SNPs
```
plink.ped:
  1 1 0 0 1  0  G G  2 2  C C
  1 2 0 0 1  0  A A  0 0  A C
  1 3 1 2 1  2  0 0  1 2  A C
  2 1 0 0 1  0  A A  2 2  0 0
  2 2 0 0 1  2  A A  2 2  0 0
  2 3 1 2 1  2  A A  2 2  A A
```

`.map` que contiene la localización de esos SNPs

```
plink.map:
  1 snp1 0 1
  1 snp2 0 2
  1 snp3 0 3
```

**Plink 1 binario (`bed`)**
Es una versión binaria de lo anterior. Consta de 3 archivos:

`.bed` (PLINK binary biallelic genotype table). Ojo, no confundir con el `BED` que vimos arriba.

`.bim` que contiene las bases originales de cada SNP

```
plink.bim  
  1  snp1  0  1  G  A
  1  snp2  0  2  1  2
  1  snp3  0  3  A  C
```

`.fam` (PLINK sample information file) que contiene info de las muestras. Una línea por muestra con la siguiente info:

    Family ID ('FID')
    Within-family ID ('IID'; cannot be '0')
    Within-family ID of father ('0' if father isn't in dataset)
    Within-family ID of mother ('0' if mother isn't in dataset)
    Sex code ('1' = male, '2' = female, '0' = unknown)
    Phenotype value ('1' = control, '2' = case, '-9'/'0'/non-numeric = missing data if case/control)

Plink está pensado para datos humanos (de ahí lo de familia, madre, sexo, etc), pero es posible tener datos en formato plink sin ese tipo de información. 

Muchos programas de genética de poblaciones y R utilizan plink para correr. 

**Plink `raw`** (additive + dominant component file)

Es un formato producido por Plink para realizar análisis en R (pero no en Plink).

Contenido:

Header line y luego una línea por muestra con: 

```
V+6 (for '--recode A') or 2V+6 (for '--recode AD') fields, where V is the number of variants. 
FID	Family ID
IID	Within-family ID
PAT	Paternal within-family ID
MAT	Maternal within-family ID
SEX	Sex (1 = male, 2 = female, 0 = unknown)
PHENOTYPE	Main phenotype value
```

Ejemplo:

```
FID	IID	PAT	MAT	SEX	PHENOTYPE	abph1.15_G	ae1.8_A	an1.3_A	ba1.5_G	ba1.7_A	csu1138.4_A	csu1171.2_A	Fea2.2_A	fea2.3_G	MZB00125.2_A	pbf1.3_G
1	maiz_3	0	0	0	-9	2	0	0	2	0	0	2	0	0	0	0
2	maiz_68	0	0	0	-9	0	0	2	1	0	0	0	0	0	0	0
3	maiz_91	0	0	0	-9	2	0	0	0	0	0	2	0	0	1	0
```


## Ejemplos con VCF

1) Utiliza un comando para bajar los datos en formato vcf del repositorio Schweizer RM, Robinson J, Harrigan R, Silva P, Galaverni M, Musiani M, Green RE, Novembre J, Wayne RK (2015) Data from: Targeted capture and resequencing of 1040 genes reveal environmentally driven functional variation in gray wolves. Dryad Digital Repository. [http://dx.doi.org/10.5061/dryad.8g0s3](http://datadryad.org/resource/doi:10.5061/dryad.8g0s3)

El archivo debe guardarse en `BioinfinvRepro/Unidad5/Prac_Uni5/wolves`. Navega ahí y luego:

```
wget https://datadryad.org/bitstream/handle/10255/dryad.98341/Filtered_variableSites_fixedSamples_9July2014_minDP10noMissing_ecotypesOnly_n107_GenicRegions_95CallRate.recode.vcf?sequence=1
```

**Pregunta** ¿De dónde saqué ese link?

a) Si no lo hiciste de inicio, cambia el nombre del archivo que acabas de bajar a `wolves.vcf`.

b) ¿Cuántos MB pesa el archivo?

2) En un contenedor con vcftools (o en tu máquina con tu propia instalación de vcf) realiza los siguientes ejercicios. Si estás usando docker recuerda cómo correr vcf en un contenedor **montando un volumen** (`-v`) y borrándolo cuando termine de correr (`--rm`):

```
docker run --rm -v /RutaAbsolutaA/Prac_Uni5/wolves:/data biocontainers/vcftools:0.1.15 vcftools -help
```

Por facilidad, puedes poner la parte que repitiremos cada vez que queramos correr vcftools (lo anterior hasta "vcftools") en una variable.

```
vcftools="docker run --rm -v /RutaAbsolutaA/Prac_Uni5:/data biocontainers/vcftools:0.1.15 vcftools"
```

y luego correrlo con `$vcftools` más el comando que quieras. Ejemplo: `$vcftools -help". 

Ahora consulta el [manual de VCFtools](https://vcftools.github.io/man_latest.html) y responde

a) ¿Cuántos individuos y variantes (SNPs) tiene el archivo?

b) Calcula la frecuencia de cada alelo para todos los individuos dentro del archivo y guarda el resultado en un archivo.

c) ¿Cuántos sitios del archivo no tienen missing data?

d) Calcula la frecuencia de cada alelo para todos los individuos pero solo para los sitios sin missing data y guarda el resultado en un archivo. 

e) ¿Cuántos sitios tienen una frecuencia del alelo menor <0.05?

f) Calcula la heterozygosidad de cada individuo.

g) Calcula la diversidad nucleotídica por sitio.

h) Calcula la diversidad nucleotídica por sitio solo para los sitios del cromosoma 3

i) Filtra los sitios que tengan una frecuencia del alelo menor  <0.05 y crea un archivo nuevo llamado `wolves_maf05.vcf`.

j) Convierte el archivo `wolves_maf05.vcf` a formato plink. 
 
 

## Ejemplos con plink


En la ruta `BioinfinvRepro/Unidad5/Prac_Uni5/maices/data` encontrarás varios archivos plink. Contesta lo siguiente **asumiendo que tu WD es `maices/bin` (y no `data`).**

1) Enlista los archivos que hay en `data`. 

```
$ ls ../data
maicesArtegaetal2015.log  maicesArtegaetal2015.ped  maices_admixture.Q
maicesArtegaetal2015.map  maicesArtegaetal2015.raw

```

2) ¿Qué tipos de archivos son cada uno?

3) Consulta el manual de [plink1.9](https://www.cog-genomics.org/plink/1.9/formats) y contesta utilizando comandos de plink lo siguiente:

a) Transforma de formato ped a formato bed (pista: sección Data Managment). El nombre del output debe ser igual, solo cambiando la extensión.

```
plink --file ../data/maicesArtegaetal2015 --make-bed --out ../data/maicesArtegaetal2015
```

b) Crea otro archivo ped (ojo PPPPed) pero esta vez filtrando los SNPs cuya frecuencia del alelo menor sea menor a 0.05 Y filtrando los individuos con más de 10% missing data. Tu output debe llamarse maicesArtegaetal2015_maf05_missing10

¿Cuántos SNPs y cuántos individuos fueron removidos por los filtros?

```
plink --file ../data/maicesArtegaetal2015 --recode --maf 0.05 --mind 0.1 --out ../data/maicesArtegaetal2015_maf05_missing10
```

c) Realiza un reporte de equilibrio de Hardy-Weinberg sobre el archivo `maicesArtegaetal2015_maf05_missing10` creado en el ejercicio anterior. El nombre del archivo de tu output debe contener maicesArtegaetal2015_maf05_missing10.

```
plink --file ../data/maicesArtegaetal2015_maf05_missing10 --hardy --out ../data/maicesArtegaetal2015_maf05_missing10
```

Observa el output y discute que es cada columna.

```
head maicesArtegaetal2015_maf05_missing10.hwe
 CHR                     SNP     TEST   A1   A2                 GENO   O(HET)   E(HET)            P 
   0                abph1.15  ALL(NP)    G    A             44/75/46   0.4545   0.4999       0.2753
   0                   an1.3  ALL(NP)    A    C            11/44/109   0.2683   0.3215      0.04821
   0                   ba1.5  ALL(NP)    G    A             51/41/73   0.2485   0.4911    2.236e-10
   0               csu1138.4  ALL(NP)    A    G             8/41/115     0.25   0.2872       0.1027
   0               csu1171.2  ALL(NP)    A    G             21/56/88   0.3394   0.4176        0.024
   0                  Fea2.2  ALL(NP)    A    G             30/37/98   0.2242   0.4151     9.19e-09
   0              MZB00125.2  ALL(NP)    A    G            10/46/108   0.2805   0.3215       0.1403
   0                  pbf1.3  ALL(NP)    G    A            11/43/111   0.2606   0.3163      0.02714
   0                  pbf1.5  ALL(NP)    A    G            11/43/111   0.2606   0.3163      0.02714
```


d) Observa el archivo `maicesArtegaetal2015.fam`. Consulta la documentación de plink para determinar que es cada columna. ¿Qué información hay y no hay en este archivo?

```
$ head ../data/maicesArtegaetal2015.fam
1 maiz_3 0 0 0 -9
2 maiz_68 0 0 0 -9
3 maiz_91 0 0 0 -9
4 maiz_39 0 0 0 -9
5 maiz_12 0 0 0 -9
6 maiz_41 0 0 0 -9
7 maiz_35 0 0 0 -9
8 maiz_58 0 0 0 -9
9 maiz_51 0 0 0 -9
10 maiz_82 0 0 0 -9
```

4) Utiliza la info el archivo `meta/maizteocintle_SNP50k_meta_extended.txt` y el comando `update-ids` de plink para cambiar los nombres de las muestras de `data/maicesArtegaetal2015*` de tal forma que el family ID corresponda a la info de la columna `Categ.Altitud` en `maizteocintle_SNP50k_meta_extended.txt`. Pista: este ejercicio requiere varias operaciones, puedes dividarlas en diferentes scripts de bash o de R y bash. Tu respuesta debe incluir todos los scripts (y deben estar en /bin). 

