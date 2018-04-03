Julia Carrasco Zanini Sánchez



Genotipado de Polimorfismos de Nucleótido Único (SNPs) para Estudios de Asociación con Enfermedades Complejas
===

A partir de la secuenciación completa del genoma humano, se decubrieron variantes que surgieron a partir de mutaciones. Se estima que entre los genomas de dos individuos seleccionados al azar existe un 0.1% de varición. Los polimorfismos de núcleotido único (SNPs por sus siglas en inglés) son un tipo de variante que se estima que ocurre con una frecuencia de aproximadamente 1 en 500-1000 pares de bases y se han reportado más de tres millones de SNPs en el genoma humano.

Los SNPs han sido ampliamente utilizados como marcadores géneticos en estudios de asociaciones con enfermedades complejas. Por lo tanto, el desarrollo de tecnologías de alto rendimiento para el genotipado de SNPs ha permitido ir haciendo estudios cada más amplios para la identificación de genes involucrados en la patofisiología de disntintas enfermedades. 

La mayoría de las plataformas existentes para el genotipado de SNPs se pueden clasificar en dos tipos:
- Genoma Completo
- Mapeo fino

Estos enfoques difieren principalmente en el número de SNPs y de individuos que se pueden genotipar con cada uno.

![alt text](https://media.springernature.com/original/springer-static/image/chp%3A10.1007%2F978-1-60327-411-1_16/MediaObjects/978-1-60327-411-1_16_Fig1_HTML.gif "Número de SNPs y de muestras que se pueden genotipar utilizando distintas plataformas")

Adicionalmente, la química que se utiliza en las plataformas de genotipificación se puede dividir en:
- **Hibridización diferencial no enzimática**
	- Depende de la diferencia en las T<sub>m</sub> de unión entre sondas complementarias y no complementarias a la secuencia de DNA blanco.
- **Reacciones enzimáticas**
	- ***Extensión de base única*** o ***minisecuenciación*** en las cuales un primer de extensión que se hibrida al extremo 5' de un SNP se extiende en una o unas cuantas bases. La determinación del SNP se hace mediante la incorporación de nucleótidos fluorescentes o mediante el peso molecular del producto de extensión.
	- ***Basadas en ligación de sondas específicas al DNA***  

## Genoma completo
Este tipo de enfoque son más útiles en estudios exploratorios donde se busca descubrir genes y variantes que podrían estar involucradas en algunas enfermedad. Por lo tanto el número de SNPs que se pueden llegar a genotipar es cercano a 1,000,000 o superior.
Una limitantes es que las compañías que diseñan dichas plataformas buscan cubrir variantes comúnes por lo que son plataformas que no se prestan a que uno decida el contenido de SNPs que desea estudiar. Un problema importante respecto a este punto es que la mayoría de estas plataformas están basadas en un número muy limitado de grupos étnicos. Por lo tanto la covertura de estas plataformas puede no ser representativa para ciertos grupos étnicos. Adicionalmente, son tecnologías de costos elevados.
Existen cuatro plataformas que se utilizan principalmente para estudios de asociación de genoma completo.
##### 1. Illumina BeadArray
Utiliza extensión de primers para distinguir entre los dos alelos.
Utiliza 50-meros para la captura de las secuencias blanco.

##### 2. Affymetrix SNP microarray
Utiliza hibridación diferencial.
Utiliza sondas 25-meros complementarias a uno de los 2 alelos.

##### 3. Método de Genotipado de Perlegen
También utiliza sondas 25-meros complementarias a uno de los 2 alelos, pero adicional a la plataforma de Affymetrix utiliza las sondas a través de la posición del SNP en ambas direcciones sentido y antisentido.

##### 4. Invader
Utiliza dos sondas que forman una estructura tridimensional que es reconocida por una endonucleasa termoestable. Si el nucleótido en la sonda es complementario al DNA blanco, se corta en la posición del SNP liberando una marca fluorescente que se puede detectar. 

## Mapeo Fino
Los estudios de mapeo fino buscan genotipar un número mucho menor de SNPs (usualmente menor de 1,000) que usualmente se han asociado a alguna enfermedad compleja mediante estudios de genoma completo. Estos enfoque son más útiles cuando se busca replicar asociaciones previamente reportadas o incluso replicarlas en otras poblaciones que no hayan sido previamente reportadas. Se suele requerir un tamaño de muestra grande. Se mencionan algunas de las palataformas utilizadas en la siguiente tabla. 

|Plataforma|Proveedor|Química|Número de SNPs|Número de muestras|
|----------|---------|-------|--------------|------------------|
|iSelect Bead Array|Illumina|Enzimática - extensión de nucleótido único|Hasta 60,800|12|
|GeneChip costumizado|Affimetrix|Enzimática - ligación - Sonda de inversión molecular|3,000 , 5,000 o 10,000|1|
|MassArray|Sequenom|Enzimática - extensión de nucleótido único|Hasta 40|384|
|SNPlex|Applied Biosystems|Enzimática-Ligación alelo específica|Hasta 48|96 o 384|
|SNPstream|Beckman Coulter|Enzimática - extensión de nucleótido único|12 o 48|384|
|Taqman OpenArray|Applied Biosystems|Hibridazión diferencial - Sondas Taqman|64|48|

## Otras limitantes y fuentes de error
- Una limitate importante de todas las platafromas mencionadas previamente es que no se puede hacer una haplotipificación molecular directamente. Usualmente, se utilizan métodos estadísticos para inferir el haplotipo, lo cuál puede ser una fuente de error. 
- Otra limitante actualmetne, concierne a aquellas plataformas que utilizan fluorescnecia para la detección. El número de combinaciones de fluoróforos que actualmente hay disponibles limita la posibilidad de *multiplexing*. Se están desarrollando tecnologías con el uso de *quantum dots* los cuales son más estables y tienen un espectro más estrecho los cuál podría aumentar la capacidad de *multiplexing* y reducir las fuentes de error. 
- Por último las plataformas basadas en diferencias en la T<sub>m</sub> son altamente dependientes del contexto de la secuencia en la que se encuentra el SNP. Por lo tanto esto puede ser una fuente de error en regiones donde la secuencia local es "compleja".

## Muestreo
Para los estdios de asociación genética usualmente se utiliza un diseño de casos y controles; siendo los casos aquellos individuos afectados por la enfermedad y los controles aquellos que no la presentan. Adicionalmente, deben ser individuos no relacionados entre sí. Lo más común es utilizar DNA extraído de un muestra de sanfre periférica de los individuos dado que es poco invasivo y tiene un alto rendimiento. En dichos estudios, para alcanzar un poder estadístico adecuado se requiere tener un tamaño de muestra muy grande, para lo cuál es usual hacer este cálculo previo a inciar el muestreo. 

## Software para el análisis Bioinformático de SNPs
El análisis de SNPs en estudios de asociación requiere varios pasos para los cuáles se mencionan algunos de los softwares más comunmente utilizados. 
- **SNP-HWE24** : se utiliza para determinar si los SNPs se encuentran equilibrio Hardy-Weinberg y otros parámetros comunmente utilizados en genética de poblaciones. 
- **EIGENSTRAT** : se utiliza para examinar y en dado caso, ajustar por estratificación y estructura poblacional que representa una variable confusora en estudios de asociación genética. Particularmente, común en poblacion mexicana. No tanto en estudios de población Europea. Para hacer dicha corrección se suelen utilizar hacer un análisis de componentes principales de paneles de *Marcadores Informativos de Ancestría (AIMs)*.
- **MATCH**, **IMPUTE**, **BEAGLE**, **PLINK** : se utilizan para imputar los genotipos de SNPs no genotipados en base a los SNPs genotipados y a relaciones de desequilibrio de ligamiento entre SNPs reportadas en HapMap.
	- En un estudio hecho se determinó que los dos programas con mayor eficiencia y presición fueron IMPUTE y BEAGLE, mientras que sobre todo PLINK tienes desempeños menos acertados y de menor eficiencia. No obstante PLINK utiliza menos memoria de trabajo y tarda menos tiempo por imputación.
- **PLINK** y **R/bioconductor** : se utilizan para los análisis de asociación entre otro tipo de análisis.

Eisten muchos softwares para el análisis de este tipo de datos dependiento del análisis específico que se quiera realizar. 


### Referencias
- Jiannis Ragoussis. Genotyping Technologies for Genetic Research. *Annual Review of Genomics and Human Genetics*. 2009;10:117–33.
- Ding C, Jin S. High-throughput methods for SNP genotyping. *Methods Mol Biol*. 2009; 578: 245–254.
- Andrew D. Johnson. SNP bioinformatics: a comprehensive review of resources. *Circ Cardiovasc Genet*.2009 October ; 2(5): 530–536.
- Tsuchihashi Z, Dracopoli NC. Progress in high throughput SNP genotyping methods. *Pharmacogenomics J*. 2002;2(2):103-10.
- Nothnagel M, Ellinghaus D, Schreiber S, Krawczak M, Franke A. A comprehensive evaluation of SNP genotype imputation. *Hum Genet*. 2009 Mar;125(2):163-71