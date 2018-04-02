#### María José Monteverde Suárez, Gabriela Aridai Borja Martínez, Brenda González Calderón
* * *
# Resumen Equipo RAD Genética de Poblaciones
- - -
1) ¿Cuáles son las principales variantes del método de laboratorio para generar mis datos y cuándo es más útil cada una?

Para la generación de datos mediante el método de RADseq existen **4 protocolos principales** que difieren en el número y tipo de enzimas utilizadas, en el tipo de adaptador y barcoding utilizado,  así como en la selección de tamaño del rift (Puritz, *et al.*, 2014; Andrews, *et al.*, 2016):
##### Tabla 1. Procedimiento de los protocolos principales de RAD.
| Tipo de RAD | Descripción |
| :-------: | :------ |
| RAD Original | 1) DNA digerido con una sola enzima de restricción. 2) + adaptadores con los barcodes ligados a los extremos 5'. 3) DNA ligado zonificado. 4) + adaptador al extremo 3'. 5) Selección de librería con base al tamaño de los fragmentos. 6) Fragmentos RAD con los adaptadores son enriquecidos con PCR. |
| 2bRAD | 1) Endonucleasas de tipo IIb para cortar fragmentos de 36 bp que contienen 6 bases de reconocimiento adyacentes a 5' y 3'. 2) Ee pegan adaptadores con barcodes. 3) Enriquecimiento con PCR. 4) La banda de interés se corta del gel de agarosa |
| ddRAD | 1) El DNA genómico se digiere simultáneamente con dos enzimas de restricción. 2) Se agregan adaptadores P1 con barcodes y adaptadores P2 son ligados a los fragmentos digeridos. 3) Las muestras son pooleadas y seleccionadas por tamaño. 4) Se usa PCR para enriquecer la librería e introducir un segundo barcode en forma de índice de Illumina. |
| ezRAD | 1) Digestión de DNA con dos enzimas isochimozer. 2) DNA digerido se inserta a un kit de preparación de librerías Illumina TruSeq. 3) Utilizando el kit, el DNA se repara y los adaptadores se ligan a los fragmentos genómicos. 4) Las muestras son pooleadas y seleccionadas por tamaño. 5) Dependiendo el kit, las librerías pueden ser enriquecidas vía PCR o kits non-PCR. |

##### Tabla 2. Resúmen de las ventajas y desventajas de los cuatro métodos de RADseq (Andrews, *et al.*, 2016).
| Ventaja/Desventaja | RAD-Original | 2bRAD | ddRAD | ezRAD |
| ------------------ | :---------: | :----: | :---: | :---: |
| Opciones para cortar DNA (diferente longitudes)| Depende de la enzima de restricción utilizada | Depende de la enzima de restricción utilizada | Depende de la enzima de restricción utilizada o de la ventana de selección | Depende de la enzima de restricción utilizada o de la ventana de selección |
| Número de loci por 1 Mb del tamaño del genoma | 30-500 | 50-1000 | 0.3-200 | 10-800 |
| Longitud de los loci | ⥶ 1kb de contigs; o ⥶ 300 bp | 33-36 pb | ⥶300 bp | ⥶300 bp |
| Costo por barcode o muestra indexada | Bajo | Bajo | Bajo | Alto |
| Esfuerzo por barcode o muestra idexada | Medio | Bajo | Bajo | Alto |
| Identificación de duplicado de PCR | Con secuenciación paired-end | No | Con barcodes degenerados | No |
| Equipo especializado necesario | Sonicator | Ninguno | Pippin Prep | Pippin Prep |
| Adecuado para genomas largos o compejos | Bueno | Malo | Bueno | Bueno |
| Adecuado para la identificación de locus *de novo* | Bueno | Malo | Moderado | Moderado |
| Disponible para compañías comerciales | Sí | No | Sí | No |

2) ¿Qué limitantes y posibles fuentes de error puede presentar este método (en el laboratorio o la **bioinformática**)? ¿Qué puede hacerse para amortiguarlos?

