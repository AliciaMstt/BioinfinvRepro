# Unidad 4  Organización de un proyecto bioinformático 


Un proyecto bioinformático consiste en los datos crudos, datos procesados, scripts y documentación (README) necesarios para reproducir los análisis realizados. Es decir en todo lo que al final debes subir a un repositorio como Dryad (aunque los datos pueden conectarse desde otros repos, como SRA, claro). 


## 4.1. Organización del contenido

#### Organización de directorios 

Un proyecto bioinformático debe tener su propio **directorio** (carpeta) y contener en subdirectorios todo lo necesario para realizarlo.

El directorio del proyecto debe dividirse a su vez, lo recomendable es que sea en **subdirectorios** parecidos a los siguientes:

* **data**, contiene los datos, también puede tener otros nombres como *genetic* para datos genéticos y *spatial* para datos espaciales. Los datos genéticos pueden dividierse a su vez en subdirectorios como *raw*, *filtered*, *genotypes*, *data_in*, *data_out* de modo que los datos crudos estén en un directorio y los modificados por análisis subsecuentes en otros directorios. El punto es tener uno o más directorios donde estén todos los datos.  

* **meta**, **info** o **docs** donde puedes guardar todos los metadatos, como un archivo cvs detallando información de cada una de las muestras. Si lo prefieres este archivo puede ir dentro del directorio de datos sin necesidad de hacer la carpeta *meta*. También es posible guardar aquí cualquier otro documento necesario para procesar los datos.
  		
* **bin** o **scripts**, donde guardas todos los scripts necesarios para correr el análisis de principio a fin. Este es un directorio obligatorio. Esta es la carpeta más difícil de documentar.

* **figures**, opcionalmente, puedes poner aquí el código que se utilice sólo para hacer las figuras de una publicación dada. Es como un extracto de *bin* dedicado solo a esto.

* **archive** este directorio NO se sube al repositorio, pero es bueno tenerlo para ir poniendo ahí scripts y resultados que crees no necesitar más pero que es bueno no borrar por completo.

También es posible tener un directorio para cada subanálisis concreto, por ejemplo uno para *stacks* y otro para *admixture*, pero dentro de cada uno de ellos subdirectorios como los anteriores. 

Independientemente del nombre que escojamos para los directorios y archivos, qué es qué y dónde está cada cosa debe ir explicado en un **README**.

