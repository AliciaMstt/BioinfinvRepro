#! /bin/bash

#### Crear un PopulationMap para cada población (Estado+Altitud)

for i in Dgo Sin Son Chi Zac; do
## Crear parametros para grep
# esto es necesario para poder poner una variable dentro de un grep y que no se confunda con el $
# para busqueda en archivo 
grep_paramsAlt="${i}Alt.*" 
grep_paramsBaj="${i}Baj.*"
# para nombre de PopMap
grepPopMapAlt="${i}Alt.txt"
grepPopMapBaj="${i}Baj.txt"

## Usar grep para generar un pop map por cada pop
grep -oE $grep_paramsAlt ../stacks/PopMapAll.txt > ../stacks/PopMap$grepPopMapAlt
grep -oE $grep_paramsBaj ../stacks/PopMapAll.txt > ../stacks/PopMap$grepPopMapBaj
done

#### Correr populations de Stacks para los diferentes mínimos de individuos por cada población
for j in 7 8 9 10; do 
for x in DgoAlt SinAlt SonAlt ChiAlt ZacAlt DgoBaj SinBaj SonBaj ChiBaj ZacBaj; do

# Crear directorios para guardar datos
mkdir -p ../output.data/$x/$j

# calcular qué porcentaje de la población son el min de individuos deseados (populations lo ocupa en -r)
tot=`wc -l < ../stacks/PopMap$x.txt` # el texto se pone entre ` ` para indicar que es un comando que queremos asignar a una variable ("" no funcionarían)
pinds=`echo $j/$tot | bc -l` #bc es la calculadora para decimales en bash

# Correr populations Stacks para exportar a formato plink (como ejercicio solo correr un echo y guardarlo en el lugar que irían los resultados)
echo "populations -P ../stacks -M ../stacks/PopMap$x.txt -r $pinds -b 1 -f p_value --plink --write_single_snp" > ../output.data/$x/$j/falsoplink.out
done
done









