#####################################################
# Dockerfile ejemplo
# Este dockerfile jala la ultima imagen de Ubuntu y crea una carpeta llamada prueba
## Para construir la imagen basada en este dockerfile escribir en la terminal (WD al docker file)
# docker build -t miproyecto/analisis1:v1 . 

# "miproyecto" es el nombre del repositorio y "analsis1:v1"" el de la imagen y la versión, estos **no** son los nombres de la carpeta y del dockerfile, sino otros que le asignamos.
 
## Para correr un proceso dentro del contenedor
# docker run -it miproyecto/analisis1:v1 /bin/bash
######################################################

# Set the base image to Ubuntu
FROM ubuntu:latest

# Crear una carpeta prueba
RUN mkdir /Prueba

# File author
MAINTAINER Alicia Mastretta-Yanes
