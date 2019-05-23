# Tutorial ‘Análisis de Expresión Diferencial a partir de Secuencias de RNA’

## Alejandro Sepúlveda y Ricardo Verdugo

## Objetivo

Mostrar algunas técnicas computacionales para el análisis de secuencias biológicas de RNA, obtenidas mediante plataformas de secuenciación de segunda generación. Este flujo de trabajo permite identificar genes diferencialmente expresados bajo diferentes condiciones experimentales entregando resultados que permitan realizar interpretaciones de forma sencilla a partir de gráficos y tablas resumen. Es imprescindible que el organismo secuenciado tenga genoma de referencia, pues no se considera una etapa de ensamble *de novo*. 

Para efectos de este tutorial, se utilizará código en lenguajes *Bash* y *R*, además de la utilización de programas de código abierto con versiones específicas, las cuales se recomienda mantener. Además, se utiliza un servidor de cómputo con 40 procesadores, por lo tanto, si no se cuenta con tales recursos computacionales, es importante modificar el código para que utilice la cantidad de CPUs que estén disponibles.

## Contexto

Los datos utilizados en este tutorial corresponden a cuatro librerías de lecturas pertenecientes a la arqueobacteria *Sulfolobus acidocaldarius.* Sobre este organismo, se introdujo una mutación knockdown en el gen Lrs14-like, del cual se conoce su rol en la formación de biopelículas, con el objetivo de estudiar los genes preponderantes en este fenotipo ya sea dependientes o independientes del gen previamente mutado. Para el desarrollo de este análisis, la arqueobacteria fue cultivada en un medio Plantónico y, por otro lado, en una Biopelícula, tanto con su genotipo Wildtype como con la mutación ya descrita en muestras independientes. En consecuencia, las cuatro librerías corresponden a los siguientes grupos experimentales:

1. Organismo Wildtype en medio plantónico, el cual se denominará “WildType_P”.

2. Wildtype cultivado en biopelícula, denominado “Wildtype_B”.

3. Organismo mutado en medio plantónico, se denominará Mutant_P.

4. Organismo mutado y cultivado en biopelícula, denominado Mutant_B.



## 1.    Preliminar

