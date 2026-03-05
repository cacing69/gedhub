-- Events table: menyimpan peristiwa penting (kelahiran, pernikahan, kematian, dll)
-- yang dapat dikaitkan ke satu atau lebih person/family lewat event_participants.
CREATE TABLE IF NOT EXISTS events (
  id INTEGER PRIMARY KEY AUTOINCREMENT,
  project_id INTEGER NOT NULL,

  gedcom_xref TEXT,

  event_type TEXT NOT NULL, -- mis. 'BIRTH', 'MARRIAGE', 'DEATH', 'BAPTISM', dll.

  -- Tanggal dalam bentuk string agar fleksibel menangani partial/approximate dates.
  date TEXT,

  -- Kolom bantu untuk sorting (mis. Julian day / epoch, diisi oleh aplikasi).
  sort_date INTEGER,

  place_id INTEGER,

  primary_person_id INTEGER,

  notes TEXT,

  FOREIGN KEY (project_id) REFERENCES projects(id) ON DELETE CASCADE,
  FOREIGN KEY (place_id) REFERENCES places(id) ON DELETE SET NULL,
  FOREIGN KEY (primary_person_id) REFERENCES persons(id) ON DELETE SET NULL
);

CREATE INDEX IF NOT EXISTS idx_events_project
  ON events(project_id);

CREATE INDEX IF NOT EXISTS idx_events_project_type
  ON events(project_id, event_type);

CREATE INDEX IF NOT EXISTS idx_events_project_sort_date
  ON events(project_id, sort_date);

-- Event participants: menghubungkan event dengan person/family dan rolenya.
CREATE TABLE IF NOT EXISTS event_participants (
  id INTEGER PRIMARY KEY AUTOINCREMENT,
  project_id INTEGER NOT NULL,
  event_id INTEGER NOT NULL,

  person_id INTEGER,
  family_id INTEGER,

  -- Peran: 'SUBJECT', 'SPOUSE', 'PARENT', 'CHILD', 'WITNESS', dll.
  role TEXT,

  FOREIGN KEY (project_id) REFERENCES projects(id) ON DELETE CASCADE,
  FOREIGN KEY (event_id) REFERENCES events(id) ON DELETE CASCADE,
  FOREIGN KEY (person_id) REFERENCES persons(id) ON DELETE CASCADE,
  FOREIGN KEY (family_id) REFERENCES families(id) ON DELETE CASCADE
);

CREATE INDEX IF NOT EXISTS idx_event_participants_project_event
  ON event_participants(project_id, event_id);

CREATE INDEX IF NOT EXISTS idx_event_participants_project_person
  ON event_participants(project_id, person_id);

