#!/bin/bash

# Limpiamos la terminal
clear

# Solicitar el CI del docente
read -p "Ingrese el CI del docente que deseas consultar su faltas: " CI

# Validar si el usuario realmente puso el CI y a su vez que sean numeros.
if [ -z "$CI" ] || ! [[ "$CI" =~ ^[0-9]+$ ]]; then
    echo "El CI ingresado no es válido."
    exit 1
fi

# Verificamos antes si existe el archivo faltas.csv
if [ ! -f "faltas.csv" ]; then
    echo "No existe el archivo faltas.csv por favor, primero registre faltas."
    exit 1
fi

# Filtrar las líneas del archivo CSV para el docente específico
faltas_docente=$(grep "^$CI:" "faltas.csv")

if [ -n "$faltas_docente" ]; then
    total_faltas=$(cat faltas.csv | grep $CI | wc -l)
    echo "El docente: $CI tiene $total_faltas faltas en total..."

    cat faltas.csv | grep $CI
else
    echo "No se encontraron faltas para el docente con CI $CI"
fi
