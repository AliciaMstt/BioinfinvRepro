
####1) ¿Cuáles son las principales variantes del método de laboratorio para generar mis datos y cuándo es más útil cada una?


Los marcadores RAD (Restriction site Associated DNA) forman parte de una familia de protocolos para llevar a cabo secuenciación de nueva generación. Dicha familia es conocida como "métodos de representación reducida del genoma" la cual consiste en fragmentar el genoma con enzimas de restricción para crear una librería genómica la cual será secuenciada de manera masiva. La principal ventaja de los métodos RADseq es que permiten examinar simultáneamente decenas de miles de loci con costos mucho menores a los que tiene la secuenciación de genomas completos. Los métodos RADseq pueden ustilizarse independientemente de si existe o no un genoma de referencia y tienen diversas aplicaciones. Entre estas, estudios poblacionales y filogeográficos con todo tipo de organismos. Para la creación la librería, los fragmentos generados después de la digestión son ligados a adaptadores específicos servirán para llevar a cabo la amplificación diferencial de fragmentos, anclado y posterior secuenciación en la plataforma seleccionada (principalmente Illumina).

Existen diversas modificaciones de esta familia de representación reducida del genoma los cuales se han hecho a partir del método de RAD original. Dichas modificaciones se diferencían entre si mediante variaciones en los métodos de creación de las librearias. Las principales variantes se observan en la cantidad de enzimas de restricción utilizadas en la digestión (una, dos o tres), la estrategia de amplifación de estos fragmentos por PCR y finalmente el método de selección de tamaños (directos o indirectos). Sin embargo,a pesar de la gran 
diversidad de métodos, las estrategias más utilizadas son el **RAD, ddRAD y GBS** (Andrews et al., 2016).

a) El **RADseq original**, digiere el ADN genómico con una sola enzima de restricción, y a continuación se hace fragmentación mecánica para reducir los fragmentos a la longitud apropiada para la secuenciación. Esto crea que haya cierta variación en los tamaños de los fragmentos para cada locus (Andrews 2016).


![Resumen de preparacion de librearias de RADseq con metodo original. Tomado de Andrews et al., (2016)](http://user-images.githubusercontent.com/36041423/38107299-bee7368a-334e-11e8-9306-c2b192816711.JPG)


b) El **GBS** (Genotyping By Sequencing) usa una enzima de corte frecuente y amplifica preferentemente fragmentos cortos. SBG (Sequence-Based Genotyping) usa o dos enzimas de corte frecuentes y una infrecuente, el PCR amplifica preferencialmente los fragmentos más cortos (Andrews 2016).

![Resumen de preparacion de librearias de Genotyping by Sequencing (GBS). Tomado de Andrews et al., (2016)](http://user-images.githubusercontent.com/36041423/38107338-db9f91aa-334e-11e8-904c-fcd633af787b.JPG)

c) El **RAD de doble digestión (ddRAD)** usa dos enzimas de restricción, con adaptadores específicos para cada enzima y selección de tamaño por geles de agarosa (Andrews 2016).

