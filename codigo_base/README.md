# Laboratorio Práctico: Despliegue Blue-Green (Zero-Downtime)
### Universidad Icesi — Ingeniería de Software V (Sesión 21)
**Profesor:** Alejandro Muñoz Bravo

Este laboratorio implementa una arquitectura real de **Despliegue Blue-Green con Cero Tiempo de Inactividad** utilizando **Docker Compose** y **Nginx Reverse Proxy**.

---

## 1. Arquitectura del Laboratorio

```
                      [ Peticiones de Usuario ]
                                 │
                                 ▼
                     ┌───────────────────────┐
                     │ Nginx Reverse Proxy   │ (:8080)
                     │ (Hot reload - Zero DT)│
                     └───────────┬───────────┘
                                 │
             ┌───────────────────┴───────────────────┐
             │ 100% Tráfico (Inicial)                │ Smoke Tests / QA
             ▼                                       ▼
   ┌───────────────────┐                   ┌───────────────────┐
   │ Contenedor BLUE   │                   │ Contenedor GREEN  │
   │ Versión 1.0.0     │                   │ Versión 2.0.0     │
   │ (Puerto 8081)     │                   │ (Puerto 8082)     │
   └───────────────────┘                   └───────────────────┘
```

---

## 2. Instrucciones de Ejecución Paso a Paso

### Paso 1: Levantar los contenedores
```bash
docker compose up -d --build
```
Verifique que los 3 contenedores estén corriendo:
```bash
docker compose ps
```

### Paso 2: Generar tráfico continuo (Terminal 1)
Abra una primera terminal para observar cómo responde la aplicación en tiempo real:
```bash
./test_traffic.sh
```
Verá peticiones continuas respondiendo desde el entorno `BLUE` con versión `1.0.0`.

### Paso 3: Ejecutar la Conmutación Atómica (Terminal 2)
En una segunda terminal, ejecute el script de conmutación:
```bash
./switch.sh
```
Observe la Terminal 1: el flujo cambia a `GREEN` con versión `2.0.0` sin que ninguna petición falle o arroje error HTTP 502.

### Paso 4: Probar Rollback Inmediato
Si detecta alguna anomalía, revierta el tráfico instantáneamente a Blue:
```bash
./rollback.sh
```

---

## 3. Limpieza del Entorno
```bash
docker compose down
```
