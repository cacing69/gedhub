-- Families table: mewakili unit keluarga (satu kelompok relasi orang).
CREATE TABLE IF NOT EXISTS families (
  id INTEGER PRIMARY KEY AUTOINCREMENT,
  project_id INTEGER NOT NULL,

  -- ID referensi dari GEDCOM (mis. @F1@).
  gedcom_xref TEXT,

  family_type TEXT, -- mis. 'NUCLEAR', 'EXTENDED', dll (opsional, lebih ke metadata).
  notes TEXT,

  FOREIGN KEY (project_id) REFERENCES projects(id) ON DELETE CASCADE
);

CREATE INDEX IF NOT EXISTS idx_families_project
  ON families(project_id);

CREATE INDEX IF NOT EXISTS idx_families_gedcom_xref
  ON families(project_id, gedcom_xref);

-- Family members: menghubungkan persons ke families dengan role fleksibel.
CREATE TABLE IF NOT EXISTS family_members (
  id INTEGER PRIMARY KEY AUTOINCREMENT,
  project_id INTEGER NOT NULL,
  family_id INTEGER NOT NULL,
  person_id INTEGER NOT NULL,

  -- Peran dalam keluarga: 'PARENT', 'CHILD', 'SPOUSE', 'PARTNER', 'OTHER', dll.
  role TEXT NOT NULL,

  -- Urutan di antara saudara kandung, dsb (opsional).
  sort_order INTEGER,

  FOREIGN KEY (project_id) REFERENCES projects(id) ON DELETE CASCADE,
  FOREIGN KEY (family_id) REFERENCES families(id) ON DELETE CASCADE,
  FOREIGN KEY (person_id) REFERENCES persons(id) ON DELETE CASCADE
);

CREATE INDEX IF NOT EXISTS idx_family_members_project_family
  ON family_members(project_id, family_id);

CREATE INDEX IF NOT EXISTS idx_family_members_project_person
  ON family_members(project_id, person_id);

