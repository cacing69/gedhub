-- Sources table: menyimpan sumber informasi (buku, arsip, dokumen, dll).
CREATE TABLE IF NOT EXISTS sources (
  id INTEGER PRIMARY KEY AUTOINCREMENT,
  project_id INTEGER NOT NULL,

  gedcom_xref TEXT,

  title TEXT NOT NULL,
  author TEXT,
  publication_facts TEXT,
  repository TEXT,
  call_number TEXT,

  notes TEXT,

  FOREIGN KEY (project_id) REFERENCES projects(id) ON DELETE CASCADE
);

CREATE INDEX IF NOT EXISTS idx_sources_project
  ON sources(project_id);

CREATE INDEX IF NOT EXISTS idx_sources_project_title
  ON sources(project_id, title);

-- Source citations: menghubungkan sources dengan entitas domain (person/family/event).
CREATE TABLE IF NOT EXISTS source_citations (
  id INTEGER PRIMARY KEY AUTOINCREMENT,
  project_id INTEGER NOT NULL,
  source_id INTEGER NOT NULL,

  -- Target citation. Hanya salah satu dari person_id / family_id / event_id
  -- yang diisi dalam satu baris (dikontrol oleh aplikasi).
  person_id INTEGER,
  family_id INTEGER,
  event_id INTEGER,

  page TEXT,
  quality INTEGER, -- mis. 0-3 atau 0-5, tergantung mapping dari GEDCOM QUAY.
  note TEXT,

  FOREIGN KEY (project_id) REFERENCES projects(id) ON DELETE CASCADE,
  FOREIGN KEY (source_id) REFERENCES sources(id) ON DELETE CASCADE,
  FOREIGN KEY (person_id) REFERENCES persons(id) ON DELETE CASCADE,
  FOREIGN KEY (family_id) REFERENCES families(id) ON DELETE CASCADE,
  FOREIGN KEY (event_id) REFERENCES events(id) ON DELETE CASCADE
);

CREATE INDEX IF NOT EXISTS idx_source_citations_project_source
  ON source_citations(project_id, source_id);

CREATE INDEX IF NOT EXISTS idx_source_citations_project_person
  ON source_citations(project_id, person_id);

CREATE INDEX IF NOT EXISTS idx_source_citations_project_event
  ON source_citations(project_id, event_id);

