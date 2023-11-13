#!/bin/bash

# El usuario del sistema operativo que ingreso la informacion
usuario=$(whoami)

# El timestamp del ingreso (dia, mes, año, hora, minuto, segundo)
timestamp=$(date +%s)

# Este script permitirá realizar modificaciones a una falta de un docente en el sistema.
read -p "Ingrese el CI del docente que desea modificar la falta: " CI

# Verificamos si el docente tiene inasistencias registradas en el archivo faltas.csv
if grep -q "$CI" faltas.csv; then

    # Obtenemos la fecha actual en el formato MM/DD
    fecha_actual=$(date +"%m/%d")

    # Buscamos la cédula en el archivo y extraemos las fechas y tipo de falta
    datos_falta=$(grep "$CI" faltas.csv | cut -d':' -f2,3)

    # Separamos la fecha y el tipo de falta
    IFS=':' read -r fecha_falta tipo_falta <<< "$datos_falta"

    # Mostramos la información actual de la falta
    echo "Falta actual para el docente con CI $CI:"
    echo "Fecha: $fecha_falta"
    echo "Tipo: $tipo_falta"

    # Guardamos en una variable la linea que fue modificada.
    linea_afectada=$CI:$fecha_actual:$tipo_falta

    # Preguntamos al usuario si desea cambiar la fecha o el tipo de falta
    read -p "¿Desea cambiar la fecha (1) o el tipo de falta (2)? " opcion
    if [ "$opcion" == "1" ]; then

        # Si elige cambiar la fecha, le pedimos la nueva fecha
        read -p "Ingrese la nueva fecha en formato MM/DD: " nueva_fecha

        # Reemplazamos la fecha antigua con la nueva en el archivo faltas.csv
        sed -i "s#$CI:$fecha_falta:$tipo_falta#$CI:$nueva_fecha:$tipo_falta#" faltas.csv
        echo "La falta del docente con CI $CI ha sido modificada. Nueva fecha: $nueva_fecha"

        # Guardamos la modificacion en un log.txt con el usuario.
        echo "El usuario $usuario:$timestamp modifico la siguiente linea..." >> log.txt
        echo "$linea_afectada" >> log.txt
        echo "La nueva linea es..." >> log.txt
        echo "$CI:$nueva_fecha:$tipo_falta" >> log.txt
        echo " " >> log.txt

        elif [ "$nuevo_tipo" == "2" ]; then
            nuevo_tipo_texto="Justificada"

            # Guardamos la modificacion en un log.txt con el usuario
            echo "El usuario $usuario:$timestamp modifico la siguiente linea" >> log.txt
            echo "$linea_afectada" >> log.txt
            echo "La nueva linea es..." >> log.txt
            echo "$CI:$fecha_actual:$nuevo_tipo_texto" >> log.txt
            echo " " >> log.txt

        else
            echo "ERROR: Opción de tipo de falta no válida."
            exit 1
        fi

        # Reemplazamos el tipo de falta antiguo con el nuevo en el archivo faltas.csv
        sed -i "s#$CI:$fecha_falta:$tipo_falta#$CI:$fecha_falta:$nuevo_tipo_texto#" faltas.csv
        echo "La falta del docente con CI $CI ha sido modificada. Nuevo tipo: $nuevo_tipo_texto"
    else
        echo "ERROR: Opción no válida."
    fi else
    echo "ERROR: El docente con el CI $CI no tiene faltas registradas."
fi

