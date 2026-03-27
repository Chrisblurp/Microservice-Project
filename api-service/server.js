const express = require("express");
const cors = require("cors");
const { Pool } = require("pg");

const app = express();
app.use(cors());
app.use(express.json());

const PORT = process.env.PORT || 3000;

// PostgreSQL connection
const pool = new Pool({
  host: "postgres",
  user: "admin",
  password: "password",
  database: "devopsdb",
  port: 5432,
});

app.get("/", (req, res) => {
  res.json({ message: "API Service Running with DB 🚀" });
});

app.get("/health", (req, res) => {
  res.status(200).send("OK");
});

// Create table (auto init)
app.get("/init", async (req, res) => {
  await pool.query(`
    CREATE TABLE IF NOT EXISTS users (
      id SERIAL PRIMARY KEY,
      name TEXT
    )
  `);
  res.send("Table created");
});

// Add user
app.post("/users", async (req, res) => {
  const { name } = req.body;
  const result = await pool.query(
    "INSERT INTO users(name) VALUES($1) RETURNING *",
    [name]
  );
  res.json(result.rows[0]);
});

// Get users
app.get("/users", async (req, res) => {
  const result = await pool.query("SELECT * FROM users");
  res.json(result.rows);
});

app.listen(PORT, () => {
  console.log(`API running on port ${PORT}`);
});