Todos los procesos de ensamblado de librerías así como el diseño de muestreo y el pipeline bioinformático llegan a tener una fuerte incidencia en los resultados obtenidos.
No existe una forma universal de garantizar que las inferencias no se hayan visto afectadas por eventos inesperados, especialmente porque muchas expectativas dependen del organismo específico en el que se realiza el análisis. Sin embargo, hay **controles generales que deberían ser aplicables en la mayoría de los casos** (Rochette y Catchen, 2017):

> + Número total de loci identificados debe coincidir con las expectativas basadas en el tamaño y composición del genoma, las opciones de la enzima de restricción  y el protocolo molecular.
+ Verificar la superposición entre los loci encontrados en diferentes muestras (sobre todo en análisis *de novo*).
+ Debe existir un conjunto central de loci compartido por la mayoría de las muestras y presente en todas las poblaciones.
+ Cobertura suficientemente alta.
+ Comprobaciones se pueden realizar utilizando los datos de genotipo en sí, como rastrear el número de marcadores con heterocigosidades observables inverosímiles, comprobar que el valor de la relación transición/transversión no está fuertemente distorsionado o verificar que la diversidad de nucleótidos es plausible con respecto a la biología del sistema.

##### Tabla 3. Resumen de fuentes de error, problemas en laboratorio y bioinformáticos (Harismendy, *et al.*, 2009; Hohenlohe, *et al.*, 2010; Davey y Blaxter 2011; Arnold, *et al.*, 2013; Puritz, *et al.*, 2014; van Dijk, *et al.*, 2014; Mastretta-Yanes, *et al.*, 2015; Zhi, *et al.*, 2015; Andrews, *et al.*, 2016; Harris, 2016; Shafer, *et al.*, 2017).

| Tipo | Problema | Solución |
| :---: | --- | --- |
| | **De laboratorio** | |
| Método de extracción | Protocolo utilizado influye en la cantidad y calidad de DNA (CTAB vs. KIT) | Realizar control de calidad y cuantificación de DNA comparando ambos protocolos de extracción. No son mutuamente excluyentes |
| Enriquecimiento de PCR | Generación de artefactos por enriquecimiento de PCR (p. ej. dímeros en los adaptadores) | Reducir los ciclos de PCR al aumentar la cantidad de DNA utilizada |
| Preparación de librerías | Tipo y cantidad de enzimas y selección de tamaño de los fragmentos | Conocer el tamaño del genoma de la especie para saber de qué longitud deben de ser los fragmentos necesarios para tener una cobertura adecuada |
| | Diferentes plataformas de Secuenciación de Nueva Generación provocan diferentes resultados | Illumina es la plataforma con la que la mayoría de los protocolos de preparación de librerías son compatibles y es la de menor costo por muestra |
| Secuenciación | Sesgo GC en los datos de secuenciación de Illumina. Difícil separar heterocigotos, homocigotos, repeticiones y parálogos por recuento solo de lectura | Mayor normalización de los datos de recuento sin procesar para aprovechar al máximo la secuencia RAD *de novo* para los estudios de genética de poblaciones |
| | **Bioinformáticos** | |
| Análisis estadístico | Errores en los estadísticos de resumen | Correr varios pipeline distintos. Tener muestras replicadas de algunos individuos para validar los SNPs |
| Cobertura | Allele dropout: sobreestimación de la homocigosidad y Fst, subestima diversidad genómica | Balancear la cantidad de DNA en todas las muestras evita variaciones en la cobertura |
| | Locus dropout: mutaciones en los sitios de unión causan la pérdida potencial de loci altamente variables con una alta tasa  de mutación. Genera datos faltantes | Probar varios pipelines con distintas coberturas para evaluar los resultados |

