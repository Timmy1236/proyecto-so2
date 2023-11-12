#!/bin/bash

# Limpiamos la terminal para dejar la terminal mas limpia
clear

# Esta variable guardara la opcion del usuario, lo creamos acá por el while.
op=0

# Todo lo que esta dentro de este while se va ejecutar repetidamente hasta que el usuario seleccione la opcion 5.
while [ $op -ne 6 ]; do

echo -e "-----------[MENU]-----------\n1) Registrar Docente.\n2) Registrar Inasistencia.\n3) Ingresar falta.\n4) Eliminar falta.\n5) Modificar falta.\n6) Salir."
read -p "Seleccione una opcion: " op

case $op in
1) ./registrar-docente.sh;;
2) ./registrar-inasistencia.sh;;
3) ./altas.sh;;
4) ./bajas.sh;;
5) ./modificar;;
6) echo "Saliendo del menu...";;
*) echo "error";;
esac
done