---
title: "Tipos básicos de objetos en R"
author: "Alicia Mastretta-Yanes"
output: html_document
---

Este documento explica cuáles son los principales tipos de objetos en R y cómo acceder a subgrupos dentro de ellos.

## Vectors

Los vectores son los objetos más básicos de R. Se caracterizan por "ser de una sola dimensión", es decir como si fueran una sóla fila de elementos, uno detrás de otro. 

Pueden ser de los tipos: `numeric`, `integer`, `logical`, `character` and `factor`.  

- `logical` - valores lógicos.
- `character` - para caracteres (strings).
- `factor` - para factores.
- `numeric` - para valores numéricos
- `integer` - para integrales

Los vectores pueden tener datos perdidos (`NA`).

La manera más sencilla de crear un vector es con la función `c()`


```{r}
mi.vector<-c(1,2,3,4, NA)
mi.vector
length(mi.vector)
```

Podemos agregar un vector a otro vector

```{r}
y<-c(mi.vector,20,23,80:85)
y
```

Cada elemento dentro de un vector "está numerado" y además puede tener un nombre. Podemos "indexar" los elementos con base a su número o a su nombre.

```{r}
x <- c(1:15)
x
names(x) <- letters[1:15]
class(x)
x[1:3]
x[c("a", "b")]
```


Ojo: los nombres de los vectores no necesariamente son únicos. Esto puede causar problemas para submuestrear.

```{r}
x <- 1:3
names(x) <- c("A", "A", "B")
x
x["A"]
```


Puedes ver si tus nombres son únicos o se repiten con las funciones `unique`, `duplicated` o `anyDuplicated`.

```{r}
anyDuplicated(names(x))
names(x) <- c("A", "B", "C")
anyDuplicated(names(x))
```

`anyDuplicated` brinda el índice del primer duplicado, así que 0 significa que nada está duplicado.

**Ejercicio:** crea un vector que contenga los números del 1 al 200 y los números del 300 al 450.


### Logical

Contienen información `TRUE` o `FALSE`. Sirven para evaluar expresiones de =, <, > y pueden ocuparse para obtener los elememntos de un vector que cumplan con la característica deseada.


```{r}
1<5
10==0
10!=0
10<=0
x<-1:20
x>15
x[x>15]

```

Dentro de un vector logical `TRUE` equivale a 1 y `FALSE` equivale a 0, por lo tanto para contar cuántos `TRUE`s hay podemos hacer una suma:


```{r}
x<-1:20
sum(x>15)
```

**Ejercicio** utiliza una sola líndea de R para averiguar si el logaritmo base de 10 de 20 es menor que la raiz cuadrada de 4.

### Character

Son *strings* de texto. Se distingue porque los elementos van entre comillas (cada uno). Puede ser desde un sólo caracter hasta oraciones completas. Puede parecer que contienen números, pero las comillsa indican que serán tratados como texto. Podemos subsetearlos por su índice o buscando literalmente el texto.


```{r}
x<- "tangana nica"
x
x<- c("tangana nica", "tangana na", "2")
x[1]

x[x=="tangana nica"]
x[x=="tangana"]
x[grep("tangana", x)] 

```

**Ejercicio:** crea un vector de caracteres con tres nombres de especies

### factor

Los factores son un tipo de vector que puede tomar un número "limitado" de valores, que normalmente se utilizan como variables categóricas. Por ejemplo: macho/hembra. Es útil tenener este tipo de objeto porque varios modelos estadísticos que se pueden correr en R los manejan. A los valores que pueden tomar los elementos del factor se les conoce como "levels".


```{r}
x<- c(1,2,2,3,1,2,3,3,1,2,3,3,1)
x
as.factor(x)
x<-as.factor(x)
x
```


Los factores son una manera computacionalmente eficiente de almacenar caracteres, pues cada valor único (level) se guarda solo una vez y a los datos se les asigna un valor integer. 

```{r}
meses = c("March","April","January","November","January",
       "September","October","September","November","August",
        "January","November","November","February","May","August",
        "July","December","August","August","September","November",
         "February","April")
meses
meses<-as.factor(meses)
meses
```


El que existan los levels permite realizar ciertas operaciones y manipular el contenido del factor.

```{r}
table(meses)
levels(meses)
levels(meses)[1]

levels(meses)[1]<-"Abril"
levels(meses)
meses

```

**Ejercicio** lee la ayuda de `as.factor` para determinar cómo crear un factor "ordenado"

### Integers y numerics

