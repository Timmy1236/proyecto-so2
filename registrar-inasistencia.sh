#!/bin/bash

# Un script que permitira registrar a un docente en el sistema. Limpiamos la terminal
clear

# Pedimos los datos al operador para registrar al docente
read -p "Ingrese el CI del docente: " CI
read -p "Ingrese la fecha inicial de la ausencia: " fecha_inicial
read -p "Ingrese la fecha final de la ausencia: " fecha_final

# El usuario del sistema operativo que ingreso la informacion
usuario=$(whoami)

# El timestamp del ingreso (dia, mes, año, hora, minuto, segundo)
timestamp=$(date +%s)

# Primero comprobamos si esa CI existe en el archivo docentes.csv
if grep -q "$CI" docentes.csv; then
    echo "El docente existe en el sistema."
else
    echo "El docente no existe en el sistema."
    exit 1
fi

# Pasamos todos los datos a un archivo docentes.csv, si no existe, se creara, si existe, no se ramplazara y se agrega al final.
echo "$usuario:$CI:$fecha_inicial:$fecha_final:$timestamp" >> inasistencias.csv
