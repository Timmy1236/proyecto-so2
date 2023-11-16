#!/bin/bash
# Este script permite mostrar una lista de faltas y poder eliminar una de ellas del sistema.

# Limpiamos la terminal
clear

# El usuario y el timestamp del sistema que ingreso la informacion
usuario=$(whoami)
timestamp=$(date +"%Y/%m/%d")

read -p "Ingrese el CI del docente que desea gestionar las faltas: " CI 

# Validar si el usuario realmente puso el CI y a su vez que sean numeros.
if [ -z "$CI" ] || ! [[ "$CI" =~ ^[0-9]+$ ]]; then
    echo "El CI ingresado no es válido."
    exit 1
fi

# Verificamos antes si existe el archivo faltas.csv
if [ ! -f "faltas.csv" ]; then
    echo "No existe el archivo faltas.csv. Por favor, primero registre faltas."
    exit 1
fi

# Verificamos si el docente tiene inasistencias registradas en el archivo faltas.csv
if grep -q "$CI" faltas.csv; then
    # Mostramos todas las faltas del docente
    echo "Faltas del docente con CI $CI:"
    grep "$CI" faltas.csv | while read -r line; do
        echo "$line"
    done

    # Solicitamos la fecha que se desea eliminar
    read -p "Ingrese la fecha en formato MM/DD de la falta que desea eliminar: " fecha_eliminar_raw

    # Limpiamos la fecha para que sed -i no tenga problemas con los caracteres especiales
    fecha_eliminar="$(echo "$fecha_eliminar_raw" | sed -e 's/[]\/$*.^[]/\\&/g')"

    # Validamos el formato de la fecha
    if ! [[ "$fecha_eliminar_raw" =~ ^[0-9]{2}/[0-9]{2}$ ]]; then
        echo "Formato de fecha no válido. Debe ser en formato MM/DD."
        exit 1
    fi

    # Extraemos el tipo de falta de la línea (log)
    tipo_falta=$(grep "$CI:$fecha_eliminar" faltas.csv | cut -d':' -f3)
    # Guardamos la línea que va a ser eliminada (log)
    linea_afectada=$CI:$fecha_eliminar_raw:$tipo_falta

    # Eliminamos la falta del archivo faltas.csv
    sed -i "/$CI:$fecha_eliminar/d" faltas.csv

    # Limpiamos la terminal 
    clear

    # Mostramos la información de la falta eliminada
    echo "La falta del docente $CI en la fecha $fecha_eliminar_raw ha sido eliminada."

    # Guardamos todo esto en un archivo log.txt
    echo "El usuario $usuario:$timestamp elimino la siguiente linea..." >> log.txt
    echo "$linea_afectada" >> log.txt
    echo " " >> log.txt # Esto es para que no quede todo tan pegado en el log ;)

else
    echo "ERROR: El docente con CI $CI no tiene inasistencias registradas."
fi
