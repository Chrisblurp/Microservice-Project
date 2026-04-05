const express = require('express');
const cors = require('cors');
const app = express();
const PORT = process.env.PORT || 3000;

app.use(cors());
app.use(express.json());

// Health check endpoint
app.get('/health', (req, res) => {
    res.send('OK');
});

// Metrics endpoint
app.get('/metrics', (req, res) => {
    const os = require('os');
    res.json({
        service: 'api-service',
        status: 'healthy',
        uptime: process.uptime(),
        memory: process.memoryUsage(),
        cpu_load: os.loadavg(),
        node_version: process.version,
        timestamp: new Date().toISOString()
    });
});

// Root endpoint
app.get('/', (req, res) => {
    res.json({ message: 'API Service Running' });
});

app.listen(PORT, () => {
    console.log(`API Service running on port ${PORT}`);
});
