#!/bin/bash

# Solicitar el CI del docente
read -p "Ingrese el CI del docente que deseas consultar su faltas: " CI

# Filtrar las líneas del archivo CSV para el docente específico
faltas_docente=$(grep "^$CI:" "faltas.csv")

if [ -n "$faltas_docente" ]; then
    echo "Faltas del docente con CI $CI:"
    echo "$faltas_docente" | while IFS=: read -r ci fecha tipo; do
        echo "Falta registrada el $fecha: $tipo"
    done
else
    echo "No se encontraron faltas para el docente con CI $CI"
fi
