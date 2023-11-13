#!/bin/bash

# El usuario del sistema operativo que ingreso la informacion
usuario=$(whoami)

# El timestamp del ingreso (dia, mes, año, hora, minuto, segundo)
timestamp=$(date +%s)

# Este script permitirá eliminar una falta de un docente en el sistema.
read -p "Ingrese el CI del docente que desea eliminar la falta: " CI

# Verificamos si el docente tiene inasistencias registradas en el archivo faltas.csv
if grep -q "$CI" faltas.csv; then

    # Obtenemos la fecha actual en el formato MM/DD
    fecha_actual=$(date +"%m/%d")

    # Buscamos la cédula en el archivo y extraemos las fechas y tipo de falta
    datos_falta=$(grep "$CI" faltas.csv | cut -d':' -f2,3)

    # Separamos la fecha y el tipo de falta
    IFS=':' read -r fecha_falta tipo_falta <<< "$datos_falta"

    # Guardamos en una variable la linea que va ser modificada.
    linea_afectada=$CI:$fecha_actual:$tipo_falta

    # Verificamos si la falta está en la fecha actual
    if [ "$fecha_actual" == "$fecha_falta" ]; then

        # Eliminamos la falta del archivo faltas.csv
        sed -i "/$CI/d" faltas.csv
        echo "La falta del docente con CI $CI ha sido eliminada."

        echo "El usuario $usuario:$timestamp elimino la siguiente linea..." >> log.txt
        echo "$linea_afectada" >> log.txt
        echo " " >> log.txt

    else
        echo "ERROR: El docente con CI $CI no tiene una falta registrada en la fecha actual."
    fi else
    echo "ERROR: El docente con CI $CI no tiene inasistencias registradas." fi
fi

