#!/bin/bash
# El script principal del menu, este debe ser el primero que se ejecuta.

# Limpiamos la terminal para dejar la terminal mas limpia
clear

# Esta variable guardara la opcion del usuario, lo creamos acá por el while.
op=0

# Todo lo que esta dentro de este while se va ejecutar repetidamente hasta que el usuario seleccione la opcion 5.
while [ $op -ne 10 ]; do

echo -e "-----------[MENU]-----------\n1) Registrar Docente.\n2) Registrar Inasistencia.\n3) Ingresar falta.\n4) Eliminar falta.\n5) Modificar falta.\n6) Consultar faltas en un mes de un docente.\n7) Consultar faltas totales de un docente.\n8) Consultar la cantidad de docentes que hay en el sistema.\n9) Consultar los registros de un usuario en un mes.\n10) Salir."
read -p "Seleccione una opcion: " op

# Verificamos que la opcion ingresada por el usuario sea solo nuemros y no letras.
if ! [[ "$op" =~ ^[0-9]+$ ]]; then
    echo "La opcion ingresada no es válida."
    exit 1
fi

case $op in
1) ./registrar-docente.sh;;
2) ./registrar-inasistencia.sh;;
3) ./altas.sh;;
4) ./bajas.sh;;
5) ./modificar.sh;;
6) ./consultar-faltas-mes.sh;;
7) ./consultar-faltas-total.sh;;
8) ./consultar-cantidad-docentes.sh;;
9) ./consultar-registros.sh;;
10) echo "Saliendo del menu...";;
*) echo "Error, no puedes saltarte el rango de opciones.";;
esac
done