#!/bin/bash

source validar_ci.sh

# Este script permitirá eliminar una falta de un docente en el sistema.

read -p "Ingrese el CI del docente que desea eliminar la falta: " CI 

if validate_ci $CI; then
  echo "Cédula válida"
else
  echo "Cédula no válida"
fi

# Verificamos si el docente tiene inasistencias registradas en el archivo faltas.csv
if grep -q "$CI" faltas.csv; then
    # Obtenemos la fecha actual en el formato MM/DD
    fecha_actual=$(date +"%m/%d")

    # Buscamos la cédula en el archivo y extraemos las fechas y tipo de falta
    datos_falta=$(grep "$CI" faltas.csv | cut -d':' -f2,3)

    # Separamos la fecha y el tipo de falta
    IFS=':' read -r fecha_falta tipo_falta <<< "$datos_falta"

    # Verificamos si la falta está en la fecha actual
    if [ "$fecha_actual" == "$fecha_falta" ]; then
        # Eliminamos la falta del archivo faltas.csv
        sed -i "/$CI/d" faltas.csv
        echo "La falta del docente con CI $CI ha sido eliminada."
        # Puedes agregar aquí las acciones adicionales que deseas realizar después de eliminar la falta
    else
        echo "ERROR: El docente con CI $CI no tiene una falta registrada en la fecha actual."
        # Puedes agregar aquí las acciones adicionales que deseas realizar si no hay falta en la fecha actual
    fi
else
    echo "ERROR: El docente con CI $CI no tiene inasistencias registradas."
fi
