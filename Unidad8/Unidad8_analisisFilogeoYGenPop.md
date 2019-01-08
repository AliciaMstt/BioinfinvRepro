# Unidad 8: Paquetes especializados y ejemplos de análisis de genética de poblaciones

## 8.1. Bioconductor y paquetes bioinformáticos en R

Como hemos visto los paquetes son un grupo de funciones que alguien desarrolla en torno a un tema específico. CRAN alberga muchos paquetes de R, algunos de ellos útiles para bioinformática, como [adegenet](http://adegenet.r-forge.r-project.org/) y [ape](https://cran.r-project.org/web/packages/ape/ape.pdf). Puedes ver una lista de más paquetes relacionados con genética estadística en [CRAN Task Statistical Genetics](https://cran.r-project.org/web/views/Genetics.html).

Otra opción para encontrar paquetes útiles es googlear "R package" + keywords de tu tema de interés, por ejemplo "metabarcoding".

También existen repositorios de paquetes especializados en un área, por ejemplo bioinformática.

**Bioconductor** es un repositorio de paquetes de R especializaos en en análisis de datos genómicos y de secuenciación masiva. Es decir, en Bioconductor encontrarás paquetes que NO están en CRAN.

![logo_bioconductor.gif](logo_bioconductor.gif)

### Generalidades de Bioconductor

#### [Página principal de Bioconductor](https://www.bioconductor.org/)

#### [Paquetes de Bioconductor](https://www.bioconductor.org/packages/release/BiocViews.html#___Software)

Como los paquetes de Bioconductor están escritos en el lenguaje de R, muchos tendrán tipos de objetos particulares al paquete y funciones nuevas, pero con tener las bases de R que hemos visto estarás listoa para aprenderlo.

La mejor manera de conocer qué hace y  usar un paquete es seguir un tutorial o vignette.

Por ejemplo esta de [ggtree](https://www.bioconductor.org/packages/release/bioc/vignettes/ggtree/inst/doc/ggtree.html)  y esta de [SNPRelate](http://corearray.sourceforge.net/tutorials/SNPRelate/).

Además, BioConductor desarrolló una clase de objetos, llamados `GRanges` que permite almacenar y manipular intervalos genómicos y variables definidas a lo largo de un genoma. Los `GRanges` son particularmente útiles para representar y analizar anotaciones genómicas y alineamientos y son la base de varios paquetes de Bioconductor

Los `GRanges` están definidos en el paquete  [GenomicRanges](https://bioconductor.org/packages/release/bioc/html/GenomicRanges.html). Este [tutorial](https://bioconductor.org/packages/release/bioc/vignettes/GenomicRanges/inst/doc/GenomicRangesIntroduction.pdf) explica su funcionamiento básico y lo recomiendo mucho. También está bueno el Capítulo 9 *Working with Range Data* del libro de Vince Buffalo *Bioinformatics Data Skills*.


#### [Workflows](https://www.bioconductor.org/packages/release/BiocViews.html#___Workflow)

Para algunas tareas comunes en análisis genéticos, como [Variant calling](https://www.bioconductor.org/help/course-materials/2014/BioC2014/Lawrence_Tutorial.pdf).


#### Cursos y conferencias de Bioconductor

Hay muchos [cursos y conferencias](https://www.bioconductor.org/help/course-materials) sobre Bioconductor que ocurren anualmente y que van de temas generales a especializados en algún proceso. Para una intro general yo recomiendo el curso online [Bioconductor for Genomic Data Science](http://kasperdanielhansen.github.io/genbioconductor/) de Kasper D. Hansen que incluye videos y código con notas en R y html.

Este 2018, por primera vez en Latinamérica, daremos un curso de nivel intermedio-avanzado: [Latin American R/BioConductor Developers Workshop 2018](http://www.comunidadbioinfo.org/r-bioconductor-developers-workshop-2018/). Bienvenidxs a registrarse :)


#### Instalar Bioconductor y sus paquetes

1) Tener instalado R

2) Instalar bioconductor (`source` al script `biocLite.R` que nos permitirá instalar paquetes de Bioconductor).

```
source("https://bioconductor.org/biocLite.R")
biocLite()
```
(Si lo anterior manda algún error intenta http:// en vez de  https://)

3) Utilizar la función `biocLite` para instalar los paquetes deseados. Ejemplo:

```
biocLite("ggtree")
```

Nota: algunos paquetes necesitan pasos extra de instalación, como jalar algo de GitHub, pero esto será indicado en la documentación del paquete.

#### Cómo citar R y Bioconductor

Citar R:

```
citation("base")
```

Citar Bioconductor:

```
citation("Biobase")
```

Citar un paquete en particular:

```
citation("NombrePaquete")
```
(o lo que loas autoreas especifiquen en su sitio web)


## 8.2. Population Genomics with R - special issue of Molecular Ecology Resources

Recientemente Molecular Ecology Resources publicó el special issue *Population Genomics with R*, el cual incluye revisiones, paquetes nuevos y estudios de caso.

Revisemos la [Tabla de Contenido](http://onlinelibrary.wiley.com/doi/10.1111/men.2017.17.issue-1/issuetoc).

y la Introducción:

[Paradis E, Gosselin T, Grünwald NJ et al. (2017) Towards an integrated ecosystem of R packages for the analysis of population genetic data. Molecular Ecology Resources, 17, 1–4.](
http://onlinelibrary.wiley.com/doi/10.1111/1755-0998.12577/full)


## 8.3. Methods in population genomics list

Los análisis de genómica de poblaciones van mucho más allá de R, y hay muchos programas para hacer análisis muy específicos.

[Yann Burgeouis](http://www.yannbourgeois.com/) sacó el fua y creo esta Lista de Métodos de genómica de poblaciones: [methodspopgen.com](http://methodspopgen.com/). Donde recopila métodos para inferir estructura, detectar selección e inferir la historia de la población.


# 8.4. ¿Qué software de todo eso me sirve?

#### Ejercicios

**Ejercicio 1** explora los paquetes de Bioconductor, CRAN, el número especial de MER y methodspopgen.com de acuerdo a tu tema. Escoge tres que creas te serán útiles y explóralos con mayor profundidad. Deben ser distintos a los ejemplos que veremos en la sección 8.5 más abajo.

Menciona cada paquete que elegiste y describe con tus propias palabras qué hace y para qué parte de tus análisis te serviría. Sé específicx, por ejemplo no digas solo "para hacer análisis de selección" sino "para hacer análisis de selección entre las poblaciones X y Y, ya que mi hipótesis es que estas poblaciones pueden estar bajo selección ya que X está en tales condiciones y Y en tales"

**Ejercicio 2**:

1. Escoge uno de los paquetes del ejercicio pasado.
2. Busca un tutorial, ayuda o vignette de ese paquete y síguelo con tus datos propios o con datos parecidos a los que tendrás que ya se encuentren publicados.
3. Si es un paquete de R o Bioconductor utiliza knitr para crear un "notebook" de lo que realizaste.
4. Sube el código (.R, .sh, etc) y si aplica el notebook (.html o .pdf) a tu cuenta de github. Pega el link al código o notebook en el espacio de abajo.

**Ejercicio 3** hagan equipos conforme a su tipo de datos y/o tema de investigación y discutan los paquetes que encontraron. Enlisten y describan para qué utilizarían los 2 que consideren más útiles. Hagan un pull resquest (por equipo) para actualizar este .md del repositorio en la parte de abajo ("Resultados ejercicio software interesante por equipos").


### Resultados ejercicio software interesante por equipos:

(has un pull request para agregar de 1 a 3 softwares en la lista de abajo, incluye el nombre, para qué sirve en súper resumen (una o dos líneas máximo y el link a su manual o página)

**Equipo 1** Genética de poblaciones

1. Stacks - análisis de genética de poblaciones. Está diseñada para utilizar datos generados a partir de métodos de NGS que utilizan enximas de restriccion (RADseq, GBS, etc.). Entre sus funciones más importantes iindentifica los loci en grupos de individuos, ya sea *de novo* o con un genoma de referencia y luego genotipifica cada locus.

Maria y Emiliano usaron Stacks en sus proyectos finales. María pretende evaluar la estrucutra poblacional de *Scomperomorus concolor* (un pez) y comparrlo con otros estudios de marcadores tradicionales

[Link al manual](http://catchenlab.life.illinois.edu/stacks/manual/)


2. pcadapt - este paquete hace un escaneo del genoma para determinar si existen "snps" que se hayan fijado en las poblaciones debido a la acción de selección natural. Para esto, utiliza un método estadístico basado en un análisis de componentes principales (CPA) para determinar si existen "snps" que sean "outliers", es decir que se fijaron en diferentes poblaciones. 

[Link al manual](https://github.com/bcm-uga/pcadapt)

**Equipo 2**

* Sushi Es un paquete para visualizar datos tipo ENCODE anotados sobre el genoma de referencia. [Sushi](https://bioconductor.org/packages/release/bioc/vignettes/Sushi/inst/doc/Sushi.pdf)

* LIMA Es un paquete que permite generar análisis estadisticos de tipo lineales para contrastes de grupos en datos de expresión. [LIMA](https://bioconductor.org/packages/release/bioc/vignettes/limma/inst/doc/intro.pdf)
 
* RSAMSTOOLS Es un paquete que te ayuda a trabajar con archivos tipo BAM y realizas alineamientos. [RSAMSTOOLS](https://bioconductor.org/packages/release/bioc/vignettes/Rsamtools/inst/doc/Rsamtools-Overview.pdf)


**Equipo 3**

1. [EdgeR paquete de Bioconductor para análisis de expresión diferencial de genes cuando tenemos replicas biológicas](https://www.bioconductor.org/packages/release/bioc/html/edgeR.html)
2. [DESeq paquete de Bioconductor para análisis de expresión diferencial utilizando un modelo binomial negativo, sin réplicas biológicas](https://www.bioconductor.org/packages/release/bioc/html/DESeq.html).
3. [RSEM paquete para estimación de isoformas y niveles de expresión de genes a partir de datos de RNA-seq ](http://deweylab.biostat.wisc.edu/rsem/README.html)

**Equipo 4**

* **methylkit.** Es un programa de R que está en Bioconductor, y es utilizado para el análisis y anotación del DNA metilado producto de secuenciación masiva. Está diseñado principalmente para datos de RRBS (Reduced representation bisulfite sequencing), pero también funciona para whole genome bilsulfite sequencing y métodos de captura dirigida (target-capture methods). El link al programa y al manual es [éste](https://bioconductor.org/packages/release/bioc/html/methylKit.html).

* **QIIME**. Es un programa para analizar secuencias de 16S rRNA. Las secuencias 16S son asignadas a unidades taxonómicas operacionales basadas en el porcentaje de similitud entre las secuencias comparadas. El link es [éste](www.qiime.org).

**Equipo 5**

* SNPHYLO es un conducto que utiliza dos paquetes de bioconductor: gdsfmt y SNPrelate y adicionalmente muscle para el alineamiento y phylip para ML. Construye árboles de ML a partir de una reducción de SNPs informativos.  
+http://chibba.pgml.uga.edu/snphylo/

**Equipo 6**

* diversity es un paquete que estima parametros genetico poblacionales y estima errores asociados y otros datos (https://besjournals.onlinelibrary.wiley.com/doi/abs/10.1111/2041-210X.12067)

* assignpop es un paquete para asignar individuos a poblaciones con datos genomicos y otros (https://besjournals.onlinelibrary.wiley.com/doi/abs/10.1111/2041-210X.12897)
 


# 8.5. Ejemplos de análisis básicos de genética de poblaciones

Como hemos visto, puede ser que hayas generado tus genotipos mapeando a un genoma de referencia o ensamblando *de novo*. En cualquier caso, el software que hayas utilizado deberá permitirte exportar tus datos a un formato estándar de genotipos, como plink o vcf. Estos formatos son además un programa en sí mismos que te permiten hacer diversos análisis de genética de poblaciones. Pero además también te permiten leer tus datos a R a través de diversos paquetes.

En una unidad previa ya habíamos visto [cómo se ven estos formatos](https://github.com/AliciaMstt/BioinfinvRepro/blob/master/Unidad6/Unidad_6_Datos_y_an%C3%A1lisis_utilizados_en_bioinform%C3%A1tica%20.md) y un ejemplo de vcf con datos de lobos ¿recuerdas?.

## SNPRelate

[SNPRelate](https://bioconductor.org/packages/release/bioc/html/SNPRelate.html) es un paquete de Bioconductor muy bueno y rápido para hacer PCA, asociación genómica, análisis de parentesco y exploraciones básicas de datos genómicos. El input pueden ser datos en plink. Puedes ver el tutorial de [SNPRelate aquí](https://bioconductor.org/packages/release/bioc/vignettes/SNPRelate/inst/doc/SNPRelateTutorial.Rmd) y Vamos a ver un ejemplo siguiendo [estas notas en clase](Prac_Uni8/bin/Ejemplo_SNPRelate.html).

## Hierfstat

[SnpStats](https://bioconductor.org/packages/release/bioc/html/snpStats.html) es otro paquete de BioConductor muy útil, que nos permite calcular Fst y otros estadísticos de genética de poblaciones.

Este paquete de R te permite estimar estadísticos F con datos de genomas haploides y diploides, tomando en cuenta por la estructura de las poblaciones. Las notas de la clase están [aquí](Prac_Uni8/bin/Hierfstat_cocci.Rmd).


## Admixture
Herramienta que permite estimar la ancestría de individuos a partir de un set de datos de SNPs. Usa el mismo modelo estadístico que Structure pero es más rápido.

[Aquí](https://www.genetics.ucla.edu/software/admixture/index.html) puedes encontrar el ejecutable y el manual.

**Ejercicio:** Descarga el ejecutable y el manual de Admixture. No es necesario instalarlo, solo con que el ejecutable esté en tu WD puedes correrlo. Revisa el manual ¿Qué tipo de archivo es el input de Admixture?

Veamos un ejemplo de cómo correr Admixture con el set de datos de maíces.  


```
mkdir -p ../data/admixture
for K in 1 2 3 4 5; \
do ./admixture --cv ../data/maices/maicesArtegaetal2015.bed $K | tee ../data/admixture/log${K}.out;
done
```

**Pregunta** ¿Qué hace el comando `tee` en el código de arriba?

Nota que Admixture guarda parte del output (archivos `*.Q` y `*.P` en el WD), para moverlos a data:

```
mv {*.P,*.Q} ../data/admixture/
```

(ojo, no hay espacio después de la `,`)

Para guardar los resultados de versosimilitud en un archivo:

```
grep -h CV ../data/admixture/log*.out > ../data/admixture/maices_Kerror.txt
```

Vamos a graficar en R el resultado. ¿Qué valor de K elegirías para este set de datos?

```{r}
library(ggplot2)

###Estimación de error con distintas k
k.error<- read.delim("../data/admixture/maices_Kerror.txt", header = F, sep = ":")
rownames(k.error)<- c("k=1", "k=2", "k=3", "k=4", "k=5")

#plot error de K
e.plot<- ggplot(data=k.error, aes(x=1:5, y=V2)) + geom_point() + geom_line()
e.plot + xlab("k") + ylab("Error")

```

**Ejercicio** Realiza un plot del admixture con la K optima.
