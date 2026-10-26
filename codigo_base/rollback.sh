#!/usr/bin/env bash
set -e

echo "=========================================================="
echo "  ROLLBACK INSTANTÁNEO: RETORNANDO A BLUE"
echo "=========================================================="

echo "[1/2] Revirtiendo archivo auxiliar de upstream hacia app-blue..."
sed -i 's/app-green:8080/app-blue:8080/' ./nginx/conf.d/upstream.conf

echo "[2/2] Recargando Nginx en caliente..."
docker exec nginx-router nginx -s reload

echo "=========================================================="
echo "🔄 ROLLBACK COMPLETADO. Producción retornó a BLUE (v1.0.0)"
echo "=========================================================="