Para ver un ejemplo de un repositorio organizado así, baja la sección **Data and scripts for population genomics and SDM** de [este repo de Dryad](https://www.datadryad.org/resource/doi:10.5061/dryad.f7248) (El archivo que se llama ++PopGenomicsIBR.zip++).



### Organización de scripts 
Como hemos visto, un script puede realizar un análisis sencillo o "disparar" otros scripts para correr una pipeline completa. También es posible que algunos de tus scripts sean *funciones* a ser utilizadas por otros scripts (por ejemplo con el comando `source()` en R) y otros scripts  

Los scripts dentro de un proyecto bioinformático normalmente incluyen los tres tipos anteriores. 

Una buena práctica es **no** escribir scripts bíblicos que lo hagan todo, sino ir partiendo el análisis por "módulos". 

**Pregunta**: ¿en qué módulos podrías dividir tu proyecto?

Para recordar qué correr en qué orden puedes "numerar" tus scripts, de modo que el primer script que debas utilizar se llame por ejemplo `1.demultiplexing.sh` y el siguiente `2.Qfiltering.sh` y así. Las funciones y scripts "llamados" no es necesario numerarlas.

Al final deberás incluir en tu README una pequeña explicación de qué hace cada script.


## 4.2. Markdown

Markdown es el formato en el que está escrito este repositorio y el que ocupan sitios como Github, Stacksoverflow y muchos tutoriales.

Básicamente es una manera de escribir texto de manera que sea interpretado por un programa y convertido en un bonito archivo html. Tiene la ventaja de que está especialmente hecho para poder `formatear código en un texto como este`.

[Aquí una guía de MarkDown](https://github.com/adam-p/markdown-here/wiki/Markdown-Cheatsheet)

**Ejercicio:** abre el el editor de Markdown de tu preferencia y escribe un texto en formato Markdown de manera que quede igual que los tres primeros puntos de [Preparing the environment, cleaning the data for Stacks](http://catchenlab.life.illinois.edu/stacks/tut.php#prep) (incluyendo ese subtítulo). No es necesario poner los colores, pero si quieres, cool.

Es útil aprender la sintaxis de Markdown para poder documentar mejor tus proyectos, sobretodo si los subes a GitHub.


## 4.3. GitHub para organizar tu proyecto

Como hemos visto GitHub te permite llevar un control de versiones, es decir, llevar un registro de los cambios que se realizan sobre un proyecto informático, particularmente sobre las modificaciones a los scripts.

Es muy buena idea llevar un control de versiones de tus scrips en tu carpeta `bin`.

Sin embargo, cuando subas tu proyecto con todo y datos como un repositorio (e.g. a Dryad) recuerda **NO** compartir la carpeta `.git`. 


## 4.4. Creación de “pipelines” para análisis de datos crudos a resultados 		

Una vez que tenemos listos los scripts de todos los pasos de un análisis es posible "enlazarlos" todos en un script "maestro" (**pipeline**) que los corra todos uno detrás de otro en el orden adecuado.

Ventajas:

-  Prueba de que todo funciona y de que no dejamos scripts basura en el camino
-  Garantiza que los resultados finales son el resultado de los análisis que estamos documentando en nuestros scripts
-  Garantiza reproducibilidad de resultados

Desventajas:

- Utiliza tiempo de cómputo para correr

Normalmente no lo correrías cada vez (para eso están los módulos) sino que sirve para probar al final, antes de publicarlo, que efectivamente tus análisis son reproducibles.


**Ejercicio**: retoma el ejercicio de la pipeline de Stacks que vivmos en la Unidad 3 (en la sección de [modularidad](https://github.com/AliciaMstt/BioinfinvRepro/blob/master/Unidad3/Unidad_3_Algoritmosyprogramacion.md#32-modularidad)) y divídelo en un subscript para cada paso y un script maestro que corra toda la pipeline.


## 4.5 Correr R desde la Terminal

`R` (que veremos a fondo más adelante) es un programa que funciona con la línea de comando y por lo tanto puede correrse desde la terminal de varias formas. `python` y otros lenguajes también se comportan de forma parecida.


### Acceder a la consola de R desde la Terminal: 

```{bash}
$ R
R version 3.2.2 (2015-08-14) -- "Fire Safety"
Copyright (C) 2015 The R Foundation for Statistical Computing
Platform: x86_64-apple-darwin13.4.0 (64-bit)

R is free software and comes with ABSOLUTELY NO WARRANTY.
You are welcome to redistribute it under certain conditions.
Type 'license()' or 'licence()' for distribution details.

  Natural language support but running in an English locale

R is a collaborative project with many contributors.
Type 'contributors()' for more information and
'citation()' on how to cite R or R packages in publications.

Type 'demo()' for some demos, 'help()' for on-line help, or
'help.start()' for an HTML browser interface to help.
Type 'q()' to quit R.

> 1+1
[1] 2
```
### Correr R en batch mode

Es decir correr scripts de R desde la terminal sin abrir R. Esto es útil porque correr un script de R puede volverse parte de un script de bash.

Existen tres formas de hacerlo:

#### `Rscript` 

Por ejemplo el script `Prac_Uni4/egR/holascript_simple.R` contiene:

`cat holascript_simple.R`
```{R}
x<-10
y<-6
cat("¡Hola mundo!", x, "+", y, "es igual a", x+y)
```

Y puede correrse así:

```
$ Rscript holascript_simple.R
¡Hola mundo! 10 + 6 es igual a 16
```

#### `#!` a `Rscript`

El contenido de un script debe incluir en la primera línea `#!/usr/bin/Rscript` o `/usr/local/bin/Rscript` o lo que sea que diga `which Rscript`. Por ejemplo el script `/Practicas/Uni8/holascript.R` contiene:

```{R}
#!/usr/local/bin/Rscript

x<-10
y<-6
cat("¡Hola mundo!", x, "+", y, "es igual a", x+y)
```

Y puede correrse así (recuerda hacerlo ejecutable antes con `chmod`:

```
$ ./holascript.R 
[1] "¡Hola mundo! 10 + 6 es igual a 16"
```

Nota: si lo anterior no funciona tal vez debas cambiar la ruta a Rscript, puedes averiguar esto con `which Rscript` en la Terminal. Ojo, esto NO es lo mismo que `which R`.

#### `R CMD BATCH`:

Una alternativa a RScript es `R CMD BATCH`. La diferencia es que el resultado de correr el script se escribe a un archivo `.Rout` (incluso si el script involucra imprimir resultados a pantalla con `cat` o `print`) que contiene el código, el resultado y datos de cuánto tardó el procesamiento. 

```
$ R CMD BATCH holascript_simple.R 
$ more holascript_simple.Rout

R version 3.2.2 (2015-08-14) -- "Fire Safety"
Copyright (C) 2015 The R Foundation for Statistical Computing
Platform: x86_64-apple-darwin13.4.0 (64-bit)

R is free software and comes with ABSOLUTELY NO WARRANTY.
You are welcome to redistribute it under certain conditions.
Type 'license()' or 'licence()' for distribution details.

  Natural language support but running in an English locale

R is a collaborative project with many contributors.
Type 'contributors()' for more information and
'citation()' on how to cite R or R packages in publications.

Type 'demo()' for some demos, 'help()' for on-line help, or
'help.start()' for an HTML browser interface to help.
Type 'q()' to quit R.

> x<-10
> y<-6
> cat("¡Hola mundo!", x, "+", y, "es igual a", x+y)
¡Hola mundo! 10 + 6 es igual a 16> 
> proc.time()
   user  system elapsed 
  0.230   0.034   0.242 

```

Notas recomendadas: [Running R in batch mode on Linux](http://www.cureffi.org/2014/01/15/running-r-batch-mode-linux/)

### Utilidad:

Una aplicación de lo anterior es poder correr scripts de R y otro lenguaje directamente en un script de bash, de manera que nuestro script maestro pueda incluir todos los pasos.
