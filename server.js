const express = require('express');
const { exec } = require('child_process');
const os = require('os');
const app = express();
const port = 3001; // API Port

app.get('/api/stats', (req, res) => {
    // This command checks PM2 to see if our specific nodes are online
    exec('pm2 jlist', (err, stdout) => {
        const processes = JSON.parse(stdout);
        
        const getStatus = (name) => {
            const proc = processes.find(p => p.name === name);
            return proc ? proc.pm2_env.status : 'offline';
        };

        res.json({
            cpu: (os.loadavg()[0] * 100 / os.cpus().length).toFixed(2),
            ram: ((1 - os.freemem() / os.totalmem()) * 100).toFixed(2),
            nodes: {
                execution: { name: 'Reth', status: getStatus('eth-execution') },
                consensus: { name: 'Lighthouse', status: getStatus('eth-consensus') }
            }
        });
    });
});

app.listen(port, () => {
    console.log(`Sentinel API listening at http://localhost:${port}`);
});
