#!/bin/bash

# Función para mostrar ayuda
mostrar_ayuda() {
    echo "Uso: $0 [-h horas] [-m minutos] [-k]"
    echo "-h: Mantener la Mac despierta por un número de horas."
    echo "-m: Mantener la Mac despierta por un número de minutos."
    echo "-k: Matar el proceso de caffeinate recién ejecutado."
    exit 1
}

# Función para matar el proceso de caffeinate
matar_proceso() {
    local pid=$(pgrep -f "caffeinate")
    if [ -z "$pid" ]; then
        echo "No se encontró ningún proceso de caffeinate para matar."
    else
        echo "Matando el proceso caffeinate con PID $pid..."
        kill -9 $pid
        echo "Proceso terminado."
    fi
    exit 0
}

# Inicializar la variable para el tiempo en segundos
tiempo_segundos=0

# Parsear argumentos
while getopts "h:m:k" opt; do
    case $opt in
        h)
            tiempo_segundos=$((OPTARG * 3600))
            ;;
        m)
            tiempo_segundos=$((OPTARG * 60))
            ;;
        k)
            matar_proceso
            ;;
        *)
            mostrar_ayuda
            ;;
    esac
done

# Verificar que se haya especificado un tiempo
if [ "$tiempo_segundos" -eq 0 ]; then
    mostrar_ayuda
fi

# Ejecutar el comando caffeinate con el tiempo calculado en segundo plano
echo "Manteniendo la Mac despierta durante $tiempo_segundos segundos..."
caffeinate -ids -t $tiempo_segundos &

# Guardar el PID del proceso
pid=$!
echo "Proceso caffeinate ejecutado con PID $pid."
