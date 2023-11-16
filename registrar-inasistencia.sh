#!/bin/bash
# Un script que permitira registrar a un docente en el sistema.

# Limpiamos la terminal
clear

# Pedimos los datos al operador para registrar al docente
read -p "Ingrese el CI del docente: " CI
# Validamos si el usuario realmente puso el CI y a su vez que sean numeros.
if [ -z "$CI" ] || ! [[ "$CI" =~ ^[0-9]+$ ]]; then
    echo "El CI ingresado no es válido."
    exit 1
fi

read -p "Ingrese la fecha (en formato MM/DD) inicial de la ausencia: " fecha_inicial
# Validamos si realmente puso una fecha y que este respte el formato (MM/DD)
if [ -z "$fecha_inicial" ] || ! [[ "$fecha_inicial" =~ ^[0-9]{2}/[0-9]{2}$ ]]; then
    echo "La fecha ingresada no es válida. Por favor, ingrese la fecha en formato (MM/DD)."
    exit 1
fi

read -p "Ingrese la fecha (en formato MM/DD) final de la ausencia: " fecha_final
# Validamos si realmente puso una fecha y que este respte el formato (MM/DD)
if [ -z "$fecha_final" ] || ! [[ "$fecha_final" =~ ^[0-9]{2}/[0-9]{2}$ ]]; then
    echo "La fecha ingresada no es válida. Por favor, ingrese la fecha en formato (MM/DD)."
    exit 1
fi

# El usuario del sistema operativo que ingreso la informacion
usuario=$(whoami)

# El timestamp del ingreso (dia, mes, año, hora, minuto, segundo)
timestamp=$(date +%s)

# Limpiamos la terminal
clear

# Una vez pasado la validacion del CI, buscaremos si realmente existe en el sistema. Sino, no se guardara y se cancelara el proceso.
if grep -q "$CI" docentes.csv; then
    echo "$usuario:$CI:$fecha_inicial:$fecha_final:$timestamp" >> inasistencias.csv
    echo "La ausencia del docente con CI $CI ha sido registrada exitosamente."
else
    echo "No se ha podido registrar la inasistencia ya que el CI dado no existe en el sistema."
    exit 1
fi