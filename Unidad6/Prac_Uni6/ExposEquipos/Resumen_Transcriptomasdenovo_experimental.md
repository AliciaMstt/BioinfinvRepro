Equipo: Isaura Rosas Reinhold
		Melania Andrea Vega Angeles
        
        
## Transcriptomas *de novo* (Experimental)
##### ¿Para qué es útil este análisis?
Principalmente el uso de transcriptómica está aplicado a responder preguntas del área médica y evolutiva, ya sea con fines académicos o industriales. Las ventajas del uso de NGS es que nos permiten flexibilidad para diseñas estudios según preguntas muy particulares.

Este método permite identificar genes candidados, analizar la codificación de proteínas, realizar perfiles de expresión génica, detectar RNA no codificante, describir arreglos del transcripto, analizar la variación de nucleótidos, comparar elementos transponibles, observar patrones de expresión génica, diversivicación o alteraciones epigenéticas. Además Estudios de expresión de genes bajo ciertas condiciones o estimulos, así como análisis de expresión genes bajo condiciones particulares como vernalización o respuesta a hormonas.

![tabla comparativa](https://github.com/Melcatus/transcriptomasdenovo/blob/master/tabla%201.png)

##### Transcriptoma: conjunto de transcritos en una célula en una muestra biológica para un estadío específico de desarrollo o una condición biológica.

#### Diseño del muestreo

El **muestreo** es parte fundamental del desarrollo de nuestra investigación. La cantidad de material muestreado depende de tres puntos:
1. nuestra pregunta de investigación
2. el taxa con el que se trabaja
3. la localización de la expresión a analizar (tejido necesario)

sobre todo en el punto tres hay errores comunes como que se colectara tejido en donde no hay expresión de lo que se busca, no sea la hora en la que se expresa o la fase de desarrollo.

Como recomendación: **congelar en nitrógeno liquido el material biológico al instante de colectarlo**.

**¿Para la realización de untranscriptoma *de novo* el individuo ideal a colectar es ? **

No existe un individuo ideal, ya que cualquier especie puede ser utilizada para realizar RNA-seq y transcriptomas *de novo*, sin embargo hay que tomar en cuenta ciertas condiciones, por ejemplo, pueden ser especies con un clado definido si queremos resolver preguntas de expresión, función o estudios clásicos de genes, la investigación se puede enfocar en taxa relacionados que tengan multiples carácteres ganados, perdidos o modificados, se pueden incluir formas transcionales de carácteres de interes en caso de preguntas de evolución del desarrollo. Otro factor a considerar es que sean de fácil cultivo ( en el caso de bacterías, hongos,plantas y algas), asegurando que tengamos material a disposición.

Si queremos ver patrones de expresión relacionados a ciertas condiciones ambientales, por ejemplo, debemos tener control sobre lo que vamos a evaluar para poder comprar correctamente y correlación los cambios ambientales con los patrones de expresión.

Todo va a depender de la pregunta, algunos estudios usan la misma especie en diferentes momentos de desarrollo, otros evaluan transcriptomas de diferentes órganos, otros diferentes especies en el mismo estadio, hay estudios de especies silvestres contra especies cultivadas, en diferentes ambientes, étc.

#### Métodos de extracción

Los **métodos de extracción** van desde el uso de algún kit especial para bacterias, virus, hongos, plantas o animales o a través del protocolo de Tioisocianato de guanidina (Trizol, *Invitrogen*), bromuro de hexadecil trimetil amonio (CTAB) y fenol/cloroformo seguido de purificación con columnas  en el caso de las plantas. Los primeros son más útiles cuando tenemos tejidos dificiles, sin embargo aunque obtenemos RNA de buena calidad se obtiene en menores cantidades y los segundos son más económicos pero presenta problemas en calidad de RNA para RNA-seq.

Es de suma importancia que se limpie el área de trabajo para disminuir la contaminación debido a que se trabaja con **RNA** y el riesgo por degradación por RNAsas es muy alto.

Una vez elegido el protocolo de extracción se debe contemplar que al moler el tejido este se fragmente lo suficiente para mantener lo más completo posible el RNA ya que mientras más información tengamos hacer el ensable resultará de mayor calidad. Este punto es crucial, ya que una buena molienda nos otorgará un mejor rendimiento en la extracción, ya se con kit o con algun otro método.

Debido a que solo el 1-2% es RNAm se recomienda usar limpiadores del resto de RNA y posteriormente hacer la medición de cantidad obtenida con el Qubit. Si requieren información detallada sobre el uso del aparato pueden visitar su [manual](https://tools.thermofisher.com/content/sfs/manuals/qubit_3_fluorometer_man.pdf)

En cuanto a la cantidad y concentración del ARNm que requiere el RNA-seq, el rango está actualmente entre 5 y 10 μg, con una concentración  alrededor  de  500  ng/μl

El uso de **DNAsas** es recomendable, así como el de limpiadores de **RNAsas**, existen diferentes marcas, como DNAsa away y RNAsa away de Invitrogen.

Durante este paso los errores comunes son:
- contaminación
- degradación de RNA por RNAsas
- baja cantidad y calidad de RNA

	##### ¿Variables del método general para generar mis datos?



Los errores mencionados con anterioridad tendrán repercusión en la secuenciación y ,por lo tanto, en el manejo de nuestras secuencias.

#### Librerías y secuenciación

Una vez obtenida una buena cantidad de RNA de buena calidad se hacen la librerías a partir de la sintesis de cDNA, esta sintesis se hace con transcriptasa reversa. Posteriormente el cDNA se fragmenta. Esta fragmentación se puede realizar por el método de nebulización, por digestión con enzimas de restricción, o a través del uso de cationes divalentes bajo condiciones de presiones elevadas.

Dependiendo de la plataforma de secuenciación los fragmentos de cDNA pueden o no ligarse a adaptadores en los extremos 3' y 5',


Existen diferentes kits de preparación de librerías, su elección depende de la pregunta, objetivos del estudio, y por lo tanto de la plataforma en la que se va a secuenciar.

Antes de someter las muestras al secuenciador se debe realizar las librerías. Se usan dos métodos principales: colas de poliA y ribodepletion. La elección de alguno de los dos métodos dependerá de la calidad y cantidad de RNA obtenido. Por ejemplo, colas de PoliA resultó ser un método más eficiente que el segundo ya que percibió mejor la expresión de genes y al hacer el alineamiento

![comparacion metodos](https://github.com/Melcatus/transcriptomasdenovo/blob/master/comparacion%20de%20m%C3%A9todos%20bibliotecas.gif).

Pero si al hacer la extracción se obtuvtiene RNA degradado se sugiere emplear el método ribodepletion.

La **secuenciación** se puede hacer simple o extremos pareados (esta última para ensable *de novo*).

Un problema en secuenciación *de novo* es que las lecturas de longitud corta generadas pueden resultar en muchos gaps, es decir, regiones donde no se pueda alinear, por lo tanto obtenemos un *contig* fragmentado y datos pobres.

Por eso algunas plataformas de NGS como illumina ofrecen protocolos de secuenciaciń con finales pareado (Paired-ends, PE), resultando en un mejor alineamiento y produciendo *contigs* más largos, sin gaps resultando en una covertura completa.

Se **recomienda** tener 3 réplicas por muestra para aumentar el poder estadístico, el uso de 2 o másenzimas que hagan cortes de diferentes longitudes y lecturas entre 5-100 millones de lecturas por secuencia para tener mejor **covertura**.

La **Covertura**, que se refeire al número promedio de lecturas de secuecia que se alinean con cada base en la muestra. La **covertura** puede sintonizarse dependiedo del experimento, ofreciendo numerosas ventajas en el diseño experimental, ya que a mayor covertura tenemos mayor sesibilidad.

Otro factor que aumenta la calidad de la secuenciación *de novo* es el tamaño de los insertos en la libreria, fragmentos largos en una secuenciación PE, insertos del tamaño de 2-5 Kb obtenemos datos más optimos para la secuenciación *de novo*.

Librerias con insertos grandes resultan en ensambles menos fragmentados y *contigs* más largos.

#### Plataformas de secuenciación

La tecnología RNA-seq actualmente está disponible comercialmente en las compañías Roche/454, Solexa/Illumina,  SOLiD/Life  Technologies  y  Helicos/BioSciences; sin embargo, de las tecnologías de NGS disponibles las más aplicadas son Roche/454 y Solexa/Illumina

Para mayor información https://www.illumina.com/techniques/sequencing/rna-sequencing/mrna-seq.html

La plataforma de secuenciación a elegir dependerá de cuál es la longitud de las lecturas que se desea obtener, así como si se cuenta o no con un genoma referencia e indudablemente del presupuesto con el que se disponga.

Cuando se trata de transcriptomas *de novo* lo que más se recomienda es tener lecturas más largas para ensamblar con mayor facilidad.

#### Barcodes o códigos de barras

Es recomendable usar códicos de barras en nuestras librerías, estos códigos son patrones de reconocimiento (secuencias cortas de 5-6 nucleotidos) que nos permiten maximizar el número e muestras a ubicar en un solo *lane*. Se diseñan uno por uno para cada librería o secuencia.

Hay ciertas recomendaciones que debemos tomar en cuenta para hacer nuestros código de barras: los dos primeros nucleotidos no pueden ser igual de un código a otro, no puede ser la secuencia reversa complementaria de otro, tampoco pueden ser secuencias palindromas (que se lean igual al derecho y al revés).

Durante el ensamblajes de las secuencias estos barcodes se cortan.

#### Manejo de datos

El proceso del manejo de datos se muestra en la siguiente imagen:

![proceso programas](https://github.com/Melcatus/transcriptomasdenovo/blob/master/programas.png)

Los programas más empleados son:

- Trans-ABySS

- Trinity: permite la reconstrucción de transcriptos, reconoce eventos de *splicing* altenativo y está especializado en muestras que no tienen genoma de referencia.
- DEGseq que está dirigido al análisis de expresión diferencial entre muestras y tratamientos


Las ventajas de muchos de los algoritmos utilizados en el ensamble del transcriptoma es que son libres.


#### Limitantes y fuentes de error del método


- Algo importante de este tipo de ensamblaje es que es posible encontrar transcriptos que pueden no estar representados en el genoma, como por ejemplo eventos de *splicing* alternativo o genes que no se expresan bajo la condición de estudio.

- El análisis de millones de lecturas requiere cada vez del desarrollo de erramientas bioinformáticas que nos permitan relizar análisis de datos cada vez mejores, con rendimientos mayores y ensamblajes más sencillos.

- En muchos casos está sujeto a los genes que ya están descritos.


- Una posible fuente de error es al hacer el proceso de secuenciación los transcritos altamente expresados tendrán mayor lectura que los que se expresan poco. Para disminuir esta diferenciación se puede realizar una normalización química en las librerías.

- El colectar individuos en diferentes ambientes nos mostrará una variación que puede ser contraproducente dependiendo del análisis que queremos hacer, por lo que para disminuír esta variación se puede hacer uso de los jardines comunes o siembras *in vitro*.
