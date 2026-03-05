-- Places table: normalisasi nama tempat untuk reuse & geocoding.
CREATE TABLE IF NOT EXISTS places (
  id INTEGER PRIMARY KEY AUTOINCREMENT,
  project_id INTEGER NOT NULL,

  -- Nama tempat sebagaimana ditulis di GEDCOM (bisa sangat panjang/hierarkis).
  name TEXT NOT NULL,

  -- Versi yang ternormalisasi / diproses (opsional).
  normalized_name TEXT,

  latitude REAL,
  longitude REAL,

  -- Status geocoding: 'UNKNOWN', 'RESOLVED', 'FAILED', dst.
  geocode_status TEXT,

  FOREIGN KEY (project_id) REFERENCES projects(id) ON DELETE CASCADE
);

CREATE INDEX IF NOT EXISTS idx_places_project
  ON places(project_id);

CREATE INDEX IF NOT EXISTS idx_places_project_name
  ON places(project_id, name);

