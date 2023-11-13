#!/bin/bash

# Solicitar el CI del docente
read -p "Ingrese el nombre del usuario que deseas buscasr en los registros del sistema: " usuario

# Filtrar las líneas del archivo CSV para el docente específico
cambios_usuario=$(grep "$usuario" "log.txt")

if [ -n "$cambios_usuario" ]; then
    echo "El usuario: $usuario registro tantas lineas..."

    cat log.txt | grep $usuario | wc -l
else
    echo "No se encontro el usuario $usuario en el sistema."
fi
