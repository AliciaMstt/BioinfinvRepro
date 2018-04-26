**DATOS RAD PARA INFERENCIA FILOGENETICA (ÉNFASIS EN SOFTWARE)**

*Alma Melisa Vázquez López*
*Tonatiuh Ramírez Reyes*



**Ensamble de locus**

El objetivo es: Optimizar el número de loci homólogos.

Fuentes de error:

-Perdida de alelos por mutaciones en el sitio de corte de la enzima de restricción:

Ensayos in silico muestran que linages con un rango de divergencia de 5 a 63 millones de años pueden ser genotipificados con RADseq.

-Duplicados
-Errores de secuenciación

**PyRAD**

Es un software-pipeline el cual ensambla loci RAD-seq alineados para análisis poblacionales o filogenéticos, con énfasis en análisis de muestras altamente divergentes.
Difiere de *Stacks *y *Rainbow* ya que utiliza un algoritmo de agrupamiento global con ayuda de *USEARCH*, el cual permite incorporar variación  de *indels* mientras identifica homologías.

 
 ![](/home/melisa/Resumen_RADseq filogenias2_software/Fig. 1 . indels_pyrad.png) 
 
 
 
 
    Fig. 1. Eficiencia para incorporar indels en PyRad vs. Stacks. 

 
 
Ventajas:
- velocidad
- flexibilidad de múltiples tipos de datos RADseq
- datos divergentes (filogenias profundas)
- fácil de implementar 

Requerimentos:
- USEARCH 
- MUSCLE
- paquetes de Python (*Scipy* y *Numpy*)

Corre en LINUX y Mac.

El análisis consiste en 7 pasos:

1) Desmultiplexeo (separa por barcodes)
2) Control de calidad y remoción de barcodes, sitios de corte y adaptadores
3) Agrupamiento dentro de muestras y alineamiento
4) Estimación conjunta de tasa de error y heterocigocidad
5) Consenso de "base calling" y deteccion de parálogos 
6) Agrupamiento a través de muestras
7) Alineamiento a través de muestras, filtrado y formateado (FASTA, Phylip, Nexus)

**Agrupamiento opcional jerárquico para rápido agrupamiento a través de muestras para grandes conjuntos de datos**
 Este enfoque divide el trabajo computacional en pequeñas unidades paralelas, aquí los loci son agrupados a través de las muestras dentro de clados definidos por el usuario, en el cual, cada clado utiliza un procesador.
Las semillas de estas "pilas" (*stacks* en inglés) son utilizadas para agruparse con semillas de pilas de otros clados (Fig. 2) antes de que una pila final sea reconstruida a partir de las coincidencias (match) para cada semilla de cada paso de agrupamiento jerárquico.

