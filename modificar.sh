#!/bin/bash
# Este script permitirá realizar modificaciones a una falta de un docente en el sistema.

# Limpiamos la terminal
clear

# El usuario y el timestamp del sistema que ingreso la informacion
usuario=$(whoami)
timestamp=$(date +"%Y/%m/%d")

read -p "Ingrese el CI del docente que desea modificar la falta: " CI 

# Validar si el usuario realmente puso el CI y a su vez que sean números.
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

    # Solicitamos la fecha que se desea modificar
    read -p "Ingrese la fecha en formato MM/DD de la falta que desea modificar: " fecha_modificar

    # Validamos el formato de la fecha
    if ! [[ "$fecha_modificar" =~ ^[0-9]{2}/[0-9]{2}$ ]]; then
        echo "Formato de fecha no válido. Debe ser en formato MM/DD."
        exit 1
    fi

    # Buscamos la cédula en el archivo y extraemos las fechas y tipo de falta
    datos_falta=$(grep "$CI:$fecha_modificar" faltas.csv | cut -d':' -f2,3)

    # Separamos la fecha y el tipo de falta
    IFS=':' read -r fecha_falta tipo_falta <<< "$datos_falta"

    # Mostramos la información actual de la falta
    echo "Falta actual para el docente con CI $CI en la fecha $fecha_modificar:"
    echo "Fecha: $fecha_falta"
    echo "Tipo: $tipo_falta"

    # Guardamos en una variable la linea que fue modificada.
    linea_afectada=$CI:$fecha_falta:$tipo_falta

    # Preguntamos al usuario si desea cambiar la fecha o el tipo de falta
    read -p "¿Desea cambiar la fecha (1) o el tipo de falta (2)? " opcion

    if [ "$opcion" == "1" ]; then
        # Si elige cambiar la fecha, le pedimos la nueva fecha
        read -p "Ingrese la nueva fecha en formato MM/DD: " nueva_fecha

        # Reemplazamos la fecha antigua con la nueva en el archivo faltas.csv
        sed -i "s#$CI:$fecha_falta:$tipo_falta#$CI:$nueva_fecha:$tipo_falta#" faltas.csv
        echo "La falta del docente con CI $CI en la fecha $fecha_modificar ha sido modificada. Nueva fecha: $nueva_fecha"

        # Guardamos la modificacion en un log.txt
        echo "El usuario $usuario:$timestamp modifico la siguiente linea..." >> log.txt
        echo "$linea_afectada" >> log.txt
        echo "La nueva linea es..." >> log.txt
        echo "$CI:$nueva_fecha:$tipo_falta" >> log.txt
        echo " " >> log.txt
    elif [ "$opcion" == "2" ]; then
        # Si elige cambiar el tipo de falta, le pedimos la nueva opción
        read -p "Ingrese el nuevo tipo de falta (1 = Injustificado, 2 = Justificado): " nuevo_tipo

        # Validamos la nueva opción y asignamos el texto correspondiente
        if [ "$nuevo_tipo" == "1" ]; then
            nuevo_tipo_texto="Injustificado"
        elif [ "$nuevo_tipo" == "2" ]; then
            nuevo_tipo_texto="Justificado"
        else
            echo "ERROR: Opción de tipo de falta no válida."
            exit 1
        fi

        # Reemplazamos el tipo de falta antiguo con el nuevo en el archivo faltas.csv
        sed -i "s#$CI:$fecha_falta:$tipo_falta#$CI:$fecha_falta:$nuevo_tipo_texto#" faltas.csv
        echo "La falta del docente con CI $CI en la fecha $fecha_modificar ha sido modificada. Nuevo tipo: $nuevo_tipo_texto"

        # Guardamos la modificacion en un log.txt con el usuario
        echo "El usuario $usuario:$timestamp modifico la siguiente linea" >> log.txt
        echo "$linea_afectada" >> log.txt
        echo "La nueva linea es..." >> log.txt
        echo "$CI:$fecha_modificar:$nuevo_tipo_texto" >> log.txt
        echo " " >> log.txt
    else
        echo "ERROR: Opción no válida."
    fi
else
    echo "ERROR: El docente con CI $CI no tiene inasistencias registradas."
fi