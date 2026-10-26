const express = require('express');
const app = express();
const PORT = 8080;

const ENV_NAME = process.env.APP_ENV || 'BLUE';
const VERSION = process.env.APP_VERSION || '1.0.0';
const COLOR = process.env.APP_COLOR || '#1E40AF';

app.get('/api/health', (req, res) => {
  res.json({ status: 'UP', environment: ENV_NAME, version: VERSION });
});

app.get('/api/info', (req, res) => {
  res.json({
    status: 'ACTIVE',
    environment: ENV_NAME,
    version: VERSION,
    color: COLOR,
    timestamp: new Date().toISOString()
  });
});

app.get('/', (req, res) => {
  res.send(`
    <html>
      <body style="background-color: ${COLOR}; color: white; font-family: sans-serif; display: flex; align-items: center; justify-content: center; height: 100vh; margin: 0;">
        <div style="text-align: center; padding: 2rem; border-radius: 12px; background: rgba(0,0,0,0.3);">
          <h1>Entorno de Producción: ${ENV_NAME}</h1>
          <p>Versión Desplegada: <strong>${VERSION}</strong></p>
          <p>Universidad Icesi — Ingesoft V</p>
        </div>
      </body>
    </html>
  `);
});

app.listen(PORT, () => {
  console.log(`[${ENV_NAME}] Servidor iniciado en puerto ${PORT}`);
});
