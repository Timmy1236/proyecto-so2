#!/bin/bash

# Solicitar el CI del docente
read -p "Ingrese el CI del docente que deseas consultar su faltas: " CI

# Filtrar las líneas del archivo CSV para el docente específico
faltas_docente=$(grep "^$CI:" "faltas.csv")

if [ -n "$faltas_docente" ]; then
    echo "El docente: $CI tiene faltas en total..."

    cat faltas.csv | grep $CI
    cat faltas.csv | grep $CI | wc -l
else
    echo "No se encontraron faltas para el docente con CI $CI"
fi
