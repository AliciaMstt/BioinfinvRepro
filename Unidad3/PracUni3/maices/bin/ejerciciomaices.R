## Buena práctica

# que su WD sea DONDE VIVE EL SCRIPT
# hacer esto con 
# a) abrir R dando doble click en el script
# b) En el menú de RStudio: Session > Set Working directory > To surce file location

# cargar el archivo
# Prac_Uni3/maices/meta/maizteocintle_SNP50k_meta_extended.txt

tabla_maices<- read.delim(file="../meta/maizteocintle_SNP50k_meta_extended.txt",
               header=TRUE, sep = "\t")


# guardar los cambios a un archivo
?write.csv

MeGusta<-c("tangana nica", "tangana na")
write.table(MeGusta, sep= "\t", file="ejemmplo_borrame.txt")


altitudes<-tabla_maices$Altitud
mean(tabla_maices$Altitud)
min(tabla_maices$Altitud)
