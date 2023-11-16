#!/bin/bash
# En este script servira para imprimir en la terminal la cantidad y una lista de profesores que hay en el sistema.

# Limpiamos la terminal
clear

# Verificamos antes si existe el archivo docentes.csv
if [ ! -f "docentes.csv" ]; then
    echo "No existe el archivo docentes.csv por favor, primero registre docentes."
    exit 1
fi

# La cantidad en total de docentes que hay en el sistema.
cantidad_docentes=$(cat docentes.csv | wc -l)

# Mostramos los profesores que se encuentran en docentes.csv
echo "En total hay... $cantidad_docentes docentes en el sistema."
echo "Los docentes son:"
cat docentes.csv