#!/bin/bash

# Este script permitirá registrar una ausencia de un docente en el sistema.
read -p "Ingrese el CI del docente que desea registrar la ausencia: " CI

# Verificamos si el docente existe en el archivo docentes.csv
if grep -q "$CI" inasistencias.csv; then
        # El archivo inasistencias.csv contiene las inasistencias de los docentes en el formato: cedula:fecha_inicio:fecha_fin
        # Obtenemos la fecha actual en el formato MM/DD

        fecha_actual=$(date +"%m/%d")

        # Buscamos la cédula en el archivo y extraemos las fechas de inicio y fin
        fechas=$(grep "$CI" inasistencias.csv | cut -d':' -f3,4)

        # Separamos las fechas de inicio y fin
        IFS=':' read -r fecha_inicio fecha_fin <<< "$fechas"
        # Convertimos las fechas a formato timestamp ya que no podremos usarlo en el formato mes/dia en el if.

        fecha_actual_timestamp=$(date -d "$fecha_actual" +"%s")
        fecha_inicio=$(date -d "$fecha_inicio" +"%s")
        fecha_fin=$(date -d "$fecha_fin" +"%s")

        # Comparamos las fechas
        if [ $fecha_actual_timestamp -ge $fecha_inicio ] && [ $fecha_actual_timestamp -le $fecha_fin ]; then

        echo "La fecha actual está dentro del rango de ausencia para el docente con CI $CI"
        echo "$CI:$fecha_actual:"Justificado"" >> faltas.csv

    else
        echo "$CI:$fecha_actual:"Injustificado"" >> faltas.csv
        echo "ERROR: La fecha actual no está en el rango de ausencia para el docente con CI $CI"

    fi else
        echo "ERROR: El docente con CI $CI no tiene inasistencias registradas."
fi
