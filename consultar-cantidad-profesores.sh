#!/bin/bash

# En este script servira para imprimir en la terminal la cantidad y una lista de profesores que hay en el sistema.

# Mostramos los profesores que se encuentran en docentes.csv
echo "Los profes del sistema son: "
cat docentes.csv

echo " "

# Mostramos la cantidad de profesores que hay en docentes.csv
echo "La cantidad de profesores en total son..."
cat docentes.csv | wc -l
