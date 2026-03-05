-- Persons table: menyimpan individu dalam satu project GEDCOM.
-- Dirancang untuk skala ribuan-puluhan ribu record per project.
CREATE TABLE IF NOT EXISTS persons (
  id INTEGER PRIMARY KEY AUTOINCREMENT,
  project_id INTEGER NOT NULL,

  -- ID referensi dari berkas GEDCOM (mis. @I1@), opsional.
  gedcom_xref TEXT,

  given_name TEXT,
  surname TEXT,
  nickname TEXT,
  gender TEXT, -- mis. 'M', 'F', 'U' (unknown) atau nilai lain yang dipetakan dari GEDCOM.

  -- Tanggal dalam representasi string GEDCOM agar fleksibel (partial/approximate).
  birth_date TEXT,
  death_date TEXT,

  -- Relasi ke places (opsional, untuk normalisasi).
  birth_place_id INTEGER,
  death_place_id INTEGER,

  is_living INTEGER NOT NULL DEFAULT 1, -- 0 = tidak, 1 = ya.

  notes TEXT,

  FOREIGN KEY (project_id) REFERENCES projects(id) ON DELETE CASCADE,
  FOREIGN KEY (birth_place_id) REFERENCES places(id) ON DELETE SET NULL,
  FOREIGN KEY (death_place_id) REFERENCES places(id) ON DELETE SET NULL
);

CREATE INDEX IF NOT EXISTS idx_persons_project
  ON persons(project_id);

CREATE INDEX IF NOT EXISTS idx_persons_project_name
  ON persons(project_id, surname, given_name);

CREATE INDEX IF NOT EXISTS idx_persons_gedcom_xref
  ON persons(project_id, gedcom_xref);