![Resumen de preparacion de librearias de Double Digest Radseq (ddRAD). Tomado de Andrews et al., (2016)](http://user-images.githubusercontent.com/36041423/38107316-cdd03c28-334e-11e8-9eb2-43071a94b384.JPG)


####2) ¿Qué limitantes y posibles fuentes de error puede presentar este método (en el laboratorio o la bioinformática)? ¿Qué puede hacerse para amortiguarlos?

![Principales pasos para llevar a cabo secuenciacion de nueva generacion con ddRAD](http://assets.illumina.com/content/dam/illumina-marketing/images/tools/sequencing/ddradseq.png)

La mayoría de métodos RADseq permiten cierta flexibilidad en la cantidad de ADN por muestra que se requiere, que a menudo puede variar entre 50-100ng totales de ADN por muestra.

Un genoma muy fragmentado puede tener consecuencias en la creación de las librerías, y por lo tanto, en la diversidad genética. Por tanto es necesario colectar (o preservar el tejido) lo más fresco posible. Cuanto más reciente sea la extracción se podrá tener mayor cantidad y calidad de ADN. Se puede trabajar con extracciones viejas y purificarlas con perlas magnéticas, pero usualmente es más difícil obtener buenas cantidades de ADN.

Al elaborar las librerías se debe ser sumamente cuidadoso, especialmente al hacer purificaciones con perlas magnéticas. Cada vez que se preparan perlas es necesario probar que funcionen correctamente, porque de lo contrario las muestras se echarían a perder completamente. Al hacer las purificaciones se debe respetar estrictamente la proporción de perlas:muestra que se requiere en cada paso del protocolo, ya que esto es vital para la selección de tamaño de los fragmentos a utilizar. Por ejemplo, cuanto menor la razón perlas:ADN, se retienen preferentemente fragmentos de ADN más largos y más fragmentos pequeños se descartan. se debe cuidar también  tener las pipetas muy bien calibradas para evitar cualquier error en las cantidades utilizadas. Al remover las perlas tras purificar, también se debe cuidar muy bien no dejar residuos de perlas en las muestras, ya puede contaminarlas e impedir la secuenciación.


![Metodologia basica del uso de perlas para purificacion de fragmentos obtenidos despues de los pasos de amplificacion por PCR](http://1.bp.blogspot.com/-dAf9wAkEvJU/T5lpRl5tHnI/AAAAAAAAAT0/R_n9MO9EEKI/s400/Screen+Shot+2012-04-18+at+13.13.07.png)


Otro problema asociado a los metodos basados en la fragmentacion aleatoria del genoma esta relacionado con los niveles de polimofismo en las regiones de corte de las enzimas de restriccion. Variacion en estas regiones de corte pueden ocasionar que ciertos loci no sean genotipicados en algunos individuos provocando que ciertos loci parezcan ser homocigos cuando no lo son debido al _"allele drop out"_  subestimando los niveles de diversidad genetica de la poblacion (Andrews et al., 2016). Por otro  lado, los ciclos de amplificación de los fragmentos que se llevan a cabo antes de la secuenciación pueden afectar los estudios de diversidad genetica. Esto se debe a una amplificación diferencial de un alelo específico, ocasionados por amplificacion de regiones con altos niveles de GC, lo cual se reflejará una mayor cobertura de dicho alelo ocasionando sugiriendo un falso loci homocigoto que causará una subestimación de la diversidad genética (Andrews et al. 2016). Sin embargo, se ha sugerido nque esta subestimación de la diversidad solo causaría un sesgo significativo en poblaciones donde la diversidad a nivel del genoma es mayor al 2% además de que se pueden utilizar de correcciones estadísticas en la estimación de parámetros de genética de poblaciones (Cariou et al., 2016). Ademas, dado que dichos problemas de amplificacion diferencial se pueden solucionar mediante el uso de polimerasas de alta fidelidad (Purtiz, et al., 2014).

A nivel bioinformático, una de las principales limitantes de este tipo de métodos es que solo se secuencian fragmentos aleatorios del genoma (esto es debido a la amplifiación diferencial de fragmentos o a la seleccion de fragmentos de tamaño específico). En este sentido, la selección de tamaño de fragmentos podría sub- (o sobre-) estimar los parametros de genética de poblaciones (diversidad y estructura) debido a que algunas regiones del genoma en donde se encuentran sitios de corte podrían estar asociados a regiones de alto o bajo polimorfismo. Además, se ha sugerido que la fragmentación aleatoria del genoma podría dejar fuera regiones en donde haya señales de adaptación a nivel molecular (Lowry et al., 2017), aunque otros autores sugieren lo contrario (Catchen et al., 2017). En este sentido, los análisis de adaptación podrian complementarse mediante el la combinacion RADseq y otros marcadores transcriptoma, captura de exones, etc (Lowry et al., 2017).

####3. ¿El muestreo requiere algún diseño específico? ¿Diferencia con RAD normal u otros tipos de RAD?

El ddRAD se usa principalmente para detección de SNPs. La principal diferencia con el RAD tradicional es que se reemplaza la ruptura mecánica de fragmentos (que generalmente se hace con sonicación) agregando una segunda enzima de restricción a la digestión, para mejorar la capacidad de ajuste y precisión en la selección de talla. El protocolo también incluye otro adaptador para permitir la combinación de índices y facilitar el multiplexado de las muestras, incorporando simultáneamente barcodes dentro de la muestra y los índices Illumina. Así las muestras pueden poolearse luego de la ligación pero antes de la selección de tallas. Además reduce el costo de las librerías casi 5 veces respecto a las librerías RAD normales (~$5 para cada muestra ddRAD, versus ~$25 RAD) (Peterson _et al._ 2012)

http://journals.plos.org/plosone/article?id=10.1371/journal.pone.0037135


Entre de las principales ventajas de ddRAD de este protocolo es que no se requiere tener un genoma de referencia, es menos costoso que la secuenciación de un genoma completo y se puede ajustar la cobertura seleccionando diversas enzimas de restricción. Como cualquier método de representación reducida, puede haber gaps en la cobertura del genoma y requiere ADN de la mejor calidad posible. 

(Fuente: https://www.illumina.com/science/sequencing-method-explorer/kits-and-arrays/ddradseq.html)

Los estudios de Flanagan y Jones (2017) al comparar los sesgos de los métodos ddRAD y RAD tradicional, encontraron que las estadísticas de cobertura, heterocigosidad observada y frecuencia alélica difirieron significativamente entre los dos protocolos, al igual que los resultados del Análisis de Componentes Principales.

Como todo análsis de genética poblacional, el principal objetivo es capturar la mayor cantidad de marcadores para poder estimar de manera certera la diversidad genética de una especie o población. La decisión acerca de la cantidad de individuos muestreados por población o especie va a definirse por el tipo de marcador. En este sentido se ha sugerido que para el marcador ddRAD una muestra mayor a 8 individuos en una población va a ser redundante para la estimación de parámetros de diversidad intra- e inter-específica (Nazareno et al. 2017). Además, debido a que la creación de la librerías puede llegar a ser una de las partes más costosas de la secuenciación, y que por lo tanto limita la cantidad de individuos muestreados, se ha sugerido que un muestreo por "pool" en el cual una población de diferentes individuos tiene un solo identificador. Dicho tipo de muestreo pude hacer que se analizen más poblaciones y más individuos por población. Sin embargo, va a limitar el uso de ciertos estimadores de genética poblaciones.


####4. Menciona al menos dos softwares principales que se utilicen para realizar la parte medular de los análisis bioinformáticos de este tipo de análisis

UNo de los programas mas utilizados para trabajar con datos RAD es Stacks. Este programa tiene diferentes _"pipelines"_ que permiten trabajar diferentes etapas del manejo de datos, desde el filtrado de secuencias de calidad hasta analisis filogenomicos, poblaciones y la crfeacion de mapas de ligamiento.

Por otro lado, existen otros programas que realizaran de manera independiente cada una de las etapas. Ejemplos de esto es _"FASTQC"_ para el filtrado de secuencias; _"poppr"_ en R para hacer analisis de genomica poblacional.


https://www.france-bioinformatique.fr/sites/default/files/V08_Yvan%20Le%20Bras%20-%20Training%20RADSeq_0.pdf

https://omictools.com/rad-seq-category

https://genomics.ed.ac.uk/services/introduction-rad-seq-data-analysis

###Bibliografía

Andrews KR, JM Good, MR Miller, G Luikart, and PA Hohenlohe. 2016. Harnessing the power of RADseq for ecological and evolutionary genomics. Nature Reviews Genetics 2:8192. doi: 10.1038/nrg.2015.28

Catchen JM, PA Hohenlohe, L Bernatchez, WC Funk, KR Andrews, and FW Allendorf. 2017. Unbroken: RADseq remains a powerful tool for understanding the genetics of adaptation in natural populations. Mol. Ecol. Resources. doi: 10.1111/1755-0998.12669

Graham, C. et al. Impacts of degraded DNA on restriction enzyme associated DNA sequencing (RADSeq). Mol. Ecol. Resour. 15, 13041315 (2015).

Lowry DB, S Hoban, JL Kelley, KE Lotterhos, LK Reed, MF Antolin, and A Storfer. 2016. Breaking RAD: An evaluation of the utility of restriction site associated DNA sequencing for genome scans of adaptation. Mol. Ecol. Resources. 17:14252. doi: 10.1111/1755-0998.12635

Peterson BK, Weber JN, Kay EH, Fisher HS, Hoekstra HE (2012) Double Digest RADseq: An Inexpensive Method for De Novo SNP Discovery and Genotyping in Model and Non-Model Species. PLoS ONE 7(5): e37135. https://doi.org/10.1371/journal.pone.0037135

Flanagan SP, AG Jones. 2017. Substantial differences in bias between single-digest and double-digest RAD-seq libraries: a case study. Mol Ecol Resour. https://doi:10.1111/1755-0998.12734.

Hoffberg SL, TJ Kieran, JM Catchen, A Devault, BC Faircloth, R Mauricio, TC Glenn. 2016. RADcap: sequence capture of dual-digest RADseq libraries with identifiable duplicates and reduced missing data. Mol. Ecol. Resources https://doi.org/10.1111/1755-0998.12566
