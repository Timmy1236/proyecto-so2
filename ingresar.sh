#!/bin/bash

read -p "Ingrese el CI del docente: " CI
# TODO: Validar esta variable

read -p "Ingrese la fecha de inicio de ausencia: " ausencia_inicio

read -p "Ingrese la fecha de finalizacion de ausencia: " ausencia_final

tiempo=$(date +%c)

#echo $USER

echo "$CI:$ausencia_inicio:$ausencia_final:$tiempo:$USER" >> lista_ausencias.txt
