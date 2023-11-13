#!/bin/bash

# Solicitar el CI del docente
read -p "Ingrese el CI del docente que deseas consultar su faltas: " CI

# Filtrar las líneas del archivo CSV para el docente específico
faltas_docente=$(grep "$CI" "faltas.csv")

if [ -n "$faltas_docente" ]; then

    read -p "Ingrese el mes de las faltas que deseas buscar: " mes

    echo "Las faltas del docente: $CI en el mes: $mes son..."

    cat faltas.csv | grep $CI | grep $mes//*
else
    echo "No se encontraron faltas para el docente con CI $CI"
fi
