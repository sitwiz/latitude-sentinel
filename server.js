import express from 'express';
import cors from 'cors';
import axios from 'axios';
import 'dotenv/config';

const app = express();
app.use(cors());

const PORT = process.env.PORT || 5000;
const LATITUDE_API = "https://api.latitude.sh";

// This is a test route to see if the server is alive
app.get('/', (req, res) => {
  res.send("Sentinel Backend is Online!");
});

// The actual data route
app.get('/api/stats', async (req, res) => {
  try {
    const response = await axios.get(`${LATITUDE_API}/servers`, {
      headers: { 'Authorization': `Bearer ${process.env.LATITUDE_API_KEY}` }
    });
    res.json(response.data);
  } catch (error) {
    console.error("API Error:", error.response ? error.response.data : error.message);
    res.status(500).json({ error: "Failed to fetch Latitude stats. Check your API Key." });
  }
});

app.listen(PORT, '0.0.0.0', () => {
  console.log(`🚀 Backend running on http://0.0.0.0:${PORT}`);
});
