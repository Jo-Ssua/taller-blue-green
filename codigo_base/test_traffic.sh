#!/usr/bin/env bash

echo "Iniciando monitor continuo de tráfico en http://localhost:8080..."
echo "Presione Ctrl+C para finalizar."
echo "--------------------------------------------------------"

COUNT=1
while true; do
    RESPONSE=$(curl -s http://localhost:8080/api/info || echo '{"status":"FAILED"}')
    ENV=$(echo "$RESPONSE" | grep -o '"environment":"[^"]*' | cut -d'"' -f4 || echo "ERROR")
    VER=$(echo "$RESPONSE" | grep -o '"version":"[^"]*' | cut -d'"' -f4 || echo "N/A")
    TIME=$(date +"%T")

    if [ "$ENV" = "BLUE" ]; then
        COLOR="\033[1;34m"
    elif [ "$ENV" = "GREEN" ]; then
        COLOR="\033[1;32m"
    else
        COLOR="\033[1;31m"
    fi
    NC="\033[0m"

    echo -e "[$TIME] Petición #$COUNT -> Entorno: ${COLOR}${ENV}${NC} | Versión: ${VER}"
    COUNT=$((COUNT + 1))
    sleep 0.5
done
