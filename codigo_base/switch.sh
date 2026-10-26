#!/usr/bin/env bash
set -e

echo "=========================================================="
echo "  CONMUTACIÓN ATÓMICA DE TRÁFICO A GREEN (ZERO-DOWNTIME)"
echo "=========================================================="

echo "[1/3] Ejecutando Smoke Test en entorno GREEN (puerto 8082)..."
HEALTH_STATUS=$(curl -sf http://localhost:8082/api/health | grep "UP" || true)

if [ -z "$HEALTH_STATUS" ]; then
    echo "❌ ERROR: El contenedor Green no responde con estado UP."
    echo "    La conmutación fue ABORTADA para proteger la disponibilidad."
    exit 1
fi
echo "✅ Entorno Green saludable."

echo "[2/3] Actualizando archivo auxiliar de upstream hacia app-green..."
sed -i 's/app-blue:8080/app-green:8080/' ./nginx/conf.d/upstream.conf

echo "[3/3] Recargando Nginx en caliente sin interrumpir conexiones..."
docker exec nginx-router nginx -s reload

echo "=========================================================="
echo "🎉 ¡CONMUTACIÓN EXITOSA! Producción ahora atiende sobre GREEN"
echo "=========================================================="
