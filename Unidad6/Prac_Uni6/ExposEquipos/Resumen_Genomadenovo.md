
# Genoma: ensamblado _de novo_
Delil Chincoya, Yolitzin Saldívar y Dulce Hernádez


##### ¿Cuáles son las principales variantes del método de laboratorio para generar mis datos y cuándo es más útil cada una?

Algunos kits son utilizados para aislar ADN genómico de plantas: DNeasy Plant Mini Kit de QIAGEN (con rendimiento de hasta 30 μg de ADN) y PureLink Genomic Plant DNA Purification Kit de Thermo Fisher (con rendimiento de hasta 15 μg de ADN). Ahora bien, si se pretende aislar DNA de organelos (e.g. mitocondrias o cloroplastos) es recomendable usar protocolos específicos, ya que los protocolos convencionales generalmente no dan una cantidad suficiente de DNA para secuenciación directa, y por lo tanto es necesario amplificar por PCR, lo cual puede sesgar los resultados de la secuenciación.     Un ejemplo es REPLI-g Mitochondrial DNA kit de QIAGEN, que tiene un rendimiento de alrededor de 4 μg de ADN).

![technologies.jpeg](https://raw.githubusercontent.com/DelilChincoya/Tareas_Curso_BioinfinvRepro/master/technologies.jpeg)



##### ¿Qué limitantes y posibles fuentes de error puede presentar este método (en el laboratorio o la bioinformática)? ¿Qué puede hacerse para amortiguarlos?

En cuestiones de laboratorio, la literatura recomienda no usar tejido muscular, ya que existe un alto riesgo de que los datos al momento de la secuenciación contengan una alta proporción de ADN mitocondrial. Así mismo, evitar el uso de otros tejidos como intestino y piel, ya que pueden contener  ADN proveniente de organismos xenobióticos. Antes de llevar a cabo el ensamble, se recomienda eliminar las lecturas de secuencias mitocondriales.

Fuentes de error: 
- Usar individuos heterocigotos. Se recomienda usar individuos endogámicos, o descendientes partenogenéticos o ginogenéticos si es posible.
- Usar tejido equivocado. Se recomienda evitar músculo, intestino y piel, ya que el músculo tiene gran cantidad de mtDNA, y el intestino y la piel pueden contaminar la muestra con DNA de organismos xenobióticos.
- Escoger mal la preparación de la biblioteca. Esto puede causar un sesgo en la proporción de GC, artefactos de amplificación, irregularidad en la cobertura, un mapeo pobre y lecturas no informativas.
- Usar un programa bioinformático inadecuado para el ensamblaje. 
- No remover secuencias contaminantes (secuencias de vectores y primers)
- Suposiciones equivocadas de las tasas de polimorfismo puede hacer que los ensambladores desechen genes, principalmente cuando son miembros de familias de genes muy cercanas.

Cómo amortiguarlos:

- Planear con anticipación el proyecto, y determinar qué tipo de problemas pueden surgir de acuerdo al tipo de genoma, qué bibliotecas usar, qué tecnología de secuenciación, y qué softwares para ensamblar las secuencias

Además:
- Remover las secuencias de lecturas de mtDNA antes de comenzar el ensamblaje.
- Filtrar los artefactos generados durante la etapa de pre-ensamblaje.
- Usar secuenciación dirigida (targeted senquencing) en áreas particulares donde no se está seguro de un buen ensamblaje.
- Planear con anticipación el tamaño de bibliotecas que se van a utilizar, de preferencia generar más de un tipo de biblioteca por cada tamaño de inserto. Se aconseja tener una mezcla de tamaños en el rango de 0.2-40 Kb, donde las bibliotecas más pequeñas son secuenciadas a una mucho mayor profundidad. Correr en paralelo un proyecto de RNA-seq.



##### ¿El muestreo requiere algún diseño específico? Por ejemplo, si se quiere secuenciar un genoma *de novo* ¿qué individuo sería ideal?

Idealmente, los organismos homocigotos son los elegidos para este tipo de estudios, pero… no es así en la vida real, ya que para tener un organismo así, es necesario llevar a cabo muchas cruzas y, por lo tanto, es pérdida de tiempo.

En el siguiente [artículo](https://www.ncbi.nlm.nih.gov/pmc/articles/PMC3626508/pdf/2047-217X-1-8.pdf) dan una serie de sugerencias sobre el diseño experimental que se debe llevar a cabo. Dichas consideraciones incluyen tomar en cuenta para que se requiere el tejido y la biología misma del organismo a colectar, la cantidad de ADN para obtener el genoma completo, evitar ciertos órganos para evitar una confusión sobre el origen del ADN, tejidos parasitados o enquistados. Lo ideal sería obtener al ADN de tejidos blandos (en el caso de animales). Para el caso de [plantas](https://www.researchgate.net/post/Which_part_of_the_plant_is_most_preferred_for_DNA_isolation), no es tan estricto, pero preferentemente los meristemos son los elegidos. También se pueden usar otras partes de las plantas como brotes, hojas, flores, semillas e incluso el polen.

**Por último pero no menos importante, debemos tener antecedentes del tamaño del genoma para poder hacer la planeación de los recursos computacionales que se deben tener.**

##### Menciona al menos dos softwares principales que se utilicen para realizar la parte medular de los análisis bioinformáticos de este tipo de análisis (e.g. si es ensamblado *de novo* con qué se ensambla, no con qué se hace el pre-procesamiento) y cuáles son los pros y contras de cada uno. 

Muchos softwares están diseñados para ensamblar las secuencias de tecnologías de lecturas largas o cortas.

Dentro de las estrategias para el ensamblaje de lecturas cortas están los métodos basados en extensión (extension-based methods) y los algoritmos gráficos De Bruijn (De Bruijn graph algorithms).

Los tres softwares se basan en los algoritmos de gráficos de Bruijn.

Un gráfico es un conjunto de objetos llamados vértices o nodos unidos por enlaces llamados aristas o arcos que permiten relaciones entre los elementos de un conjunto. El gráfico de Bruijn se refiere a un gráfico dirigido que representa solapamientos entre secuencias con grados iguales o similares, en el que las secuencias superpuestas se representan con un k-mero. Todas las lecturas se dividen  en (L - k +1) k-meros, donde L es la longitud de la lectura y k el tamaño del k-mero. Una vez que se ha construido la gráfica, el recorrido óptimo es identificado en la gráfica.

![](https://raw.githubusercontent.com/DelilChincoya/Tareas_Curso_BioinfinvRepro/master/Imagen%201.jpg)

![](https://raw.githubusercontent.com/DelilChincoya/Tareas_Curso_BioinfinvRepro/master/Imagen%202.jpg)

El siguiente [link](http://vis.usal.es/rodrigo/documentos/bioinfo/muii/sesiones/4-ensamblado.pdf) tiene una explicación de los algoritmos que se usan para el ensamblado de genomas, a parte del ya explicado. 

###### Platanus
[Kajitani, R. *et al.*2014. Efficient de novo assembly of highly heterozygous genomes from whole-genome shotgun short reads](https://www.ncbi.nlm.nih.gov/pmc/articles/PMC4120091/pdf/1384.pdf)
[Patel, S. *et al.* 2018. Comparison of three assembly strategies for a heterozygous seedless grapevine genome assembly](https://bmcgenomics.biomedcentral.com/track/pdf/10.1186/s12864-018-4434-2?site=bmcgenomics.biomedcentral.com)
[Thomas Hackl. 2016. A draft genome for the Venus flytrap, *Dionaea muscipula*](https://d-nb.info/1111888663/34)

Uso:
- Reconstruye secuencias genómicas de diploides altamente heterocigotos.
- Funciona con el tipo de algoritmo de grafos Brujin.
- Se diseñó especialmente para abordar ensamblajes de genomas de tamaño de gigabases.

Pros:
- Captura regiones heterocigoticas que contienen variaciones estructurales, repeticiones y/o sitios de baja cobertura.
- Cuando se usan los parámetros determinados usa poca memoria RAM (aprox. 800 Gb), pero... 

Contras:
- … cuando dichos parámetros son modificados se usa más memoria para finalizar el ensamblaje (900 Gb).
- Profundidad de cobertura óptima >80. Es decir, requiere el doble de secuencias de cobertura que otros ensambladores.

###### ABySS

Uso:
- Ensamblador de secuencias paired-end. Originalmente diseñado para trabajar con lecturas cortas. 

Pros: 
- Tiene un bajo consumo de memoria RAM, por lo que es muy útil cuando se requieren ensamblar genomas grandes.

Contras: 
- Es relativamente lento.


Para mayor [información ve al siguiente link](http://www.bcgsc.ca/platform/bioinfo/software/abyss) o también puedes encontrar más [inforación aquí](http://www.ehu.eus/sgi/software-de-calculo/abyss)

###### SOAP de novo
Uso:
- Fue usado para ensamblar el genoma del panda giganta.

Pros:
- Usa una cantidad mediana de memoria RAM.
- Es relativamente rápido (probablemente el ensamblador más rápido dentro de los gratuitos).
- Contiene un  scaffolder y un corrector de lectura.
- Es relativamente modular (corrector de lecturas, ensamblaje, scaffold, gap-filler).
- Trabaja muy bien con lecturas cortas.

Contras:
- Un poco confuso en los contigs que fueron construidos.
- Uso relativamente alto de memoria RAM (150GB).

Existen otros softwares los cuales podrás encontrarlos y tener una breve reseña <a href="https://en.wikibooks.org/wiki/Next_Generation_Sequencing_(NGS)/De_novo_assembly>">aquí</a>





