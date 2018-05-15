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


# 8.4 Ejemplos de análisis básicos de genética de poblaciones

## PLINK

[PLINK](https://www.cog-genomics.org/plink/1.9/) es un software de acceso libre muy usado porque permite realizar un amplio rango de análisis genómicos de forma relativamente rápida y sencilla.

Dentro de los análisis que pueden hacerse usando PLINK, están:

- Manejo y transformación de datos
- Estimación de desequilibrio de ligamiento
- Matriz de identidad por descendecia (IBD) e identidad por estado (IBS)
- Asociación genómica

**Limitaciones:**
- Análisis de variantes estructurales (excepto indels pequeños)
- Análisis de datos crudos
- No interfaz gráfica

Los dos formatos principales de PLINK son **ped** y **bed**, pero acepta formatos comúnmente usados con **vcf**.


**Ejercicio:** Descarga e instala [PLINK](https://www.cog-genomics.org/plink/1.9/). Echa un ojo a las funciones que puedes usar.

Para conocer si cada uno de los loci del set de datos ``cocci_silv`` se encuentra en equilibrio HW, usaríamos este comando:

``
plink --file ../data/cocci_silv --hardy --out ../out/HW_cocci
``

Con el siguiente comando quitaré los loci que son indels y le pediré que el archivo resultante se encuentre en formato vcf.

``
plink --file ../data/cocci_silv --snps-only just-acgt -recode vcf --out
``

**Ejercicio:** Estima el desequilibro de ligamiento en términos de r<sup>2</sup>. Posteriormente, quédate con aquellos SNPs cuya r<sup>2</sup> < 0.2. El archo resultante debe llamarse `/data/cocci_silv_filt.bed`


## Hierfstat
Este paquete de R te permite estimar estadísticos F con datos de genomas haploides y diploides, tomando en cuenta por la estructura de las poblaciones. Las notas de la clase están [aquí](Prac_Uni7/bin/Hierfstat_cocci.html).


## SNPRelate

[SNPRelate](https://bioconductor.org/packages/release/bioc/html/SNPRelate.html) es un paquete de Bioconductor muy bueno y rápido para hacer PCA, asociación genómica, análisis de parentesco y exploraciones básicas de datos genómicos. Puedes ver sus tutoriales [aquí](https://bioconductor.org/packages/release/bioc/vignettes/SNPRelate/inst/doc/SNPRelateTutorial.html), y seguiremos [estas notas en clase](Prac_Uni7/bin/Ejemplo_SNPRelate.html).

## Admixture
Herramienta que permite estimar la ancestría de individuos a partir de un set de datos de SNPs. Usa el mismo modelo estadístico que Structure pero es más rápido.

[Aquí](https://www.genetics.ucla.edu/software/admixture/index.html) puedes encontrar el ejecutable y el manual.

**Ejercicio:** Descarga el ejecutable y el manual de Admixture. ¿Qué tipo de archivo es el input de Admixture?
Corre Admixture con el set de datos de cocci_silv.

```
for K in 1 2 3 4 5; \
do ./admixture --cv ../data/cocci_silv.bed $K | tee ../data/admixture/log${K}.out;
done
```
Para guardar los resultados de versosimilitud en un archivo:

```
grep -h CV ../data/admixture/log*.out > ../data/admixture/coccineus_Kerror.txt
```

Grafica en R el resultado. ¿Qué valor de K elegirías para este set de datos?

```
library(ggplot2)

###Estimación de error con distintas k
k.error<- read.delim("../data/admix_results/coccineus_Kerror.txt", header = F, sep = ":")
rownames(k.error)<- c("k=1", "k=2", "k=3", "k=4", "k=5")

#plot error de K
e.plot<- ggplot(data=k.error, aes(x=1:7, y=V2)) + geom_point() + geom_line()
e.plot + xlab("k") + ylab("Error")

###Datos Poblaciones
meta<- read.delim("../meta/cocci_wild_meta.csv", sep = ",")
pop<- meta$Poblacion

###Datos admixture
admix.4<- read.delim("../bin/cocci_silv.4.Q", sep = " ", header = F)
cocci.admix.4 <- cbind(pop, admix.4) #Unir datos admixture con poblacion

##### PLOTS #####
mis.col <- palette(c("#edad2f", "#774ddd", "#bc0021", "#2cb25d"))

##Plot admixture K=4
barplot(t(as.matrix(cocci.admix.4[,2:5])), col= mis.col, names.arg = cocci.admix.4$pop, las=2, cex.names = .5,
       ylab="Ancestría", border=NA, cex.axis = 1.5, axisnames = T)

```


# 8.5. ¿Qué software de todo eso me sirve?

#### Ejercicios

**Ejercicio 1** explora los paquetes de Bioconductor, CRAN, el número especial de MER y methodspopgen.com de acuerdo a tu tema. Escoge tres que creas te serán útiles y explóralos con mayor profundidad. Deben ser distintos a los ejemplos que vimos en la sección anterior.

Abajo menciona cada uno y describe con tus propias palabras qué hace y para qué parte de tus análisis te serviría. Sé específicx, por ejemplo no digas solo "para hacer análisis de selección" sino "para hacer análisis de selección entre las poblaciones X y Y, ya que mi hipótesis es que estas poblaciones pueden estar bajo selección ya que X está en tales condiciones y Y en tales"

**Ejercicio 2**:

1. Escoge uno de los paquetes del ejercicio pasado.
2. Busca un tutorial, ayuda o vignette de ese paquete y síguelo con tus datos propios o con datos parecidos a los que tendrás que ya se encuentren publicados.
3. Si es un paquete de R o Bioconductor utiliza knitr para crear un "notebook" de lo que realizaste.
4. Sube el código (.R, .sh, etc) y si aplica el notebook (.html o .pdf) a tu cuenta de github. Pega el link al código o notebook en el espacio de abajo.

**Ejercicio 3** hagan equipos conforme a su tipo de datos y/o tema de investigación y discutan los paquetes que encontraron. Enlisten y describan para qué utilizarían los 2 que consideren más útiles. Hagan un pull resquest (por equipo) para actualizar este .md del repositorio en la parte de abajo ("Resultados ejercicio software interesante por equipos").