![](/home/melisa/Resumen_RADseq filogenias2_software/Fig. 2. optional_hierarchical-clustering.png) 
 
    Fig. 2. Optional hierarchical clustering approach for fast across-sample clustering of large datasets in PyRAD. In the first iteration, clustering is performed among samples within each user-defined clade (a, b and c). Dotted lines show clustering of sequences to the randomly assigned seed sequence in each stack. In subsequent steps, the seeds of stacks from previous steps are clustered with the seeds of stacks from other clades. Finally, matches to the seeds at each hierarchical step are reconstructed to build the full stack. A minimum cluster size can be set for each iteration to further increase speed at the cost of accuracy; in the example (min2) singleton loci are removed, causing data from clade b to be lost. (Imagen y texto tomado de  Eaton, 2014 https://www.ncbi.nlm.nih.gov/pubmed/24603985) 



    
Alternativas para el uso de PyRAD: Stacks y RADIS 
Ver los links para más información: 
Stacks: http://catchenlab.life.illinois.edu/stacks/ 
RADIS: https://www.ncbi.nlm.nih.gov/pmc/articles/PMC5039923/

**Breves aspectos de RADIS**

Radis está escrito en Perl diseñado para correr en Linux y Unix.
Procesamiento de secuencias crudas se divide en dos pasos: limpieza y análisis de datos.
Para la limpieza de secuencias utiliza módulos de *Stacks*.
Una vez que los archivos con formato Phylip cumplen con los criterios de selección, son producidos por RADIS y están listos para implementarlos en RAxML. 
Datos combinados (concatenación de todas las secuencias de cada locus) son analizados utilizando RAxML para producir árboles filogenéticos.

****

**Programas para obtener modelos de sustitución nucleotídica**

- ModelTest-NG
Requiere alineamiento en fasta o Phylip.
- PartitionFinder2
PartitionFinder2 permite seleccionar los mejores esquemas de partición y modelos de sustitución nucleotídica.
Se puede implementar una opción para la búsqueda de modelos disponibles en RAxML. 
Requiere 2 archivos de entrada, un alineamiento en formato Phylip y un archivo de configuración.

 
 ![](/home/melisa/Resumen_RADseq filogenias2_software/Fig. 3. partitionfinder.png) 
 
>
    Fig. 3. Ejemplo de un archivo de salida de PartitionFinder.

 
 

Ver links para más información:
ModelTest-NG https://github.com/ddarriba/jmodeltest2/releases.
PartitionFinder2 https://academic-oup-com.pbidi.unam.mx:2443/mbe/article/34/3/772/2738784, https://github.com/brettc/partitionfinder. 

****
**Programas de inferencia filogenética**

- MÁXIMA VEROSIMILITUD: 
**RAXML-NG** (https://github.com/stamatak/standard-RaxML).
Requiere alineamientos en Phylip
- INFERENCIA BAYESIANA: 
**Mr. Bayes** (https://github.com/NBISweden/MrBayes).
**REVBAYES** (https://github.com/revbayes/revbayes, https://github.com/revbayes/revbayes_tutorial).
Requieren alineamiento en formato Nexus.

**Árboles de especies con SNPs**

- **BEAST 2** con el módulo **SNAPP**, utiliza SNPs, para inferir árboles de especies y gráficos de demografía poblacional bajo un modelo de coalescencia. 
Alineamiento en formato Nexus y un archivo XML de control en BEAUTi.
En Tracer se analiza la convergencia y parámetros de distribucióin posterior para obtener la hipótesis final. 
http://www.beast2.org/snapp/

**Árboles de especies bajo el modelo multiespecies coalescencia**

**BPP** (datos menores a os 1000 loci)
Requiere archivo de secuencias, alineamientos en formato Phylip/paml
Archivo Imap,asigna a los individuos a las especies/poblaciones
Archivo control con los parametros especificados por el usuario (priors en el analisis bayesiano)

****
 **Métodos que utilizan topologías de árboles bajo el modelo multiespecies por coalescencia.**
     
   - **MP-EST** calcula valores de verosimilitud multiplicando las probabilidades trinomiales a través de los tripletes de especies inducidos por el árbol de especies. Como los tripletes de especies no son independientes, la funcion de verosimilitud no es la correcta, es por lo tanto, una aproximacion de seudo- verosimilitud.
    Requiere :
   -Árboles de genes producidos por programas de inferencia filogenética de maxima verosimilitud.
  -Archivo control con los parametros definidos por el usuario.
   
 - **ASTRAL** ensambla cuartetos de árboles. Toma una colección de árboles de genes no enraizados, colecta todos sus cuartetos en un conjunto, los cuales pueden tener muchos cuartetos árboles idénticos, y luego define cada árbol de especies por la forma en que los árboles cuartetos se ajustan en el conjunto. Por lo tanto ASTRAL produce el máximo soporte del arbol cuarteto de especies.
  Requiere:
  - Árboles de genes en formato Newick  

  **Métodos que utilizan longitudes de ramas de árboles de genes (MSC)**
       
   *Los genes se dividen antes que las especies, o los árboles de genes corren dentro del árbol de especies.*
    - **STEAC** define la distancia entre dos especies como el doble del promedio de tiempos de coalescencia (edad de nodo) entre las especies, el resultado es una matriz de distancia que puede ser usado para construir un árbol NJ, el cual sera una estimación consistente del árbol de especies. 
  Requiere:
  - Árboles de genes, puede correr en R.     
    - **Método de invarianza SVDquartets**
    Utiliza un algoritmo que ensambla cuartetos para generar una estimación de arbol de especies. SDVquartets asume que diferentes sitios en los datos de secuencias tienen historias independientes dado el árbol de especies, similar  al metodo SNAPP para datos SNPs.
  Requiere:
  - SVDquartets se implementa en PAUP*
  - Alineamientos en formato nexus o phylip.![](/home/melisa/Resumen_RADseq filogenias2_software/Fig. 1 . indels_pyrad.png) 