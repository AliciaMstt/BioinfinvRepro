# Expresiones matemáticas

6*7
100*2
1+1

# Strings de text
"Hola mundo !1!!!"

"Hola mundo feliz"

# Valores lógicos
4>3
2+2 == 5
sum(c(FALSE,FALSE, TRUE, TRUE))


# Crear variables
x<-c(5,4,6,7, NA)

y<- 10<3

z<- "Tangana nica"

class(x)
class(z)

# Funciones
sum()
mean()
help()

# Ayuda de cualquier fun
?sum



## Ejercicio utilizar sum para sumar 2+2
sum(2,2)

# Objeto vector
veceg<- c(5,4,6,7)

sum(veceg)

veceg[c(2,4)]

# Ejercicio:
# crear una variable con el logaritmo 
# base 10 de 50 y sumarlo a otra variable
# cuyo valor sea = 5
?log
x<- log10(50)
y<-5
x+y

# Ejercicio sumar el numero 2 a TODOS 
# los números entre 1 y 150
y<-c(1:150)
y<-1:150
z<-y+2

# Ejercicio: ¿cuántos números son mayores a 20 
# en el vector -13432:234

vec<-c(-13432:234)
x<-vec>20
sum(x)

sum(-13432:234>20)

## buscar numeros mayores a 100
vec[vec>100]

## Matrices
n<-matrix(1:15, 3, 5)
n[,3]
n[2,]
n[2,5]

# Dataframes
df<-data.frame(x=c("a", "b", "c"), y =1:3)
df[,2]
df$y

## caracteres

x<- "tangana nica"
x
x<-c("tangana nica", "tangana na", "2")
x[1]

x[x=="tangana nica"]
x[x=="tangana"]
grep("tangana", x)
x[grep("tangana", x)]
x[c(1,2)]


## Factores
x<- c(1,2,2,3,1,2,3,3,1,2,3,3,1)
class(x)
as.factor(x)
x<-as.factor(x)
x
x<-as.numeric(x)
x

meses<-c("March","April","January","November","January",
  "September","October","September","November","August",
  "January","November","November","February","May","August",
  "July","December","August","August","September","November",
  "February","April", "June")

meses<-as.factor(meses)
meses

table(meses)
levels(meses)
levels(meses)[1]

# cambiar un level
levels(meses)[1]<-"Abril"
levels(meses)
meses

?as.factor

# Ejercicio lee la ayuda de as.factor para determinar cómo crear un factor "ordenado"

meses<-ordered(x=meses, levels= c("January", "February", "March", "Abril", 
                    "May", "June", "July",
                  "August", "September", "October", "November", 
                  "December"))

levels(meses)

meses<-ordered(levels=c("January", "February", "March", "Abril", 
  "May", "June", "July",
  "August", "September", "October", "November", 
  "December"), x=meses)

## numeric and integers

x<-1
class(x)

x<-as.integer(x)
class(x)
x

### List

x<- list(1:3, letters[1:3], is.numeric, 2>1)
x
x[1:2]
x[1]
x[[1]]
names(x)<-c("numbers", "letters", "function", "logical")

x$letters
x["letters"]
x$letters[1]
x[[2]][1]


### Dataframes
x <- data.frame(sp = c("Homo sapiens", "Homo sapiens", "Homo neanderthalensis", "Homo neanderthalensis"), sexo = c("Male", "Female", "Male", "Female"), edad = c(60,30,10,50))
x

x$sexo
x[["sexo"]]
x[,2]


x <- data.frame(sp = c("Homo sapiens", "Homo sapiens", "Homo neanderthalensis", "Homo neanderthalensis"), sexo = c("Male", "Female", "Male", "Female"), edad = c(60,30,10,50), stringsAsFactors = FALSE)

x<-cbind(x, pop=c("Australia", "Mesoamérica", "Europa", "África"))
x[c(1,2),]
x[1:2,]


#### Cargar librerías
install.packages("nombrepaquete")
turnover()

library(vegetarian)
detach("package:vegetarian", unload=TRUE)
require(vegetarian)

?turnover() 


### Cargar archivos
?read.delim

# WD
getwd()






































