Puede realizar este tutorial necesitará los paquetes:
* [NGSQC Toolkit](http://www.nipgr.ac.in/ngsqctoolkit.html)
* [HTSeq](https://github.com/simon-anders/htseq)
* [edgeR](https://bioconductor.org/packages/3.8/bioc/html/edgeR.html)

Para su conveniencia, estos paquetes, así como los datos necesarios, ya fueron instalados en el servidor ‘genoma.med.uchile.cl’. Utilizando la cuenta ya entregada, haga login al servidor. Se encontrará en la carpeta principal de la cuenta ‘/shared/bioinfo1’, donde verá los siguiente directorios:

* **common**: que tendrá los archivos iniciales para trabajar y serán compartidos por todos los usuarios.
* **professor**: carpeta utilizada por el tutor/profesor.
* **software**: contiene la instalación de uno de los programas que serán utilizados en el tutorial.

La carpeta ‘common’ a su vez, contiene tres carpetas almacenando los inputs necesarios para comenzar a trabajar, estas son:
*  **raw_data**: contiene las cuatro librerías de lecturas en formato ‘fastq’.
*  **ref_genome**: aquí se encuentra un archivo en formato ‘fasta’ con el genoma de referencia de *S. acidocaldarius* en su versión *DSM 639*.
*  **annot**: donde se ubica un archivo en formado ‘GFF3’ con las posiciones de los genes con respecto al genoma de referencia.

Cada estudiante debe, como paso inicial de este tutorial, ubicarse en el directorio principal y, desde ahí, entrar a su carpeta de usuario (ej: raverdugo), ingresar a ella y crear una nueva carpeta que se llamará ‘Tarea7.3/code’, desde donde se ejecutarán el resto de las instrucciones.
```sh
cd <mi usuario>
mkdir -p Tarea7.3/code
cd Tarea7.3/code
```


## 2.    Carpetas preexistentes

```sh
RAW=/shared/bioinfo1/common/raw_data/
ANN=/shared/bioinfo1/common/annot/
REF=/shared/bioinfo1/common/ref_genome/
```
Crear tres nuevas variables, las cuales contendrán la ubicación de las tres carpetas contenidas en ‘common’.

## 3.    Carpetas con las salidas del tutorial

Crear cuatro variables que van a contener las rutas a cuatro carpetas que se crearán posteriormente para almacenar resultados.
```sh
QC=../qc
FIL=../filtered
ALN=../alignment
CNT=../count
```

## 4.    Control de calidad

Crear una carpeta con su ubicación y nombre ya definidos en la variable ‘$QC’. Luego, crear una carpeta para cada librería, las cuales almacenarán los outputs generados en este paso.
```sh
mkdir $QC
mkdir "$QC/wild_planctonic" "$QC/wild_biofilm" "$QC/mut_planctonic" "$QC/mut_biofilm"
```

Luego, ejecutar el programa ‘IlluQC_PRLL.pl’, una de las herramientas de ‘NGSQC Toolkit’ y que tiene la funcionalidad de generar un reporte completo acerca de la calidad de las secuencias que reciba como entrada. La versión ‘PRLL’ permite ejecutar el proceso utilizando varios CPU al mismo tiempo. Para su coveniencia, hemos creado un alias para ejecutar el programa simplemente llamando ‘illuqc’ en el terminal.

```sh
illuqc -se "$RAW/MW001_P.fastq" 5 A -onlystat -t 2 -o "$QC/wild_planctonic" -c 10 &
illuqc -se "$RAW/MW001_B3.fastq" 5 A -onlystat -t 2 -o "$QC/wild_biofilm" -c 10 &
illuqc -se "$RAW/0446_P.fastq" 5 A -onlystat -t 2 -o "$QC/mut_planctonic" -c 10 &
illuqc -se "$RAW/0446_B3.fastq" 5 A -onlystat -t 2 -o "$QC/mut_biofilm" -c 10 &
```
Una vez terminado este proceso, se recomienda revisar las archivos resultantes que quedan almacenados en las carpetas de salida, en los cuales se pueden ver distintas gráficas que representan la calidad de las lecturas, su contenido de GC y otros datos útiles para decidir el tipo de filtraje que se realizará posteriormente.

## 5.    Filtro de secuencias

Según los resultados observados en el punto anterior, las librerías serán filtradas con el siguiente criterio: eliminar aquellas lecturas con un puntaje de calidad (PHRED) menor a 20 en el 80% de la extensión de la propia secuencia. 
En primer lugar, crear las carpetas que almacenarán los resultados.
```sh
mkdir $FIL
mkdir "$FIL/wild_planctonic" "$FIL/wild_biofilm" "$FIL/mut_planctonic" "$FIL/mut_biofilm"
```
Luego, se procede a realizar el filtro.
```sh
illuqc -se "$RAW/MW001_P.fastq" 5 A -l 80 -s 20 -t 2 -o "$FIL/wild_planctonic" -c 1 &
illuqc -se "$RAW/MW001_B3.fastq" 5 A -l 80 -s 20 -t 2 -o "$FIL/wild_biofilm" -c 1
illuqc -se "$RAW/0446_P.fastq" 5 A -l 80 -s 20 -t 2 -o "$FIL/mut_planctonic" -c 1
illuqc -se "$RAW/0446_B3.fastq" 5 A -l 80 -s 20 -t 2 -o "$FIL/mut_biofilm" -c 1 &
```
Esto genera nuevas librerías de lecturas en formato ‘fastq’, las cuales serán utilizadas en el siguiente paso del tutorial.

## 6.    Alineamiento

Crear una nueva carpeta para resultados.
```sh
mkdir $ALN
```
Luego se ejecuta el alineamiento con ‘bwa mem’.
```sh
bwa078 mem "$REF/genome.fasta" -t 1 "$FIL/wild_planctonic/MW001_P.fastq_filtered" > "$ALN/MW001_P_aligned.sam" &
bwa078 mem "$REF/genome.fasta" -t 1 "$FIL/wild_biofilm/MW001_B3.fastq_filtered" > "$ALN/MW001_B3_aligned.sam" &
bwa078 mem "$REF/genome.fasta" -t 1 "$FIL/mut_planctonic/0446_P.fastq_filtered" > "$ALN/0446_P_aligned.sam" & 
bwa078 mem "$REF/genome.fasta" -t 1 "$FIL/mut_biofilm/0446_B3.fastq_filtered" > "$ALN/0446_B3_aligned.sam" &
```

## 7.    Estimación de Abundancia

Crear una carpeta para guardar resultados.
```sh
mkdir $CNT
```

Utilizar el programa HTSeq-Count versión  0.6.1 ([http://www-huber.embl.de/users/anders/HTSeq/doc/install.html#install](http://www-huber.embl.de/users/anders/HTSeq/doc/install.html#install))  para estimar la cantidad de lecturas mapeadas en cada uno de los genes en el genoma de referencia, de los cuales se indica su posición a través del archivo GFF3. 
```sh
python -m HTSeq.scripts.count -t Gene -i GenID "$ALN/MW001_P_aligned.sam" "$ANN/saci.gff3" > "$CNT/MW001_P.count" &
python -m HTSeq.scripts.count -t Gene -i GenID "$ALN/MW001_B3_aligned.sam" "$ANN/saci.gff3" > "$CNT/MW001_B3.count" &
python -m HTSeq.scripts.count -t Gene -i GenID "$ALN/0446_P_aligned.sam" "$ANN/saci.gff3" > "$CNT/0446_P.count" &
python -m HTSeq.scripts.count -t Gene -i GenID "$ALN/0446_B3_aligned.sam" "$ANN/saci.gff3" > "$CNT/0446_B3.count" &
```
Los resultados obtenidos a través de este proceso, se utilizan como entrada para el siguiente paso, que es probar expresión diferencial.

## 8.    Prueba de Expresión Diferencial

Aún ubicado en la carpeta ‘code’, entrar a R. En este tutorial se utilizó la versión 3.0.3, sin embargo, es posible instalar una versión más avanzada sin problemas

### 8.1           Pasos preliminares

En primer lugar, se define el directorio con los archivos de entrada y aquellos donde se almacenarán los resultados.
```R
input_dir  <- file.path("..","count")
output_pseudo <- file.path("..","diff_expr", "pseudocounts") 
output_histogram <- file.path("..","diff_expr", "histograms") 
output_pvalue_fdr <- file.path("..","diff_expr", "pvalue_fdr") 
output_table <- file.path("..","diff_expr", "tables")
```
Luego, se comprueba si el directorio de entrada existe y se crean las carpetas de salidas.
```R
if(!file.exists(input_dir)){
  stop("Data directory doesn't exist: ", input_dir)
}
if(!file.exists(output_pseudo)){
  dir.create(output_pseudo, mode = "0755", recursive=T)
}
if(!file.exists(output_histogram)){
  dir.create(output_histogram, mode = "0755", recursive=T)
}
if(!file.exists(output_pvalue_fdr)){
  dir.create(output_pvalue_fdr, mode = "0755", recursive=T)
}
if(!file.exists(output_table)){
  dir.create(output_table, mode = "0755", recursive=T)
}
```

Cargar librería ‘edgeR’ (https://bioconductor.org/packages/release/bioc/html/edgeR.html), la cual proporciona la funciones que serán  necesarias para ejecutar la  prueba estadística de expresión diferencial. 
```R
library(edgeR)
```

### 8.2  Cargar y procesar archivos de entrada

Leer archivos de entrada y asignarles nombres a sus columnas.

```R
wild_p <- read.delim(file=file.path(input_dir, "MW001_P.count"), sep="\t", header = F, check=F); colnames(wild_p) <- c("Gen_ID", "Count")
wild_b <- read.delim(file=file.path(input_dir, "MW001_B3.count"), sep="\t", header = F, check=F); colnames(wild_b) <- c("Gen_ID", "Count")
mut_p <- read.delim(file=file.path(input_dir, "0446_P.count"), sep="\t", header = F, check=F); colnames(mut_p) <- c("Gen_ID", "Count")
mut_b <- read.delim(file=file.path(input_dir, "0446_B3.count"), sep="\t", header = F, check=F); colnames(mut_b) <- c("Gen_ID", "Count")
```
Juntar los cuatro set de datos.
```R
rawcounts <- data.frame(wild_p$Gen_ID, WildType_P = wild_p$Count, WildType_B = wild_b$Count, Mutant_P = mut_p$Count, Mutant_B = mut_b$Count, row.names = 1)
```
Calcular RPKM
```R
 rpkm <- cpm(rawcounts)
```
Remover filas que no serán utilizadas y aquellos genes con un valor de RPKM menor a 1, en tres de las cuatro librerías.
```R
to_remove <- rownames(rawcounts) %in% c("__no_feature","__ambiguous","__too_low_aQual","__not_aligned","__alignment_not_unique")
keep <- rowSums(rpkm > 1) >= 3 & !to_remove
rawcounts <- rawcounts[keep,]
```

### 8.3           Expresión Diferencial para Medios de Cultivo
Crear un vector que agrupará las muestras según el medio de cultivo a las que fueron sometidas.
```R
group_culture <- c("planctonic","biofilm","planctonic","biofilm")
```
Crear un objeto del tipo DGE,  a través del cual se realizarán los cálculos para identificar genes diferencialmente expresados.
```R
 dge_culture <- DGEList(counts = rawcounts, group = group_culture)
```
Calcular factor de normalización. Esto va a permitir, posteriormente, normalizar los valores de conteos, según el tamaño de cada librería.
```R
dge_culture <- calcNormFactors(dge_culture)
```
Estimar dos valores de dispersión, uno para cada gen y otro para cada librería. Esto es necesario para ejecutar la prueba estadística final.
```R
dge_culture <- estimateCommonDisp(dge_culture)
dge_culture <- estimateTagwiseDisp(dge_culture)
```
Realizar prueba de expresión diferencial, para lo cual se ocupa un ‘Test Exacto’, el cual asume que los conteos siguen una distribución ‘Binomial Negativa’.
```R
de_culture <- exactTest(dge_culture, pair = c("planctonic","biofilm"))
```
Obtener una tabla resumen de resultados.
```R
results_culture <- topTags(de_culture, n = nrow(dge_culture)) 
results_culture <- results_culture$table
```
Obtener ID de genes diferencialmente expresados
```R
ids_culture <- rownames(results_culture[results_culture$FDR < 0.1,])
```

### 8.4           Expresión Diferencial para Genotipos
Crear un set de conteos que no considere los genes diferencialmente expresados por Medio de Cultivo.
```R
rawcounts_genotype <- rawcounts[!rownames(rawcounts) %in% ids_culture,]
```
Luego, se siguen los mismos pasos que en el **Paso 8.3**, el código completo se entrega en el siguiente cuadro.
```R
group_genotype <- c("wildtype","wildtype","mutant","mutant")
dge_genotype <- DGEList(counts = rawcounts_genotype, group = group_genotype)
dge_genotype <- calcNormFactors(dge_genotype)
dge_genotype <- estimateCommonDisp(dge_genotype)
dge_genotype <- estimateTagwiseDisp(dge_genotype)
de_genotype <- exactTest(dge_genotype, pair = c("wildtype","mutant"))
results_genotype <- topTags(de_genotype, n = nrow(de_genotype))
results_genotype <- results_genotype$table
ids_genotype <- rownames(results_genotype[results_genotype$FDR < 0.1,])
```

### 8.5           Generar Resultados
Definir vectores del tipo Booleano que, a partir del set completo de genes, etiquetará aquellos que presentan expresión diferencial.
```R
de_genes_culture  <- rownames(rawcounts) %in% ids_culture
de_genes_genotype <- rownames(rawcounts) %in% ids_genotype
```

Obtener pseudoconteos y transformarlos a escala logarítmica. Estos valores corresponden a los conteos normalizados por el tamaño de cada librería y fueron calculados en la etapa donde se aplicó la función ‘exactTest’.
```R
pseudocounts <- data.frame(rownames(rawcounts), WildType_P = log10(dge_culture$pseudo.counts[,1]), WildType_B = log10(dge_culture$pseudo.counts[,2]), Mutant_P =  log10(dge_culture$pseudo.counts[,3]), Mutant_B = log10(dge_culture$pseudo.counts[,4]), DE_C = de_genes_culture, DE_G = de_genes_genotype, row.names = 1)
```
Graficar los pseudoconteos para cada gen, remarcando de un color diferente aquellos diferencialmente expresados.
```R
#Medio de Cultivo
pdf(file=file.path(output_pseudo,"pair_expression_culture.pdf"), width = 8, height = 4)
par(mfrow = c(1,2))
plot(pseudocounts$WildType_P, pseudocounts$WildType_B, col = ifelse(pseudocounts$DE_C, "red", "blue"), main = "Wild Type", xlab = "Planctonic", ylab = "Biofilm", cex.main = 1.3, cex.lab = 1.3, cex.axis = 1.2, las = 01)
abline(lsfit(pseudocounts$WildType_P, pseudocounts$WildType_B), col = "black")
plot(pseudocounts$Mutant_P, pseudocounts$Mutant_B, col = ifelse(pseudocounts$DE_C, "red", "blue"), main = "Mutant", xlab = "Planctonic", ylab =  "Biofilm", cex.main = 1.3, cex.lab = 1.3, cex.axis = 1.2, las = 01)
abline(lsfit(pseudocounts$Mutant_P, pseudocounts$Mutant_B), col = "black")
dev.off()
```
```R
#Genotipo
pdf(file=file.path(output_pseudo,"pair_expression_genotype.pdf"), width = 8, height = 4)
par(mfrow = c(1,2))
plot(pseudocounts$WildType_P, pseudocounts$Mutant_P, col = ifelse(pseudocounts$DE_G, "red", "blue"), main = "Planctonic", xlab = "Wild Type", ylab = "Mutant", cex.main = 1.3, cex.lab = 1.3, cex.axis = 1.2, las = 01)
abline(lsfit(pseudocounts$WildType_P, pseudocounts$Mutant_P), col = "black")
plot(pseudocounts$WildType_B, pseudocounts$Mutant_B, col = ifelse(pseudocounts$DE_G, "red", "blue"), main = "Biofilm", xlab = "Wild Type", ylab = "Mutant", cex.main = 1.3, cex.lab = 1.3, cex.axis = 1.2, las = 01)
abline(lsfit(pseudocounts$WildType_B, pseudocounts$Mutant_B), col = "black")
dev.off()
```
Graficar un histograma de Valores P.
```R
pdf(file=file.path(output_histogram,"histograms_pvalue.pdf"), width = 8, height = 4)
par(mfrow = c(1,2))
hist(x = results_culture$PValue, col = "skyblue", border = "blue", main = "Culture", xlab = "P-value", ylab = "Frequency", cex.main = 1.3, cex.lab = 1.3, cex.axis = 1.2)
hist(x = results_genotype$PValue, col = "skyblue", border = "blue", main = "Genotype", xlab = "P-value", ylab = "Frequency", cex.main = 1.3, cex.lab = 1.3, cex.axis = 1.2)
dev.off()
```
Graficar Valores P vs FDR.
```R
pdf(file=file.path(output_pvalue_fdr, "pvalue_fdr.pdf"), width = 8, height = 4)
par(mfrow = c(1,2))
plot(results_culture$PValue, results_culture$FDR, col = "blue", main = "Culture", xlab = "P-value", ylab = "FDR", cex.main = 1.3, cex.lab = 1.3, cex.axis = 1.2, las = 01)
plot(results_genotype$PValue, results_genotype$FDR, col = "blue", main = "Genotype", xlab = "P-value", ylab = "FDR", cex.main = 1.3, cex.lab = 1.3, cex.axis = 1.2, las = 01)
dev.off()
```
Escribir tablas de resultados.
```R
#Medio de Cultivo
write.table(x=results_culture, file=file.path(output_table, "table_de_genes_culture.csv"), quote=F, sep="\t", dec=".", row.names=T, col.names=T)

#Genotipo
write.table(x=results_genotype, file=file.path(output_table, "table_de_genes_genotype.csv"), quote=F, sep="\t", dec=".", row.names=T, col.names=T)
```
