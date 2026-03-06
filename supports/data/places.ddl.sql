-- Places table: menyimpan informasi lokasi geografis (opsional untuk fase awal).
CREATE TABLE IF NOT EXISTS places (
  id INTEGER PRIMARY KEY AUTOINCREMENT,
  name TEXT NOT NULL,
  latitude REAL,
  longitude REAL
);
