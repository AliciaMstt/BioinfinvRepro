## Proyecto final 

## Valor y modo de calificar
* 40% de la calificación del curso
* Individual
* La calificación del trabajo final toma en cuenta:
	* 10% Organización del repositorio
	* 15% README **(debe ser en inglés)**
	* 10% Datos y análisis
	* 20% Resumen y discusión en formato Markdown 
	* 15% Gráfica(s) en R
	* 15% Scripts
	* 15% Avances preliminares 

Ver abajo para detalles de cada punto.

**Entrega final: 25 de Mayo 11:55 pm**


## Tipos de trabajos permitidos:

   - **Análisis de datos propios** (si los tienes), puede ser el pre-procesamiento y parte de los análisis subsecuentes. Trabajos con sólo el pre-procesamiento no tendrán calificación completa. Por "datos propios" entiendo no únicamente datos que hayan secuenciado ustedes mismoas, sino también datos previamente publicados que serán parte de sus análisis. Por ejemplo genomas publicados pero que no han sido alineados uno contra el otro para genómica comparada. 
  
   - **Analizar datos ya publicados** que sea necesario procesar del mismo modo que los datos que uds tendrán. La única condición es que me avisen desde un inicio de dónde los sacaron (artículo y repo) y que no existan scripts que hagan literalmente lo que uds quieren hacer. Es decir pueden aprovechar un artículo poco reproducible que venga sin los scripts que ocuparon, pero que sí diga lo que hicieron y que sea algo que a uds les interese.

   - **Análisis de datos brindados por la profesora**. Opciones: 
   		- (a) [procesar datos ddRAD crudos](https://datadryad.org/resource/doi:10.5061/dryad.g52m3) de *Berberis alpina* y analizarlos *de novo* con una versión de Stacks distinta de la utilizada en el artículo o con otro programa.  
   		- (b) analizar datos de maíz en formato plink ya procesados de [Artega *et al*, 2015](http://datadryad.org/resource/doi:10.5061/dryad.4t20n) **junto con**  otros datos de maíz publicados (los que prefieras, pueden ser genomas u otros SNPBead chip), por ejemplo para hacer un blast, o alinearlos.  

   - **Hacer el dockerfile de un programa y correr datos ejemplo de un artículo ya publicado**. El dockerfile debe seguir las [instrucciones y mejores prácticas de Biocontainers](http://biocontainers.pro/docs/developer-manual/developer-intro/), como par ser de suficiente calidad para ser publicado en Biocontainers.
  
  
## Contenido del Proyecto Final

Independientemente de la opción, el trabajo debe incluir:

   - Organización (directorios data, bin, etc, scripts documentados) como un repositorio de datos para subir a Dryad o símil
   -  README bonito que explique donde está todo y qué hace cada script. Debe ser en inglés.
   -  Una versión downstream de los datos (e.g. plink) o cortada (e.g. primeras 1000 líneas de un archivo fastq) que no exceda 200 MB que sea suficiente para correr o ver cómo deberían correr los scripts (por lo menos los más downstream).
   - Resumen de aprox 1-3 cuartillas escrito en MarkDown explicando los análisis y resultados. Debe incluir al menos una figura. El Markdown debe incluir rutas RELATIVAS de forma que funcione ver las imágenes en cualquier equipo.
   - Al menos una gráfica de alta calidad realizada en R.
   - Scripts comentados y enlistados en el README para toda la pipeline.
 
Nota: En el caso de quienes decidan hacer un dockerfile, será necesario cumplir con el README, repositorio, resumen markdown, figuras etc de datos de chocolate como si fuera un tutorial de uso del software.

  
## Fechas de entrega y avances
    
Los avances preliminares del proyecto serán el 15% de la calificación.

Cada avance será un archivo .md independiente que deberá estar contenido en un repostorio de tu GitHub llamado algo como "ProyectoFinalBioinf2017-II" (cambia según el semestre). 

Para pasarnos el link a cada avance deberás agregar tu nombre y el link a cada uno de los avances en el archivo [ListadoProyectosFinales.md](ListadoProyectosFinales.md) de este repositorio, utilizando un `pull request`.

**Avance 1** Entrega max 5 abril a las 11:55 pm

Contenido: qué opción de trabajo final realizarás incluyendo: a) qué tipos de análisis realizarás (e.g. ensamblado de novo, contrucción de árboles, etc) y b) exáctamente qué datos utilizarás en caso de que no sean datos propios.

**Avance 2** Entrega max 26 abril 11:55 pm

Contenido: Querido Diario a la fecha he hecho tal, incluyendo artículos leídos, datos obtenidos, comandos de qué sofware corridos, problemas con el software, cambios de enfoque justificando por qué, etc.

No requerimos ver datos u análisis preliminares, pero sí una especie de diario detallado.


**Avance 3** Entrega max 17 mayo 11:55 pm    
Contenido: Querido diario + Link a un avance del README (ponerlo en un .md separado en el mismo repo) de tu proyecto final que detalle el tipo de scripts que utilizarás y cómo estás organizando tu proyecto.

### Tips de convivencia en Github

**Bonitos sus nombres de usuario de Github, pero necesito sus nombres de persona para calificar**

* Al hacer el pull request pon como título no solo "avance x" sino incluye tmb tu nombre.
* Incluye tu nombre en algún lugar cerca del título de cada avance dentro del mb

**Utilizaremos el sistema de _issues_ de Github para hacer comentarios a sus avances**

* REVISEN sus issues, atiendan los comentarios, hagan los cambios pertinentes y avísennos por el sistema de issues que ya lo hicieron.


## Modo de entrega proyecto final

Los avances se entregarán via links en el github como se detalló anteriormente.

La entrega final debe ser un único archivo zip o tar que contenga todos los archivos, carpetas, imágenes, etc mencionados anteriormente y que deberá ser enviado por correo electrónico a Alicia **Y** Vero et Gus. **El asunto del correo DEBE SER**: "Curso Bioinformática Trabajo Final Nombre del alumnoa". 

Si el archivo excede los 20 Mb debe ser enviado via [https://www.wetransfer.com/](https://www.wetransfer.com/) o símil. El tamaño **máximo** del archivo debe ser de ~200 Mb. La liga a wetrasfer o simil deberá enviarse en un correo electrónico como se detalló anteriormente.


## Resumen de Fechas 

* Avance 1: 5 abril 11:55 pm

* Avance 2: 26 abril 11:55 pm

* Avance 3: 17 mayo 11:55 pm

* **Entrega final: 25 de Mayo 11:55 pm**