3) ¿El muestreo requiere algún diseño específico? Por ejemplo, si se quiere secuenciar un genoma de novo ¿qué individuo sería ideal? Si trabajo con trascriptomas, ¿cómo afecta el tejido, la edad, las condiciones, etc. mi muestreo?
#### Diseño Experimental
En los estudios de genética poblacional, el descubrimiento y uso de marcadores genéticos en varios individuos es fundamental (Davey y Blaxter, 2011). El método de RADseq se puede utilizar para llevar a cabo estudios de genética poblacional en especies sin datos secuenciados, o si estos son limitados (Davey y Blaxter, 2011). Sin embargo, **no existe un pipeline de análisis estándar** con una variedad de alternativas distintas que sea comúnmente usado para llevar a cabo los estudios de genética poblacional (Shafer, *et al.*, 2017). Estudios recientes (Shafer, *et al.*, 2017) han mostrado que **existe una diferencia dramática de los estadísticos de resumen y los estimados demográficos dependiendo del pipeline bioinformático utilizado**, tanto para ensambles de novo como para mapeos de referencia. Por ello, se aconseja utilizar más de un pipeline bioinformático para comparar resultados entre ellos y, con la realidad biológica conocida para la especie.

Un estudio de genómica poblacional tiene, al menos, los siguientes pasos (Ellegren 2014):

> 1. El diseño de la estrategia de secuenciación; 
2. La generación de los datos de secuencia;
3. El mapeo de las secuencias a un ensamble;
4. El llamado de las variantes (SNPs) y;
5. Análisis de genética poblacional.

Cada paso presenta sus propios desafíos e incertidumbres generados por atributos biológicos como el número de loci identificados, el grado de secuencias repetitivas en todo el genoma y el nivel de polimorfismo y divergencia entre las poblaciones. Estos factores interactúan con características del secuenciamiento como la calidad de DNA y el grado de multiplexación de la muestra, el número de lecturas, y el error de secuenciación (Catchen, *et al.*, 2013).
La estrategia de secuenciación incluye aspectos como la profundidad de la cobertura y los problemas clásicos relacionados con un estudio de genética poblacional (por ejemplo, el número de individuos por población y el número de poblaciones) (Ellegren 2014).

4) Menciona al menos dos softwares principales que se utilicen para realizar la parte medular de los análisis bioinformáticos de este tipo de análisis (e.g. si es ensamblado de novo con qué se ensambla, no con qué se hace el pre-procesamiento) y cuáles son los pros y contras de cada uno.

#### Softwares para el análisis de datos de RADseq para estudios de Genética Poblacional
Para los análisis de los datos obtenidos a través del método de RADseq los dos softwares más comúnes son **STACKS**, utilizado para genética de poblaciones y **PyRAD**, diseñado para análisis filogenéticos.

`STACKS` es una interfase para la visualización y análisis de datos. Fue diseñado originalmente para mapeo genómico con datos GBS, posteriormente se le añadieron funciones para enfoques ecológicos y evolutivos (Catchen, *et al.*, 2013).  `STACKS` está basado en un lenguaje de programación C++ y scripts de Perl.
Contiene un número muy flexible de **módulos para conducir todas las partes del análisis**, desde el filtrado por calidad,  eliminación de barcodes y adaptadores, la identificación de loci hasta el genotipificado y el cálculo de los estadísticos de genética poblacional (Andrews, *et al.* 2016) como índices de diversidad  (p y alelos privados), coeficientes de endogamia (FIS y FST), y estadísticos de prueba SNP-by-SNP (Test exacto de Fisher y correcciones múltiples ) (Catchen, *et al.*, 2013).
Cuando hay un genoma de referencia, el programa permite usar una ventana de deslizamiento. Esta aplicación facilita detectar señales específicas en diferentes regiones del genoma, como un aumento o disminución de diversidad, selección direccional o apareamiento no aleatorio. También permite exportar datos en formatos requeridos por otros softwares de genética de poblaciones o filogenéticos.

**Ventajas:**