R por default representa los números como `numeric`, NO `integer`. Estos tipos son dos formas diferentes en las cuales las computadoras pueden guardar los números y hacer operaciones matemáticas con ellos. Por lo común esto no importa, pero puede ser relevante para algunas funciones de Bioconductor, por ejemplo ya que el tamaño máximo de un `integer` en R es ligeramente más chico que el tamaño del genoma humano. 


¿Cómo revisar si un objeto es numeric o integer?

```{r}
x <- 1
class(x)
x <- 1:3
class(x)
```


Para hacer un vector integer al escribirlo:

```{r}
x <- 1L
class(x)
```


Para convertir un vector integer a uno numérico podemos utilizar la función `as.numeric`. **Ejercicio** da un ejemplo de cómo convertir un vector integer a uno numérico.

Recuerda que un vector es un objeto en R está guardado en la memoria, no en un archivo, por lo que tener vectores muy grandes (e.g. más grandes que el genoma humano) es una limitante. Sin embargo hay otras formas de acceder a la información para sobrepasar esto.


## Lists

Las `list`s son como `vector`s, pero pueden tener juntos a variables de cualquier tipo (`numeric`, `character`, etc).

```{r}
x <- list(1:3, letters[1:3], is.numeric)
x
names(x) <- c("numbers", "letters", "function")
x[1:2]
x[1]
x[[1]]
```

Al subsetear una lista se crea otra lista. Para obtener el contendio del primer elemento necestiamos usar corchetes dobles `[[`. Ojo con la diferencia entre `[` y `[[`.

Alternativamente, si la lista tiene "nombres" es posible utilizar el nombre, con corchetes o con `$` 
```{r list2}
x$letters
x["letters"]
x$letters[1]

```


## Matrices

Una `matrix` es un objeto **bidimensional**, es decir con **filas** y **columnas**. Toodos los valores en una matriz deben tener el mismo tipo (`numeric`, `character`, etc). Opcionalmente pueden tener `rownames` o `colnames`, mismos que no tienen que ser únicos. 

```{r}
x <- matrix(1:12, nrow = 4, ncol = 3)
rownames(x) <- c("A","B", "B", "C")
x
dim(x)
nrow(x)
ncol(x)
```


Para subsetear una matrix debes hacerlo considerando sus dos dimensiones. Se utiliza `[ , ]`. En el primer espacio van las filas y en el segundo las columnas. ¡Ojo con que los nombres de filas o columnas no sean únicos!

```{r}
x[1:2,]
x["B",]
x[x >= 5]
```

Nota que subsetear con un nombre de fila no único no marca error, pero puede conducir a errores en nuestros análisis de datos.

Para obtener la posición en la matriz (en vez de sólo un vector) al hacer un subset necesitamos utilizar el argumento `drop=FALSE`:

```{r}
x[1,]
x[1,,drop=FALSE]
```


Por lo general las matrices se llenan con datos numéricos, pues hay muchas operaciones que se pueden hacer con ellas. Por ejemplo `rowSums`, `colSums` y  `eigen` para calcular eigenvectores (que se usan por ejemplo en PCA)

**Ejercicio**: Muestra el valor del elemento de la segunda fila, tercera columna.

## Data frames

Las `data.frame` son como matrices, pero cada columna puede ser de un tipo (`numeric`, `character`, etc) en particular. Deben tener nombres de columnas y filas únicos. Si no nombras las filas, entonces sus nombres serán `1:nrow`. 


```{r}
x <- data.frame(sp = c("Homo sapiens", "Homo sapiens", "Homo neanderthalensis", "Homo neanderthalensis"), sexo = c("Male", "Female", "Male", "Female"), edad = c(60,30,10,50))
x
```


Puedes acceder a las columnas con `$` o `[[`:
```{r dfColumns}
x$sexo
x[["sexo"]]
```

Nota que `sexo` se conviertió en un `factor`. Esto puede ser útil, pero también una fuente de error. Una manera de evitar que esto ocurra en automático es utilizar la opción: `stringsAsfactors=FALSE`:


```{r}
x <- data.frame(sp = c("Homo sapiens", "Homo sapiens", "Homo neanderthalensis", "Homo neanderthalensis"), sexo = c("Male", "Female", "Male", "Female"), edad = c(60,30,10,50), stringsAsfactors=FALSE)
x$sexo
```

Podemos agregar una nueva columna o una nueva fila a una `data.frame` con las funciones `cbind` y `rbind`, respectivamente. La nueva fila/columna debe ser un vector del mismo largo que la `data.frame`.

```{r}
x<- cbind(x, pop=c("Australia", "Mesoamérica", "Europa", "África"))
x
```


**Ejercicio** muestra las 2 primeras filas de la data.frame del ejercicio anterior.
