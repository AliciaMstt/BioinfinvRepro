---
Title		: Tutorial de Docking molecular
Subtitle	: Unidad 8 - Predicción estructural y funcional de Proteínas y ARNs
Project		: Curso de Bioinformática CL-MX  
Author		: J. Cristian Salgado 
Affiliation	: Universidad de Chile
Email		: jsalgado@ing.uchile.cl
Date		: 2019-05-07 
---
# Tutorial de Docking molecular

## J. Cristian Salgado 

### Acerca de este tutorial

* ***Aprendizaje esperado***: Los alumnos efectúan y analizan los resultados de un docking molecular uti-
lizando herramientas de software no comercial.
* ***Modalidad***: Grupos de 3 personas
* ***Plazo***: 27/5
* ***Caracter***: Opcional (no se exigirá esta tarea pero si la entrega, serea evaluada y considerada en su promedio)

### 1 Aprendizajes esperados
Al finalizar la actividad se espera que los alumnos:
 (a) Tengan un manejo básico de las herramientas Autodock Vina y USCF Chimera.
 (b) Efectuen un docking molecular simple.
 (c) Analicen los resultados del docking.
 (d) Discutan los resultados obtenidos a la luz de la evidencia biológica disponible.

### 2 Actividad: parte 1
1.- Instalar en sus computadores personales:
***Autodock vina*** http://vina.scripps.edu/
***AutodockTools*** http://autodock.scripps.edu/downloads/resources/adt
***UCSF Chimera*** https://www.cgl.ucsf.edu/chimera/download.html

2.- Realizar tutorial de Chimera. Resultados mínimos esperados:
* Cargar y visualizar una proteina en distintos representaciones.
* Definir selecciones de átomos y representar estas selecciones de distintas maneras.
* Seleccionar moleculas en un pdb y generar archivos independientes para cada una.
* Determinar distancias entre átomos y la presencia de puentes de hidrógeno y otras interacciones.
* Generar imágenes de conformaciones en formatos adecuados para incluir en informes o manuscritos.

3.- Realizar tutorial de Autodock Vina. Resultados esperados:
* Preparar adecuadamente el ligando y el receptor.
* Efectuar el docking (se recomienda hacerlo manualmente y mediante Chimera)
* Analizar los resultados del docking: pseudo energías y conformaciones utilizando Chimera.
* Detectar interacciones utilizando Chimera.

4.- Realizar una breve busqueda de antecedentes bibliográficos acerca de la familia de receptores de adenosina (en particular A2a) y la adenosina.

5.- Analizar las interacciones presentes entre receptor de adenosina A2a humano y la adenosina presentes en la estructura: 2YDO, http://www.rcsb.org/structure/2YDO. Buscar puentes de hidrógeno, interacciones π−π, etc.

6.- Utilizando Chimera para separar el ligando del receptor en 2YDO, generandos un archivo para el re- ceptor y otro para el ligando.

7.- Realizar docking de adenosina y receptor usando Vina/Chimera.

8.- Analizar los resultados del docking entre la estructura del receptor y la adenosina utilizando Chimera.

9.- Comparar la conformación e interacciones encontradas por Vina con las presentes en el cristal.

### 3 Actividad: parte 2
Los resultados de la actividad corresponden a las respuestas a las preguntas de esta sección. Se entregan en un reporte de máximo 10 páginas el cual debe ser enviado en formato pdf al correo jsalgado@ing.uchile.cl.

1.- Describa brevemente el mecanismo de funcionamiento de la adenosina y de su receptor en cuanto a la regulación de las horas de vigilia.

2.- ¿Por qué los archivos PDB no incluyen la localización de los átomos de hidrógenos?

3.- ¿Por qué los programas de docking calculan una energía? ¿es la energía de la conformación? ¿de qué sirve?

4.- ¿En qué consiste el proceso de Docking molecular?

5.- Adjunte una imagen preparada en Chimera que muestre el receptor de adenosina A2a humano y la adenosina en el pdb 2YDO, con las siguientes características (todas las imágenes que siguen deben cumplir un estándar similar):

* Agregue los hidrógenos a las moléculas.
* Proteína en formato ribbon color gris.
* Adenosina en formato stick, con átomos coloreados según elemento.
* Todaslascadenaslateralesyaguaentornoa5Adelaadesoninaenformatowire(wirewidth=4) con átomos coloreados según elemento.
* Puentes de hidrógeno entre cadenas laterales y adesonina coloreados.

6.- ¿Qué interacciones encontró entre la adenosina y el receptor en el PDB original? ¿Participan los átomos de agua?

7.- En una misma imagen coloque el receptor, la adenosina en la posición del cristal y la adenosina en la posición obtenida por el docking en la Actividad 1. ¿Qué interacciones se conservan, cuáles no? ¿Cómo podría explicar las diferencias y similitudes?

8.- Busque en pdb una molécula de cafeína (por ejemplo 3RFM) ¿Qué diferencias existen entre la molécula de adenosina y la de cafeína?

9.- Describa brevemente el mecanismo de funcionamiento de la cafeína y del receptor de adenosina en cuanto a la regulación de las horas de vigilia.

10.- Extraiga la estructura de cafeína y realice el docking de ella con el receptor de adenosina en 2YDO. Use la utilidad que dispone Chimera para hacer el docking. Use la misma caja que uso para hacer el docking con la adenosina. Prepare una figura que muestre el mejor docking encontrado.

11.- En una misma imagen coloque el receptor, la adenosina en la posición del cristal y la cafeína en la posición obtenida por el docking. Configure el formato y orientación de la imagen de manera que se aprecie lo mejor posible para apoyar la discusión que va a realizar en la siguiente pregunta.

12.- Discuta los resultados obtenidos en la figura anterior en base a la conformaciones obtenidas, las inter- acciones observadas y el background biológico del sistema.

### 4 Evaluación
El desarrollo de esta actividad se evaluará de acuerdo a las respuestas a las preguntas y a la calidad y pertinencia de las figuras/gráficos/esquemas incluidos para apoyar las respuestas.