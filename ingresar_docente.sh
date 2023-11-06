#!/bin/bash

read -p "Ingrese el Nombre y Apellido del docente: " Nombre Apellido

read -p "Ingrese el CI del docente: " CI

echo "$Nombre:$Apellido:$CI" >> lista_docentes.txt

faltas=0

echo "$Nombre:$Apellido:$CI:$faltas" >> lista_faltas.txt