+ Permite relizar de manera eficiente estudios genómicos ecológicos y evolutivos en organismos modelo, pero particularmente en organismos con recursos genómicos mínimos o nulos.
+ Proporciona formatos de salida para varios paquetes de análisis genético utilizados habitualmente.
+ En constante mejora, lo que lo convierte en una herramienta útil para aprovechar la generación más nueva de datos de genotipado masivamente paralelos para estudios genéticos ecológicos y evolutivos ahora y en el futuro.
- - -
##### Tabla 4. Distintos métodos y softwares implementados en estudios de Genética de poblaciones (Alexander, *et al.*, 2009; Antao, *et al.*, 2008; Beerli y Palczewski, 2010; Bradburd, *et al.*, 2013; Catchen, *et al.*, 2013; Cornuet, *et al.*, 2008;   Danecek, *et al.*, 2011; Edgar, 2010; Excoffier y Foll, 2011; Excoffier y Lischer, 2010; Foll y Gaggiotti, 2008; Goslee y Urban, 2007; Jombart, 2011;  Kalinowsky, 2005; Li, *et al.*, 2009; Lawson, *et al.*, 2012; Lischer y Excoffier, 2011; Luu, *et al.*, 2017;  Manichaikul, *et al.*, 2010; Pickrell, 2012;  Price, *et al.*, 2006; Quinlan y Hall, 2010; Raj, *et al.*, 2014; Rousset, 2008; Shah y McRae, 2008;  Skotte, *et al.*, 2013; Wilson y Rannala, 2003.)

| Programa | Método |
| :---------: | --------- |
| | **Filtrado de las lecturas y control de calidad** |
| Bedtools | Análisis de cobertura, calcula el contenido de GC, intersecta, fusiona y cuenta llamados de SNP de individuos o poblaciones aplicando la teoría aritmética  de conjuntos. |
| Picard tools | Filtrar por calidad, ordenar, marcar y eliminar duplicados. |
| USEARCH | Condensar muestras replicadas ordenadas azarosamente y calcular el número de ocurrencias de estas. Explorara y elimina la presencia de quimeras. |
| | **Convertidor de formatos** |
| PGDSpider | Herramienta para la conversión de datos a los formatos requeridos por softwares especializados. |
| | **Mapeo a genoma de referencia** |
| SAMTools | Mapeo a un genoma de referencia para le ensamblado. Permite manipular alineamientos (clasificación, fusión e indexación). |
| UNEAK | Pipeline para el llamado de SNPs de genotipado por secuenciación (GBS) para organismos que no cuentan con genoma de referencia. Es una extensión del programa TASSEL. |
| | **Estadísticos de resumen** |
| VCFTools | Heterocigosidad observada, diversidad nucleotídica, D Tajima, FIS, desviación de H-W, tasa de transversiones y transiciones, desequilibrio de ligamiento. Calcula FST pareadas y relaciones de parentesco. |
| GENEPOP | Permite calcular estadísticos F y evaluar si las poblaciones se encuentran en H-W. |
| HP-RARE | Riqueza alélica y alelos privados corregidos por tamaño de muestra. |
| Arlequin | Lleva a cabo amplia variedad de pruebas, medidas de diversidad, FST pareadas y diferenciación poblacional por AMOVAS, tasa theta de mutación poblacional. Puede dar resultados erróneos si el archivo de entrada contiene muchos datos faltantes.|
| diveRsity | Paquete de R que calcula varios estadísticos de diversidad y diferenciación. También proporcionan diversas herramientas para una evaluación visual de los valores estimados. |
| KING | Realiza análisis de relaciones de parentesco, verifica errores en el pedigree. Generalmente los SNP evaluados van  ligados a estudios  de asociación de genoma completo (GWAS). |
| DnaSP | Estima la diversidad de nucleótidos y haplotipos, el parámetro de mutación poblacional, el número de sustituciones de nucleótidos por sitio, etc. y pruebas de neutralidad (como Tajima, Fu y Li, y las pruebas de Fu).
| | **Análisis exploratorios** |
| Eigensoft | Análisis exploratorio de componente principales (PCA) que admite datos fenotípicos y genotípicos. |
| DIYABC |  Hace inferencias de cálculo bayesianas aproximadas sobre la historia de la población utilizando SNPs o datos de microsatélites. Se puede usar para comparar escenarios evolutivos competitivos y cuantificar su soporte relativo y estimar parámetros para uno o más escenarios. |