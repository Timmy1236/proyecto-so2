#!/bin/bash
# Este script nos permitirá buscar el nombre de un usuario en los registros del sistema.

# Limpiamos la terminal
clear

# Solicitar el CI del docente
read -p "Ingrese el nombre del usuario que desea buscar en los registros del sistema, sino déjelo vacío para buscarte en los registros: " usuario

# Si no hay nada en la variable de usuario, entonces se asigna el usuario actual
if [ -z "$usuario" ]; then
    usuario=$(whoami)
fi

# Verificamos antes si existe el archivo log.txt
if [ ! -f "log.txt" ]; then
    echo "No existe el archivo log.txt."
    exit 1
fi

# Solicitar el número de mes
read -p "Ingrese el número de mes (1-12) para filtrar la busqueda: " numero_mes

# Verificar si el número de mes es válido
if ! [[ "$numero_mes" =~ ^[1-9]|1[0-2]$ ]]; then
    echo "Número de mes no válido."
    exit 1
fi

# Filtrar las líneas del archivo CSV para el docente específico y el mes proporcionado
cambios_usuario=$(grep "$usuario" "log.txt" | grep "/$numero_mes/")

if [ -n "$cambios_usuario" ]; then
    modificaciones=$(echo "$cambios_usuario" | wc -l)
    echo "El usuario: $usuario modificó $modificaciones líneas en el mes $numero_mes."
else
    echo "No se encontró el usuario $usuario en el sistema para el mes $numero_mes."
fi
