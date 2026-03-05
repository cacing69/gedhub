-- Contacts table: kontak per person (telepon, email, dll.) dari berbagai provider.
-- Relasi ke persons; mendukung multi-provider (contact_picker, manual, gedcom, dll).
-- Target dasar: Contact Picker (device contacts) — nantinya dapat ditambah provider lain.
CREATE TABLE IF NOT EXISTS contacts (
  id INTEGER PRIMARY KEY AUTOINCREMENT,
  project_id INTEGER NOT NULL,
  person_id INTEGER NOT NULL,

  -- Provider/sumber data: 'contact_picker', 'manual', 'gedcom', dll.
  provider TEXT NOT NULL,

  -- Tipe kontak: 'phone', 'email', 'address', 'url', 'other'.
  contact_type TEXT NOT NULL,

  -- Nilai kontak (nomor telepon, alamat email, teks alamat, URL, dsb.).
  value TEXT NOT NULL,

  -- Label opsional dari provider (mis. 'Mobile', 'Home', 'Work' dari contact picker).
  label TEXT,

  -- ID dari provider untuk deduplikasi/sync (mis. contact picker contact id).
  provider_contact_id TEXT,

  -- Urutan tampilan per person.
  sort_order INTEGER NOT NULL DEFAULT 0,

  notes TEXT,

  created_at INTEGER,
  updated_at INTEGER,

  FOREIGN KEY (project_id) REFERENCES projects(id) ON DELETE CASCADE,
  FOREIGN KEY (person_id) REFERENCES persons(id) ON DELETE CASCADE
);

CREATE INDEX IF NOT EXISTS idx_contacts_project
  ON contacts(project_id);

CREATE INDEX IF NOT EXISTS idx_contacts_person
  ON contacts(person_id);

CREATE INDEX IF NOT EXISTS idx_contacts_person_provider
  ON contacts(person_id, provider);

CREATE INDEX IF NOT EXISTS idx_contacts_provider_external
  ON contacts(provider, provider_contact_id);
