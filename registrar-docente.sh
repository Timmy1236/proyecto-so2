#!/bin/bash

# Un script que permitira registrar a un docente en el sistema. Limpiamos la terminal
clear

# Pedimos los datos al operador para registrar al docente
read -p "Ingrese el nombre y el apellido del docente: " nombre apellido
read -p "Ingrese el CI del docente: " CI

# Pasamos todos los datos a un archivo docentes.csv, si no existe, se creara, si existe, no se ramplazara y se agrega al final.
echo "$CI:$nombre:$apellido" >> docentes.csv
