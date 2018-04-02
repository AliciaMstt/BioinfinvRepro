**Integrantes del equipo:**

Olivia Rojo Nava

Jetsi Viridiana Mancilla Rojano


## Ensamblaje de *novo* de genomas

Actualmente se han desarrollado diferentes métodos que nos brindan la ventaja de obtener el genoma completo de un organismo, lo anterior, nos permite poder contar con el inventario completo de genes de dicho organismo, mismos que se pueden llegar a expresar en cualquier momento de su ciclo. En bioinformática, el ensamblaje de secuencias es un proceso computacional que se basa en el alineamiento y unión de fragmentos cortos de DNA, los cuales provienen de un proceso de secuenciación, dando lugar a secuencias contiguas de mayor tamaño; permitiendo la reconstrucción exacta de la secuencia. El ensamble de secuencias se puede llevar a cabo utilizando un genoma como referencia, llamado ensamble por comparación; o bien, utilizando sólo la información obtenido de la secuenciación, para llevar a cabo la reconstrucción del genoma en cuestión, conocido como ensamble de *novo*. Generalmente la secuenciación de novo, permite secuenciar organismos nuevos, de los cuales no hay secuencias modelo o de referencia (Figura 1).

![resumen-equipoensamblajedenovo-fig1](https://user-images.githubusercontent.com/36114853/38180372-b910d590-35f1-11e8-85da-8f9dd675937d.jpg)

Figura 1. Ensamble de novo de genomas (Imagen de Nagarajan et al. Nat Rev Genet. 2013)


## 1. ¿Cuáles son las principales variantes del método de laboratorio para generar mis datos y cuándo es más útil cada una?**

-En cualquier proyecto en el que se considere llevar a cabo la secuenciación de un genoma, es importante considerar el tamaño aproximado del mismo, pues de esto dependerá principalmente la plataforma de secuenciación a utilizar.

-La longitud de las reads todavía tiene importantes implicaciones bioinformáticas, ya que los algoritmos de ensamblaje optimizados para lecturas largas son fundamentalmente diferentes a los de lecturas cortas. Además, existen diferentes aspectos que pueden afectar la capacidad de reconstrucción de la secuencia original.

De entre todos estos factores destacan los siguientes (Kisand et al.; 2013):

• La tecnología de secuenciación a emplear puede ser: Illumina, 454, SOLID, PacBio, Sanger.

Cada una de estas plataformas puede tener diferentes equipos, niveles de rendimiento, números de lecturas y, por lo tanto, un costo diferente para cada reacción de secuenciación (Tabla 1 y 2).

Tabla 1. Comparación de diferentes plataformas de secuenciación.

![resumen-equipoensamblajedenovo-tab 1_1](https://user-images.githubusercontent.com/36114853/38180694-28957c5c-35f4-11e8-8e91-fe0344bfea6f.jpg)

Tabla 2. Ventajas y Desventajas de cada plataforma.

![resumen-equipoensamblajedenovo-tabla2](https://user-images.githubusercontent.com/36114853/38180786-af9ecbb8-35f4-11e8-9738-3865a2715dbe.png)

Tomado de : Garrido-Cardenas JA, Garcia-Maroto F, Alvarez-Bermejo JA, Manzano-Agugliaro F. DNA Sequencing Sensors: An Overview. Lobo-Castañón MJ, ed. Sensors (Basel, Switzerland). 2017;17(3):588. doi:10.3390/s17030588.

También se puede consultar: http://www.molecularecologist.com/next-gen-fieldguide-2016/ que brinda una descripción general de NGS.

• El tipo de librería utilizada:

- Single-end
- Paired-end
- Mate-pairs

A través de mate -pairs y paired-end se maximiza la profundidad de cobertura, debido a que se obtienen contigs más grandes y una mayor precisión de la secuencia consenso final (Figura 2).

![resumen-equipoensamblajedenovo-fig2](https://user-images.githubusercontent.com/36114853/38180423-1f44d582-35f2-11e8-8a1b-4255b46869be.jpg)

Figura 2. Representación de la cobertura en una posición del genoma (Imagen de Nagarajan et al. Nat Rev Genet. 2013).



• Los algoritmos de ensamblado y la capacidad de éstos para llevar a cabo la corrección de errores y la detección de secuencias repetidas.

• El rendimiento computacional: tiempo de ejecución y consumo de memoria. Para saber más sobre los recursos computacionales necesarios y el tamaño de los archivos de datos para las plataformas de secuenciación de ADN disponibles comercialmente, se puede consultar este sitio: http://www.molecularecologist.com/next-gen-table-3b-2014/



## 2 . De novo ¿Qué limitantes y posibles fuentes de error puede presentar este método (en el laboratorio o la bioinformática)?**

De acuerdo con Monya Baker (2012), existen algunas de las siguientes limitantes y fuentes de error en el Ensamble de novo:

-Cuando el genoma de una especie se reagrupa por primera vez, nadie sabe qué es real o qué es lo que falta. En general, cuanto más grande sea el genoma, más errores habrá.

-Los secuenciadores de nueva generación pueden leer pares de bases a un costo mucho menor que  la secuenciación de Sanger, pero las lecturas son mucho más cortas. Por lo que el reto consiste en ¿Cómo ensamblar genomas de alta calidad y cómo reconocerlo?.

-Los errores en el ensamblaje ocurren por muchas razones. A menudo se descartan incorrectamente repeticiones; o se llegan a hacer uniones u orientaciones en sitios equivocados, que pueden llegar a eliminar genes conservados entre diferentes organismos.

-Cada proyecto de ensamblaje es único en términos de estructura de datos generados y el genoma objetivo difiere, por ejemplo, en tamaño, composición de bases y contenido repetido.

-Secuencias repetidas: Las secuencias que contienen el mismo ADN repetitivo se ensamblan entre sí aun proviniendo de distintas regiones del genoma, pudiendo diferenciarlas sólo si contienen partes únicas dentro de su secuencia. Lo anterior genera que no se puedan ensamblar estas regiones, ya que se van a solapar con multitud de copias, lo que va a generar gaps y diferentes contigs. Cuando un ensamblador encuentra lecturas ligeramente diferentes entre sí, debe decidir si las lecturas se derivan del mismo locus o de regiones repetitivas. Las suposiciones erróneas pueden provocar que los ensambladores eliminen genes, particularmente miembros de familias de genes estrechamente relacionadas.

-Saber que las lecturas pareadas (pair-end) se generaron a partir de la misma pieza de ADN puede ayudar a vincular contigs en 'scaffolds', ordenando conjuntos de contigs con espacios intermedios. Los datos de lectura pareada también pueden indicar el tamaño de las regiones repetitivas y qué tan separados están los contigs.

-En ausencia de un genoma de referencia de alta calidad, los ensamblajes de novo del genoma a menudo se evalúan sobre la base del número de scafolds y contigs necesarios para representar el genoma, la proporción de lecturas que se pueden ensamblar, la longitud de contigs y scaffolds en relación con el tamaño del genoma.

-El número de "misassemblies" obtenidos en los contigs ensamblados puede ser debido a errores cometidos durante el proceso de secuenciación o a la formación de quimeras entre las lecturas.


**¿Qué puede hacerse para amortiguarlos?**

-Los secuenciadores están equipados con filtros computacionales para eliminar secuencias mal leídas, así como aquellas que contienen secuencias de artefactos de preparación de bibliotecas y bacterias contaminantes, pero estos filtros no son perfectos.

-Elegir el método de secuenciación más apropiado para nuestro estudio, considerando el tamaño del genoma que esperamos obtener, el contenido de GC y el contenido de regiones repetitivas y principalmente los recursos económicos con los que se cuentan.

-Para el caso de las repeticiones de mayor tamaño que las lecturas, se debe recurrir a estrategias como: pair-ends, matepairs, etc; lo que nos permitirá asegurar que dos lecturas van juntas o separadas por una distancia igual al tamaño del fragmento.

-Encontrar formas de evaluar y mejorar ensambladores. Al utilizar diferentes ensambladores, se debe considerar los algoritmos que estos emplean para llevar a cabo la reconstrucción de las secuencias; con la finalidad de utilizar el más apropiado para nuestros datos. Así mismo, se recomienda ejecutar múltiples ensamblajes , para así obtener el mejor. Considerando que este debe irse refinando.

-Buscar ayuda. La ejecución de un ensamblador requiere una experiencia computacional considerable. "El desarrollador de software normalmente sabe cómo usarlo mejor". Los investigadores también necesitan ayuda para planificar y crear sus bibliotecas.

-Tomar el transcriptoma, también. El análisis de regiones transcritas puede mejorar los ensambles. "Cada proyecto de genoma de novo debe tener un proyecto RNA-seq paralelo".

-Ser realista acerca de los recursos informáticos. El genoma puede ser demasiado grande para la memoria de la computadora.


## 3. ¿El muestreo requiere algún diseño específico? Por ejemplo, si se quiere secuenciar un genoma de novo ¿qué individuo sería ideal? Si trabajo con trascriptomas, ¿cómo afecta el tejido, la edad, las condiciones, etc. mi muestreo?**

Gene Robinson, entomóloga de la Universidad de Illinois menciona que "Se necesitan saber 2 cosas sobre el ensamblaje de novo: ¿Cuánto del genoma se estima que se incluirá en el ensamblaje? Y ¿Cuántas piezas diferentes no conectadas involucra el ensamblaje?. Esos parámetros indican qué tan fácil será realizar análisis comparativos, funcionales y evolutivos en una secuencia de genoma.

El punto más importante que considerar para llevar a cabo una secuenciación de novo, es la calidad e integridad del ADN, independientemente del organismo con el que se este trabajando. Además, para el proceso de secuenciación, se requieren diferentes cantidades de ADN, por lo que es importante también que a través de un método correcto de extracción se obtenga la concentración necesaria para llevar a cabo este proceso.

La precisión e integridad de un conjunto de genoma depende no solo de los programas de computadora y las tecnologías de secuenciación, sino también de las características del genoma que se ensamblará.

Las soluciones que son rutinarias para pequeños genomas bacterianos son imposibles o poco prácticas para los eucariotas.

La selección de un individuo ideal, depende de los objetivos de nuestro estudio y principalmente del tipo de organismo con el que se está trabajando; por ejemplo, en el caso de plantas , se considera no sólo el tamaño del genoma, sino también la poliploidía y la heterocigosidad; pues generalmente se debe recurrir a ensambladores específicamente diseñados (Schatz et al., 2012 ). Debido a lo anterior, se recomienda escoger individuos consanguíneos, partenogénicos (en el caso de anfibios, reptiles, crustáceos, aves, etc).

Si se utilizan tejidos, se debe considerar que las secuencias pueden contener una alta proporción de ADN mitocondrial, lo que puede causar ruido en el momento del ensamblaje, pues se pueden identificar regiones genómicas duplicadas; por lo que se recomienda eliminar estas secuencias antes de llevar a cabo el ensamblaje. Si se utilizan tejidos como la piel y el intestino, se debe considerar que estos contienen un alto grado de compuestos xenobióticos.


## 4. Menciona al menos dos softwares principales que se utilicen para realizar la parte medular de los análisis bioinformáticos de este tipo de análisis (e.g. si es ensamblado de novo con qué se ensambla, no con qué se hace el pre-procesamiento) y cuáles son los pros y contras de cada uno.**

Para el ensamblado de *novo* existen tres algoritmos principales:

**1.	GREEDY.** Permite solapar dos secuenciar y unirlas formando una secuencia nueva, repitiendo este proceso hasta que ya no existan secuencias que puedan ser unidas. Sin embargo, no considera toda la información proporcionada por el total de las lecturas y presenta problemas para el ensamblaje de secuencias repetidas.

**2.	OVERLAP-LAYOUT-CONSENSUS.** Almacena y representa la información a través de grafos; lo anterior lo hace identificando los pares de lectura que se solapan de forma correcta. Al representar la información en un grafo, cada nodo representa una lectura y las conexiones unen las lecturas que se solapan.

**3.	DE BRUIJN GRAPH.** Se basa en la relación entre sub-cadenas de nucleótidos de longitud K, los cuales son extraídas de las lecturas originales. Se basa en la coincidencia entre k-meros , corrigiendo errores y dando lugar a un ensamble de mayor calidad (Figura 3).

![resumen-equipoenamblajedenovo-fig3](https://user-images.githubusercontent.com/36114853/38180545-047c5558-35f3-11e8-9b84-c91100e019f3.jpg)

Figura 3. Gráfico de Bruijn (Imagen de Nagarajan et al. Nat Rev Genet. 2013).


Existe una cantidad de software disponible para el ensamblaje de *novo* de los datos de secuenciación de genoma (Figura 4)

![resumen-equipoensamblajedenovo-fig4](https://user-images.githubusercontent.com/36114853/38180555-136dbfca-35f3-11e8-9864-23b7288bb38d.png)

Figura 4. Lista de ensambladores de novo, plataforma de secuenciación y algoritmo.


El ensamblador de novo Velvet, está basado en la construcción de grafos de Bruijn. El ensamblador Velvet puede ensamblar cualquier tipo de lecturas, pero en realidad está diseñado para el ensamblado de lecturas cortas que van desde 25 – 50 pb. Es uno de los más utilizados en el ensamblado de genomas bacterianos secuenciados previamente con la plataforma Illumina. Además, la principal ventaja de este ensamblador es que puede eliminar errores producidos por el experimento de secuenciación y resuelve repeticiones causadas por la complejidad del genoma (Nagarajan y Pop, 2013).

El ensamblador Velvet está formado por dos programas independientes pero complementarios:

• **Velveth:** se encarga de construir la estructura de datos que se va a utilizar para ensamblar todo el conjunto del genoma.

• **Velvetg:** este programa es el núcleo del ensamblador y se encarga de construir el grafo de Bruijn para conseguir ensamblar las lecturas que introducimos como parámetro en la línea de comandos. Además, este programa es el encargado de eliminar los errores y detectar las secuencias repetidas.

También hay enfoques de ensamblaje "híbridos", por ejemplo, Atlas Ray, MaSuRCA y MIRA (Zimin et al., 2013), que combinan características de diferentes algoritmos y utilizan datos de múltiples tecnologías de secuenciación.

El software **MIRA** por ejemplo puede integrar distintas plataformas de secuenciación; sin embargo, el ensamblaje se lleva a cabo de forma lenta, por lo que no se puede utilizar para genomas de gran tamaño. Se puede utilizar diferentes formatos como FASTA, FASTQ, CAF,GenBank, y a su vez, los resultados pueden darse en formato ACE,CAF,HTML,TXT. Una característica importante de este es que permite que en secuencias como Sanger y 454 ROCHE se puedan eliminar errores de secuenciación, mejorando la calidad del ensamblado; así mismo, permite etiquetar SNPs, inserciones y deleciones.

En general, es aconsejable probar varios métodos de ensamblaje diferentes y evaluar cuál es el más apropiado para los datos específicos disponibles.

Al elegir el software de ensamblaje, es importante considerar tanto la cantidad de datos de secuenciación como los recursos computacionales disponibles (Schatz et al., 2010). Los métodos gráficos de De Bruijn, generalmente requieren grandes cantidades de memoria de cálculo (RAM).

**Literatura citada:**

-Baker M. 2012. De *novo* genome assembly: what every biologist should know. Nature Methods 9(4):333-37.

-Garrido-Cardenas JA, Garcia-Maroto F, Alvarez-Bermejo JA, Manzano-Agugliaro F. DNA Sequencing Sensors: An Overview. Lobo-Castañón MJ, ed. Sensors (Basel, Switzerland). 2017;17(3):588. doi:10.3390/s17030588.

-Kisand V., 2013. Genome sequencing of bacteria: sequencing, de novo assembly and rapid analysis using open source tools. BMC Genomics. 1;14:211.

-Li, R., Zhu, H., Ruan, J., Qian, W., Fang, X., Shi, Z.,Wang, J. (2010). De novo assembly of human genomes with massively parallel short read sequencing. Genome Research, 20(2), 265-72. DOI: 10.1101/gr.097261.109

-Nagarajan N. y Pop M., 2013. Sequence assembly demystified. Nat Rev Genet. 14(3):157-67.

-Schatz M.C., Witkowski J., McCombie W.R., et al. 2010. Current challenges in de novo plant genome sequencing and assembly. Genome Biol. 13(4):243.

-Zerbino DR, Birney E. Velvet: algorithms for de novo short read assembly using de Brujin graphs. Genome Res. 2008;18:821–829. doi: 10.1101/gr.074492.107.

-Zimin A.V., Marçais G., Puiu D., Roberts M., Salzberg S.L., Yorke J.A. 2013. The masurca genome assembler. Bioinformatics.29(21):2669–77.

-https://genome10k.soe.ucsc.edu/node/130 - Consultado el 29 de Marzo de 2018.
