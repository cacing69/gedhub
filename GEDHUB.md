## GEDHUB – Spesifikasi Awal

GEDHUB adalah aplikasi **silsilah keturunan (genealogy)** yang berfokus pada **offline‑first app** dengan dukungan penuh terhadap format **GEDCOM**. Aplikasi ini ditujukan untuk membantu pengguna membangun dan mengelola pohon keluarga dengan antarmuka yang **clean**, **minimalis**, dan modern, terinspirasi dari desain library seperti `shadcn/ui` dan `Radix UI`.

Fitur dan konsep aplikasi banyak terinspirasi dari aplikasi **My Family Tree** dari Chronoplex Software [`My Family Tree`](https://chronoplexsoftware.com/myfamilytree/index.htm), namun GEDHUB akan dibangun dengan fokus pada arsitektur offline‑first dan extensibility untuk pengembangan selanjutnya.

---

## Tujuan & Sasaran

- **Offline‑first**: seluruh data utama (orang, keluarga, event, sumber) tersimpan secara lokal di perangkat pengguna dan dapat diakses tanpa koneksi internet.
- **Kompatibel GEDCOM**: mendukung import, export, dan pembuatan file GEDCOM baru sebagai format interoperabilitas dengan aplikasi genealogis lain.
- **Mendukung data besar & relasi kompleks**: mampu menangani ribuan hingga puluhan ribu individu dengan hubungan keluarga multi‑generasi dan pernikahan ganda.
- **UI clean & minimalis**: pengalaman pengguna yang sederhana, modern, dengan fokus pada keterbacaan dan kemudahan navigasi.

Target platform awal dijelaskan secara netral (web/desktop offline), namun desain UI mengacu pada ekosistem komponen modern ala `shadcn/ui` dan `Radix UI` (mis. stack React + Tailwind atau sejenisnya).

---

## AI-Driven Development

Aplikasi GEDHUB ini **dibangun sepenuhnya dengan bantuan AI** (Artificial Intelligence). Seluruh proses pengembangan meliputi:

- **Perencanaan arsitektur & fitur** – AI membantu merancang struktur aplikasi, memilih teknologi yang tepat, dan menentukan prioritas fitur.
- **Implementasi kode** – AI menulis kode Dart/Flutter yang mengikuti best practice (clean architecture, DRY, unit tests, error handling).
- **Refactoring & optimasi** – AI mengidentifikasi kode yang bisa di-improve dan melakukan refactor untuk menjaga kualitas.
- **Dokumentasi** – AI memperbarui dan menjaga dokumentasi (GEDHUB.md) agar selalu sinkron dengan implementasi.
- **Debugging & troubleshooting** – AI membantu memecahkan masalah, linter errors, dan edge cases.
- **Continuity** – AI memastikan implementasi baru konsisten dengan pola dan konvensi yang sudah ada.
- **Enhance when safe** – Saat memperbaiki atau menambah fitur, AI boleh (dan disarankan) memperkuat kode yang ada—mis. null-safety, tipe yang tepat, penghapusan duplikasi—selama tidak mengubah perilaku yang diharapkan dan tetap mengikuti panduan project.

**Setiap AI agent yang mengerjakan kode GEDHUB wajib mengikuti [Panduan untuk AI Agent](#panduan-untuk-ai-agent) di bawah dan tidak mengubah function/kode yang sudah ada kecuali memang sangat diperlukan.**

Pendekatan ini mempercepat pengembangan sambil menjaga konsistensi arsitektur, kode, dan dokumentasi.

---

## Panduan untuk AI Agent

**Dokumen ini (GEDHUB.md) adalah acuan utama untuk setiap AI agent yang mengerjakan project GEDHUB.** Agent wajib mengikuti instruksi dan pola di bawah; jangan mengubah kode yang sudah ada kecuali memang sangat diperlukan.

### Instruksi Wajib untuk Agent

1. **Ikuti panduan ini**
   - Setiap perubahan atau penambahan kode **harus** mengikuti pola, konvensi, dan struktur yang dideskripsikan di GEDHUB.md (termasuk bagian ini, Stack & Library, Prinsip Pengembangan Kode, dan Rencana Unit Test).
   - Sebelum mengubah atau menambah file, baca bagian yang relevan di GEDHUB.md dan bandingkan dengan contoh yang sudah ada di codebase (mis. fitur Projects, Peoples).

2. **Jangan mengubah sembarang function/kode yang sudah ada**
   - **Jangan** refactor, rename, atau mengubah signature/implementasi function, class, atau file yang sudah berjalan **kecuali**:
     - User secara eksplisit meminta perubahan tersebut, atau
     - Diperlukan untuk **memperbaiki bug** yang dilaporkan, atau
     - Diperlukan agar **fitur yang diminta** bisa berjalan (dan perubahan dibatasi sekecil mungkin), atau
     - Diperlukan agar kode **memenuhi pola yang didokumentasikan di GEDHUB.md** (mis. konvensi Drift, Riverpod, repository).
   - Jika ragu apakah suatu perubahan “sangat diperlukan”, prioritaskan **tidak mengubah** kode yang ada; cukup tambah kode baru atau beri saran di penjelasan.

3. **Pola di atas segalanya**
   - Konsistensi dengan pola yang sudah ada (folder, penamaan, signature, API Drift/Riverpod) lebih penting daripada “perbaikan” style yang tidak diminta. Jika ingin mengusulkan refactor besar, sampaikan dalam penjelasan dan jangan lakukan tanpa konfirmasi user.

4. **Enhancement hanya bila aman**
   - Memperkuat kode (null-safety, tipe, reuse) saat mengerjakan task yang diminta **boleh** dilakukan, asalkan tidak mengubah perilaku yang diharapkan dan tetap mengikuti pola di dokumen ini.

### Konteks & Prinsip Umum

- **Baca dulu, ubah belakangan**: sebelum mengubah atau menambah file, baca file terkait (repository, provider, halaman) dan contoh serupa di fitur lain (mis. Projects vs Peoples).
- **Ikuti pola yang sudah ada**: struktur folder, penamaan, signature method, dan cara pakai Drift/Riverpod/UI harus mengikuti contoh yang sudah dipakai di project.
- **Enhance when safe**: jika saat memperbaiki bug atau menambah fitur ada peluang untuk memperbaiki kode yang ada (mis. null-check, tipe yang lebih tepat, ekstraksi helper), lakukan selama tidak mengubah perilaku yang diharapkan dan tetap konsisten dengan style project.

### Struktur Folder & File

- **Feature-based**: `lib/features/<feature>/` dengan subfolder `domain/` (model, repository) dan `presentation/` (page, widget).
- **Test mirror**: `test/features/<feature>/` mengikuti struktur `lib/`; satu fitur punya set test sendiri (repository test, page test).
- **DDL referensi**: skema SQL di `supports/data/*.ddl.sql` (snake_case); implementasi Drift di Dart pakai camelCase dan selaras dengan DDL.

### Konvensi Drift (Database)

- **Kolom**: setiap getter kolom harus mengembalikan tipe kolom final, bukan `ColumnBuilder`. Akhiri chain dengan `()`:
  - `IntColumn get id => integer().autoIncrement()();`
  - `TextColumn get name => text()();`
  - `RealColumn get latitude => real().nullable()();`
- **Jangan pakai `int()`**: untuk kolom integer pakai `integer()`, bukan `int()`.
- **Return type**: sesuaikan dengan tipe kolom (`IntColumn`, `TextColumn`, `RealColumn`, `DateTimeColumn`).
- **Data class**: pakai `@DataClassName('XxxRow')` per tabel.
- **Migration**: `onCreate` pakai `m.createAll()` (bukan `createAllTables()`); `onUpgrade` pakai instance tabel dari generated DB (lowercase), mis. `m.createTable(persons)`, bukan `m.createTable(Persons)`.
- **Query chain**: saat memanggil `.where()` lalu `.write()` / `.getSingleOrNull()` / `.go()`, kelompokkan dengan kurung agar method dipanggil pada statement, bukan pada hasil `..where()` (yang void): `(_db.update(_db.persons)..where((p) => p.id.equals(id))).write(...)`.
- **Companion insert**: kolom required pakai nilai langsung (mis. `String`); kolom nullable pakai `Value(x)`.
- **Companion update**: semua field yang diubah pakai `Value(...)`; untuk “tidak diubah” pakai `Value.absent()`.
- **OrderBy**: pakai `OrderingTerm.asc(tabel.kolom)` / `OrderingTerm.desc(...)`, bukan kolom mentah.

### Repository & Domain

- **Abstraksi repository (interface + impl + fake)**:
  - Di **domain** definisikan **abstract interface** (mis. `abstract interface class PersonsRepository`) dengan method yang mengembalikan `Future<Either<RepositoryFailure, T>>` untuk operasi yang dapat gagal; stream tetap `Stream<List<T>>`.
  - **Implementasi nyata** (Drift/SQLite) di folder **data** dengan nama `XxxRepositoryImpl` (mis. `lib/features/peoples/data/persons_repository_impl.dart`). Provider mengembalikan tipe interface tetapi meng-instantiate impl: `return PersonsRepositoryImpl(db)` sehingga di test bisa di-override dengan fake.
  - **Fake** untuk test (in-memory, tanpa DB) implement interface yang sama (mis. `test/features/peoples/data/fake_persons_repository.dart`). Saat test, override provider dengan fake agar tidak butuh database.
- **Constructor**: repository menerima `AppDatabase` (atau dependency lain lewat constructor), bukan baca dari global/provider di dalam method.
- **Mapping**: repository mengembalikan model domain (mis. `Person`, `Project`), bukan row Drift; map row → model di dalam repository.
- **CRUD signature**: update/delete pakai id sebagai argumen posisi pertama, mis. `updatePerson(int id, { ... })`, `deleteProject(int id)`; jangan pakai named parameter untuk id.
- **Boolean di DB**: kolom integer 0/1 di Drift; di domain pakai `bool`. Saat baca: `row.isLiving != 0`; saat tulis: `Value(isLiving ? 1 : 0)`.
- **Kegagalan**: pakai `RepositoryFailure` (Freezed) dan `Either<RepositoryFailure, T>` (Dartz); jangan throw di repository untuk error bisnis—kembalikan `left(RepositoryFailure.database(...))`.

#### Abstraksi Repository (interface + impl + fake)

Struktur per fitur:

- **Domain**: `features/<feature>/domain/xxx_repository.dart` — hanya abstract interface (method returning `Either`/`Stream`).
- **Data**: `features/<feature>/data/xxx_repository_impl.dart` — implementasi dengan Drift; wrap error ke `left(RepositoryFailure.database(...))`.
- **Test**: `test/features/<feature>/data/fake_xxx_repository.dart` — implementasi in-memory untuk unit/widget test tanpa database.

Di `app_providers.dart` provider mengembalikan tipe **interface** dan meng-instantiate **impl**: `return PersonsRepositoryImpl(db)`. Di test, override provider dengan `FakePersonsRepository()` agar tidak perlu `AppDatabase`.

### Riverpod (Provider)

- **Nama fungsi vs provider**: nama fungsi bebas (mis. `personsStream`); codegen menghasilkan provider dengan suffix `Provider` (mis. `personsStreamProvider`). Hindari nama fungsi yang sudah berakhiran `Provider` agar tidak jadi `personsStreamProviderProvider`.
- **Stream/async yang tergantung project**: jika provider tergantung `currentProjectIdProvider` (bisa null), kembalikan stream/list kosong bila null, mis. `if (projectId == null) return Stream.value([]);`.
- **Family provider**: provider dengan parameter (mis. `personId`) dipanggil sebagai `ref.watch(namaProviderProvider(id))` (nama generated-nya pakai suffix ganda untuk family).

### UI & Presentation

- **Routing**: navigasi ke halaman lain pakai **go_router**: `context.push(AppRoutes.xxx)` atau `context.push(path, extra: data)`. Kembali dengan `context.pop()` / `context.pop(result)`. Path didefinisikan di `AppRoutes` (`lib/core/router/app_router.dart`); jangan hardcode path string.
- **State**: halaman dengan form + akses provider pakai `HookConsumerWidget`; state lokal pakai hooks (`useState`, `useTextEditingController`, `useMemoized`).
- **Dialog**: di dalam dialog yang dibuka dengan `showDialog`, dapatkan theme dari context dialog: `Theme.of(dialogContext).colorScheme.error` (bukan `theme` dari scope luar). Tutup `content: Form(...)` dengan `),` sebelum `actions:` agar `actions` jadi parameter `AlertDialog`, bukan `Form`.
- **Ref vs context**: di widget yang dapat `WidgetRef` (ConsumerWidget, HookConsumerWidget), pakai `ref.read(...)` / `ref.watch(...)` untuk provider; jangan pakai `context.read(...)`.
- **Material widget**: jika membuat wrapper di sekitar widget Material (mis. FilterChip), beri nama lain (mis. `_FilterChipChoice`) agar tidak bentrok dengan kelas Material; gunakan parameter yang sesuai dengan API Flutter yang dipakai (mis. `selected` vs `isSelected` sesuai versi).
- **Warna**: pakai `theme.colorScheme` / `Theme.of(context).colorScheme`; untuk warna khusus (mis. female) pakai `Colors.pink` jika `ColorScheme` tidak menyediakan.
- **FilledButton.icon**: parameter `label` bertipe `Widget`, bukan `String`; pakai `label: const Text('...')`.
- **Nullable ke Widget**: jika nilai bisa null (mis. hasil `_formatYear`), beri fallback sebelum dipakai di `Text`: `_formatYear(...) ?? '—'`.

### Null-safety & Tipe

- **AsyncValue.value**: bisa null (loading/error); sebelum memanggil `.where`/`.map` pada list, lakukan null check dan early return atau fallback.
- **DropdownButtonFormField**: `value` harus salah satu nilai item atau null; `onChanged` menerima `String?` — beri default saat assign ke controller: `value ?? 'U'`.
- **useTextEditingController(text: x)**: jika `x` nullable, pakai `text: x ?? ''` (atau default lain yang masuk akal).

### Enhancement yang Dianjurkan

- **Selesaikan error analyzer dulu**: perbaiki error, lalu warning, lalu info (deprecation, style) bila relevan.
- **Kurangi duplikasi**: jika pola yang sama muncul di beberapa dialog/halaman, pertimbangkan ekstraksi widget atau helper.
- **Perkuat validasi & edge case**: mis. dropdown `value` yang valid, null check pada stream/list, konversi int↔bool untuk kolom “living”.
- **Jalankan codegen setelah ubah Drift/Riverpod**: `dart run build_runner build --delete-conflicting-outputs` setelah mengubah tabel atau definisi provider.

---

## Stack & Library Flutter

Untuk implementasi aplikasi Flutter (`gedhub`), beberapa library digunakan (dan sebagian lagi direncanakan) untuk menjaga arsitektur tetap bersih, testable, dan ekspresif:

- **Riverpod (flutter_riverpod)** – **SUDAH digunakan** sebagai state management & dependency injection utama:
  - `ProviderScope` membungkus `GedhubApp`.
  - Provider inti:
    - `appDatabaseProvider` – menyediakan instance `AppDatabase`.
    - `projectsRepositoryProvider` – menyediakan akses ke repository project.
    - `projectsStreamProvider` – menyediakan stream daftar project GEDCOM.
    - `currentProjectIdProvider` – menyimpan ID project GEDCOM yang saat ini aktif (untuk switching multi‑project).
  - Provider disusun menggunakan **pola anotasi `@riverpod`** dari paket `riverpod_annotation`:
    - Contoh pola definisi:

      ```dart
      @riverpod
      ProjectsRepository projectsRepository(ProjectsRepositoryRef ref) {
        final db = ref.watch(appDatabaseProvider);
        return ProjectsRepositoryImpl(db);  // interface type, impl instance
      }
      ```

    - Codegen (`riverpod_generator` + `build_runner`) akan menghasilkan file `app_providers.g.dart` yang mendefinisikan provider dengan nama `projectsRepositoryProvider`, `projectsStreamProvider`, dst.
    - Dengan pola ini, penamaan provider konsisten dan siap dikembangkan (auto‑disposal, refactor aman, dsb.).
- **flutter_hooks & hooks_riverpod** – **SUDAH digunakan** untuk menggabungkan hooks dengan Riverpod:
  - `HookWidget` dipakai di `_MainShell` (tab index) dan `_LocaleSelector` (state preset locale).
  - `HookConsumerWidget` dipakai di `HomePage`, `_CreateProjectFormContent`, `_EditProjectFormContent`, `SettingsPage`, `DriftTableDataPage`, `SharedPrefsInspectorPage`.
  - `useState`, `useEffect`, `useTextEditingController`, `useMemoized` dipakai untuk state lokal dan lifecycle (controller form di dialog auto-dispose saat dialog ditutup).
- **Drift** – digunakan untuk persistence lokal berbasis SQLite/IndexedDB (via `AppDatabase` dan tabel `Projects`, dengan skema selaras DDL di direktori `supports/`):
  - Menggunakan anotasi Drift:
    - `@DataClassName('ProjectRow')` pada `Projects` untuk mengontrol nama data class yang di‑generate.
    - `@DriftDatabase(tables: [Projects])` pada `AppDatabase` untuk mendefinisikan database utama.
  - File `app_database.dart` menyertakan `part 'app_database.g.dart';` dan membutuhkan codegen (`drift_dev` + `build_runner`) untuk menghasilkan implementasi (`_$AppDatabase`, accessor `projects`, helper seperti `into`/`select`, dsb.).
- **Dartz** – **SUDAH digunakan** untuk tipe `Either<L, R>` di return type repository. Semua method repository yang dapat gagal (getById, create, update, delete) mengembalikan `Future<Either<RepositoryFailure, T>>`; pemanggil memakai `.fold((f) => ... error ..., (t) => ... success ...)` untuk menangani gagal/sukses. Lihat [Abstraksi Repository](#abstraksi-repository-interface--impl--fake) di bawah.
- **Freezed** – **SUDAH digunakan** untuk union type kegagalan: `RepositoryFailure` di `lib/core/domain/repository_failure.dart` (variant `.database(message)`, `.notFound(message)`). Codegen: `repository_failure.freezed.dart`.
- **GoRouter** – **SUDAH digunakan** untuk routing dan navigasi deklaratif. Konfigurasi di `lib/core/router/app_router.dart`; path dan konstanta route di `AppRoutes`. Detail di [Routing (GoRouter)](#routing-gorouter) di bawah.
- **Dio + Retrofit** – direncanakan untuk HTTP client dan deklarasi API berbasis interface (mis. sinkronisasi/backup online di masa depan).

Library yang \"direncanakan\" akan diadopsi secara bertahap sesuai kebutuhan fitur (tidak semuanya harus diaktifkan sekaligus di awal).

### Routing (GoRouter)

Navigasi aplikasi memakai **go_router**. Semua path dan nama route didefinisikan di satu tempat agar konsisten dan bisa deep-link.

- **Konfigurasi**: `lib/core/router/app_router.dart` — `createAppRouter()` mengembalikan `GoRouter`; dipakai di `main.dart` lewat `MaterialApp.router(routerConfig: _goRouter)`.
- **Konstanta path**: class `AppRoutes` di file yang sama mendefinisikan path string (mis. `AppRoutes.peoples`, `AppRoutes.personForm`). **Gunakan konstanta ini** saat memanggil `context.push(...)` / `context.go(...)`; jangan hardcode path string di widget.
- **Shell (tab bar)**: `StatefulShellRoute.indexedStack` dengan 4 branch — Home, Peoples, Tree, Settings. Tab dipilih lewat `StatefulNavigationShell.goBranch(index)`; path per tab: `/home`, `/peoples`, `/tree`, `/settings`. Lokasi awal: `/peoples`. Redirect: `/` atau path kosong → `/peoples`.
- **Route full-screen** (di luar shell, pakai root navigator):
  - **Person form**: `AppRoutes.personForm` (`/person/form`) = tambah orang; `AppRoutes.personEdit` (`/person/edit`) = edit orang. Untuk edit, navigasi dengan `context.push(AppRoutes.personEdit, extra: person)` (object `Person` dikirim lewat `extra`).
  - **Dev Tools**: `AppRoutes.devtools` (`/devtools`) — dibuka lewat long-press di mana saja. Sub-rute: `AppRoutes.devtoolsDrift` (`/devtools/drift`), `AppRoutes.devtoolsDrift` + `/table/:tableName` untuk data tabel, `AppRoutes.devtoolsSharedPrefs` (`/devtools/shared-prefs`).
- **Navigasi dari kode**:
  - Pindah ke halaman penuh: `context.push(AppRoutes.personForm)` atau `context.push(AppRoutes.personEdit, extra: person)`.
  - Kembali (pop): `context.pop()` atau `context.pop(true)` untuk mengembalikan nilai ke pemanggil.
  - Jangan pakai `Navigator.of(context).push(MaterialPageRoute(...))` untuk route yang sudah didefinisikan di router; pakai `context.push(path)` / `context.go(path)`.
- **Dialog**: dialog yang dibuka dengan `showDialog` tetap memakai `context.pop()` (atau `Navigator.of(context).pop()`) untuk menutup dialog; yang di-pop adalah overlay dialog, bukan route GoRouter.

---

## Fitur Utama GEDCOM

### 1. Import GEDCOM

- **Tujuan**: mengimpor data silsilah yang sudah ada dari file `.ged` ke dalam basis data lokal GEDHUB.
- **Spesifikasi awal**:
  - Minimal mendukung **GEDCOM 5.5 / 5.5.1** sebagai target awal.
  - Direncanakan untuk dikembangkan ke **GEDCOM 7.x** di fase selanjutnya.
  - Import dilakukan dari **file lokal** (offline), tanpa ketergantungan server.
- **Perilaku dasar**:
  - Validasi ukuran file (mis. batas awal konservatif, namun dirancang agar bisa skala ke file besar).
  - Validasi struktur dasar GEDCOM (tag penting: `INDI`, `FAM`, `SOUR`, `NOTE`, dsb).
  - Menampilkan ringkasan hasil import: jumlah individu, keluarga, event, dan peringatan jika ada data yang di-skip atau tidak dikenali.

### 2. Export GEDCOM

- **Tujuan**: mengekspor data yang tersimpan di GEDHUB menjadi file `.ged` yang kompatibel dengan aplikasi lain.
- **Spesifikasi awal**:
  - Ekspor **seluruh basis data aktif** menjadi satu file GEDCOM.
  - Menghasilkan struktur yang kompatibel minimal dengan GEDCOM 5.5/5.5.1.
- **Future enhancement** (dicatat di sini sebagai arah pengembangan):
  - Opsi eksport subset:
    - Hanya individu tertentu.
    - Subtree (ancestors/descendants dari seseorang).
  - Opsi kontrol privasi (menyembunyikan data orang yang masih hidup, menyamarkan detail sensitif, dsb).

### 3. Create New GEDCOM

- **Tujuan**: memulai pohon keluarga baru dari nol.
- **Perilaku dasar**:
  - Membuat **project**/database baru yang kosong.
  - Input awal:
    - Nama project (mis. “Keluarga Besar XYZ”).
    - Deskripsi singkat project.
    - Locale/tanggal default (mis. format tanggal, zona waktu).
  - Menyiapkan struktur internal (database lokal) sehingga pengguna dapat langsung menambah orang, keluarga, dan event.
- **Implementasi saat ini**:
  - **Create**: Setelah create berhasil project baru otomatis dipilih; ID project di SharedPreferences divalidasi lewat `getProjectById`; controller form didispose setelah dialog; state/SnackBar dijadwalkan dengan `addPostFrameCallback`.
  - **Edit**: Tiap project di list punya menu (ikon ⋮) → Edit; dialog form sama seperti Create dengan field terisi; simpan memanggil `updateProject(id, ...)`; SnackBar konfirmasi.
  - **Delete**: Menu → Delete; dialog konfirmasi; panggil `deleteProject(id)`; bila project yang dihapus adalah current project, `currentProjectId` di-reset; SnackBar konfirmasi.
  - Unit test: create, getProjectById, watchProjects, **updateProject**, **deleteProject** di `projects_repository_test.dart`. Widget test untuk tab dan dialog Create (alur create di-skip karena build-scope di test env).

---

## Model Data & Penyimpanan

### Prinsip Umum

- **Offline‑first**: seluruh operasi create, read, update, delete dilakukan terhadap storage lokal.
- **Mendukung data besar**:
  - Dirancang untuk **ribuan hingga puluhan ribu individu**.
  - Query yang umum (pencarian orang, navigasi pohon keluarga) harus tetap responsif.
- **Relasi kompleks**:
  - Multi generasi (kakek, buyut, dst).
  - Multiple marriages, adopsi, half‑siblings, dan variasi hubungan keluarga lainnya.

### Strategi Penyimpanan (Storage Strategy)

Untuk implementasi awal pada platform web/desktop berbasis teknologi web (mis. React + Electron/Tauri), penyimpanan diposisikan sebagai berikut:

- **Pilihan utama: IndexedDB dengan wrapper (mis. Dexie.js)**  
  Alasan pemilihan:
  - IndexedDB dirancang untuk **penyimpanan data besar** (hingga skala MB–GB) di sisi browser.
  - Mendukung beberapa object store dengan **index** dan **transaksi**, sehingga cukup untuk memodelkan relasi kompleks (Person, Family, Event, dll) secara efisien.
  - Sangat cocok untuk **offline‑first** karena sepenuhnya lokal dan tidak membutuhkan server.
  - Wrapper seperti **Dexie.js** mempermudah:
    - Definisi skema (versioning).
    - Query yang lebih ekspresif.
    - Transaksi yang aman dan lebih mudah dibaca.

- **Alternatif jangka menengah: SQLite embedded**  
  Dicatat sebagai opsi untuk:
  - Implementasi **native/desktop** di masa depan (mis. app berbasis Tauri, .NET, atau platform lain yang mendukung SQLite embedded).
  - Kebutuhan query relasional yang lebih kompleks (JOIN multi‑tabel, agregasi berat).
  - Migrasi dari IndexedDB dapat direncanakan dengan pemetaan skema yang jelas (`Person`, `Family`, `Event`, `Source`, dll).

### Versioning & Migrasi Database (Drift)

Untuk menjaga kompatibilitas data ketika struktur database berkembang, GEDHUB akan menggunakan mekanisme **versioning dan migrasi** yang disediakan oleh Drift:

- **Schema versioning**
  - `AppDatabase.schemaVersion` menyimpan versi skema saat ini (dimulai dari `1`).
  - Setiap perubahan struktural (tambah kolom/tabel, ubah index) akan menaikkan versi skema (`2`, `3`, dst.) dan didokumentasikan.

- **Migrasi terkontrol**
  - Drift menyediakan hook `MigrationStrategy` dengan `onCreate` dan `onUpgrade` untuk:
    - Membuat seluruh tabel awal ketika instalasi pertama.
    - Menjalankan skrip migrasi ketika pengguna update ke versi aplikasi baru.
  - Source of truth skema:
    - Berkas DDL di direktori `supports/data/` (`projects.ddl.sql`, `persons.ddl.sql`, `families.ddl.sql`, `events.ddl.sql`, `places.ddl.sql`, `sources.ddl.sql`, `contacts.ddl.sql`) digunakan sebagai referensi desain skema.
    - Implementasi aktual migrasi akan disinkronkan dengan DDL tersebut.

- **Prinsip migrasi**
  - **Backward compatible** sejauh mungkin:
    - Menambah kolom/tabel baru dengan default yang aman.
    - Menghindari perubahan destruktif tanpa migrasi eksplisit (drop kolom/tabel tanpa transform data).
  - **Teruji**:
    - Setiap migrasi skema penting akan diiringi test yang mem-verifikasi bahwa:
      - Data lama tetap terbaca dengan benar.
      - Fitur baru bekerja di atas skema yang telah dimigrasikan.

Pendekatan ini memastikan bahwa pengguna dapat terus memperbarui GEDHUB tanpa kehilangan data, meskipun struktur internal database berkembang untuk mendukung fitur-fitur baru.

### Sketsa Entitas Utama (Konseptual)

Deskripsi singkat (bukan skema teknis final):

- **`Person`**
  - Identitas individu.
  - Contoh atribut:
    - `id`
    - `givenName`, `surname`, `nickname`
    - `gender`
    - `birthDate`, `deathDate`
    - `birthPlace`, `deathPlace`
    - `notes` singkat.
  - Mapping GEDCOM: tag `INDI` dan sub‑tag terkait (NAME, BIRT, DEAT, dsb).

- **`Family`**
  - Mewakili unit keluarga (pasangan dan anak‑anak).
  - Contoh atribut:
    - `id`
    - `husbandId`, `wifeId` (atau pasangan 1/pasangan 2, dengan dukungan model keluarga yang lebih fleksibel).
    - `childrenIds[]`
  - Mapping GEDCOM: tag `FAM` dan sub‑tag terkait (HUSB, WIFE, CHIL, MARR, dsb).

- **`Event`**
  - Peristiwa yang terjadi pada `Person` atau `Family` (mis. kelahiran, pernikahan, kematian, pindah tempat).
  - Contoh atribut:
    - `id`
    - `type` (BIRTH, MARRIAGE, DEATH, ...).
    - `date`, `place`
    - `notes`
    - `personId` atau `familyId` sebagai foreign key.
  - Mapping GEDCOM: tag event seperti `BIRT`, `MARR`, `DEAT`, dsb.

- **`Source` & `Citation`** (future enhancement)
  - Menyimpan sumber data (buku, dokumen, arsip, URL offline, dll) dan kaitannya dengan `Person`/`Event`.
  - Mapping GEDCOM: `SOUR`, `PAGE`, `QUAY`, dsb.

- **`Contact`** (kontak per person, multi-provider)
  - Satu person dapat punya banyak kontak (telepon, email, alamat, URL); setiap baris punya **provider** (sumber data).
  - **Provider**: `contact_picker` (kontak dari perangkat), `manual` (input pengguna), `gedcom` (dari import), dll.
  - **Target dasar**: Contact Picker (memilih kontak dari perangkat untuk dikaitkan ke person).
  - Atribut konseptual: `personId`, `provider`, `contactType` (phone, email, address, url, other), `value`, `label` (opsional, mis. Mobile/Home/Work), `providerContactId` (untuk dedup/sync).
  - DDL: `supports/data/contacts.ddl.sql`.

- **`PersonRelation`** (relasi antar person — koneksi yang bisa dilepas-pasang)
  - Satu person dapat punya banyak relasi: **orang tua**, **anak**, **pasangan**, **saudara**. Setiap relasi disimpan sebagai satu baris (personId, relatedPersonId, kind).
  - **Kind**: `parent` (personId = orang tua, relatedPersonId = anak), `spouse`, `sibling`. Relasi bersifat eksplisit: tambah/lepas tidak mengubah data person, hanya koneksi.
  - **Tambah relasi**: bisa **pilih orang yang sudah ada** di project atau **tambah orang baru** lalu hubungkan. UI: section "Relasi" di halaman edit person (form person); tombol "Tambah Relasi" → pilih jenis (Orang tua / Anak / Pasangan / Saudara) → "Pilih orang yang sudah ada" atau "Tambah orang baru lalu hubungkan".
  - **Lepas relasi**: tombol lepas per entri; hanya menghapus baris relasi, person tetap ada di daftar.
  - Tabel Drift: `PersonRelations` (`person_relations`); repository: `PersonRelationsRepository` (interface) + `PersonRelationsRepositoryImpl` (data); provider: `personRelationsRepositoryProvider`, `personRelationDisplaysStreamProvider(personId)`.

Struktur ini dirancang agar:

- Dapat dipetakan dengan jelas ke dan dari struktur GEDCOM (`INDI`, `FAM`, `SOUR`, dll).
- Dapat dioptimalkan dengan index di IndexedDB (mis. index pada `surname`, `givenName` untuk pencarian orang).

---

## Arsitektur Fungsional Offline‑First (High Level)

Secara garis besar, alur kerja aplikasi offline‑first adalah sebagai berikut:

- UI berinteraksi dengan **modul GEDCOM** dan **lapisan storage lokal**.
- Semua operasi (create, update, delete, import, export) hanya menyentuh storage lokal (IndexedDB atau yang setara).
- Pengguna dapat melakukan **backup/restore** melalui:
  - Export GEDCOM.
  - (Future) format lain seperti gedzip/arsip database.

Diagram high‑level:

```mermaid
flowchart TD
  user[User] --> ui["UI GEDHUB"]
  ui --> homeTab[HomeTab]
  ui --> peoplesTab[PeoplesTab]
  ui --> treeTab[TreeTab]
  ui --> settingsTab[SettingsTab]

  ui --> gedcomModule[GedcomModule]
  gedcomModule --> storage[LocalStorageLayer]
  storage --> db[Drift: SQLite/IndexedDB]
```

---

## Struktur Menu / Tab Utama

Aplikasi memiliki 4 menu/tab utama:

1. **Home**
2. **Peoples**
3. **Tree (Family Chart)**
4. **Settings**

### 1. Home

- **Fungsi utama**:
  - **Create New GEDCOM** (membuat project/pohon baru dari nol).
  - **Import GEDCOM** (memasukkan data dari file `.ged` yang sudah ada).
  - **Export GEDCOM** (menyimpan data saat ini ke file `.ged`).
- **Konsep UI**:
  - Layout **kartu/tile** minimalis:
    - Satu kartu untuk masing‑masing aksi utama (Create, Import, Export).
    - Icon sederhana + judul + deskripsi singkat pada tiap kartu.
  - Tombol aksi besar dan jelas, mudah diakses (accessible).
  - Seksi **Projects** di bawah kartu utama:
    - Menampilkan daftar project GEDCOM yang tersimpan.
    - Menggunakan Riverpod (`projectsStreamProvider`) untuk memuat list project secara reaktif.
    - Pengguna dapat memilih **project aktif** (via `currentProjectIdProvider`) sehingga fitur lain (Peoples, Tree) nantinya dapat bekerja per‑project.

### 2. Peoples

- **Fungsi utama**:
  - Menampilkan daftar seluruh individu di database.
  - Menyediakan **search** dan **filter** dasar (mis. berdasarkan nama, marga, tahun lahir).
- **Fitur dasar**:
  - Tabel/list individu:
    - Kolom utama: Nama lengkap, tahun lahir, tahun wafat (jika ada), jumlah relasi keluarga.
  - Aksi:
    - Tambah orang baru.
    - Edit data individu.
    - Hapus individu (dengan konfirmasi dan pengecekan relasi).
    - Navigasi langsung ke tampilan **Tree** untuk individu yang dipilih.
  - **Relasi person** (di halaman edit person):
    - Relasi bersifat **koneksi yang bisa dilepas-pasang**: orang tua, anak, pasangan, saudara.
    - Tambah relasi: pilih jenis (Orang tua / Anak / Pasangan / Saudara) lalu **pilih orang yang sudah ada** di project atau **tambah orang baru** lalu hubungkan.
    - Lepas relasi: tombol lepas per entri; hanya menghapus koneksi, data person tidak berubah.
- **Performa & UX**:
  - Dirancang untuk **data besar**:
    - Menggunakan **pagination** atau **virtual scrolling** agar scrolling tetap halus.
    - Pencarian cepat berbasis index pada `givenName`/`surname`.
  - Fokus pada keterbacaan:
    - Typografi yang jelas, jarak antar baris cukup lapang, icon sederhana.

### 3. Tree (Family Chart)

- **Fungsi utama**:
  - Menampilkan visual **pohon keluarga**:
    - Tampilan ancestor/descendant dari individu terpilih.
    - Mampu berpindah fokus ke individu lain di tree.
- **Fitur dasar**:
  - **Zoom** dan **pan**:
    - Pengguna dapat memperbesar/memperkecil dan menggeser view tree.
  - Node individu:
    - Menampilkan nama dan ringkasan (mis. tahun lahir/wafat).
    - Klik pada node membuka panel detail atau navigasi ke tab Peoples.
  - Level awal:
    - Fokus pada representasi sederhana (tanpa semua fitur lanjutan seperti variasi tipe chart kompleks).
  - Terinspirasi dari interaksi tree di `My Family Tree`, tetapi dengan UI minimalis.

### 4. Settings

- **Status awal**: **placeholder/blank** (belum ada pengaturan fungsional).
- **Rencana isi di masa depan**:
  - Pengaturan lokasi penyimpanan lokal/backup.
  - Pengaturan bahasa/locale dan format tanggal.
  - Preferensi tampilan (tema terang/gelap, ukuran font, dsb).

---

## Dev Tools & Drift Inspector

Untuk membantu proses pengembangan dan debugging, GEDHUB menyediakan halaman **Dev Tools** yang bersifat internal (tidak ditujukan untuk end‑user non‑teknis).

- **Cara akses Dev Tools**
  - Dari aplikasi utama, **long-press (tahan) di mana saja** pada layar.
  - Setelah long-press, aplikasi menampilkan halaman penuh `DevtoolsPage` (Dev Tools).

- **Struktur teknis**
  - Implementasi global gesture:
    - `GedhubApp` membungkus seluruh konten `MaterialApp` dengan `DevtoolsGestureOverlay` melalui properti `builder`.
    - `DevtoolsGestureOverlay` menggunakan `GestureDetector.onLongPress` untuk membuka Dev Tools (navigasi via `navigatorKey`).
  - Halaman Dev Tools:
    - `lib/features/devtools/presentation/devtools_page.dart` berisi `DevtoolsPage` (berbasis `ConsumerWidget`).
    - Menggunakan provider Riverpod (mis. `projectsStreamProvider`, `currentProjectIdProvider`) untuk membaca data dari Drift.

- **Drift Inspector (versi awal)**
  - Menampilkan ringkasan data dari database lokal:
    - Saat ini fokus pada tabel `projects` (daftar semua project GEDCOM yang tersimpan).
    - Menampilkan:
      - Jumlah project.
      - Detail tiap project (id, nama, locale, waktu pembuatan).
      - Indikator project aktif (selaras dengan `currentProjectIdProvider`).
  - Dirancang agar mudah diperluas:
    - Di masa depan dapat menambah panel untuk tabel lain (`persons`, `families`, `events`, dsb.) dan utilitas debug lain (mis. export snapshot DB, konsistensi relasi).


---

## Konsep UI & UX

### Implementasi Tema (shadcn-style)

- Tema aplikasi didefinisikan di **`lib/core/theme/app_theme.dart`**.
- **Palet**: netral ala shadcn (slate/zinc) — background `#FAFAFA`, foreground `#0A0A0A`, border `#E5E5E5`, primary gelap.
- **Komponen**:
  - **Card**: elevation 0, border 1px, radius 12px.
  - **Input**: filled, border halus, radius 8px, focus ring.
  - **Button**: FilledButton/TextButton dengan padding dan radius konsisten.
  - **ListTile**: shape rounded, padding seragam.
  - **AppBar / NavigationBar**: elevation 0, warna netral.
  - **Dialog / SnackBar**: rounded, border halus, floating snackbar.
- Halaman Home memakai `Card` dan `_SectionCard` (container dengan border & radius) agar daftar project tampil konsisten dengan gaya ini.

### Pendekatan Desain

- **Clean, minimalis, modern**:
  - Palet warna sederhana (mode terang default, kontras baik).
  - Banyak white space untuk menjaga fokus.
  - Typografi sederhana dan konsisten.
- Terinspirasi dari:
  - `shadcn/ui`
  - `Radix UI`
  - Komponen dengan:
    - State hover/focus yang jelas.
    - Transisi halus namun subtil (tidak berlebihan).

### Prinsip UX

- **Simplicity first**:
  - Pengguna pemula genealogis dapat langsung:
    - Membuat project baru.
    - Menambah orang.
    - Melihat tree sederhana.
- **Aksi utama selalu jelas**:
  - Home menonjolkan 3 aksi utama (Create, Import, Export).
  - Di tiap tab, CTA (call‑to‑action) utama terbaca jelas.
- **Feedback yang eksplisit**:
  - Saat import/export GEDCOM:
    - Menampilkan progress (jika file besar).
    - Menampilkan ringkasan sukses/gagal.
    - Menampilkan daftar peringatan jika ada data tidak sempurna.
- **Aksesibilitas**:
  - Kontras warna yang baik.
  - Navigasi keyboard.
  - Struktur heading dan landmark yang semantik (untuk screen reader) direncanakan sejak awal.

---

## Prinsip Pengembangan Kode

Pengembangan kode GEDHUB mengikuti prinsip berikut agar basis kode tetap konsisten, mudah dirawat, dan dapat dikembangkan jangka panjang. **AI agent harus mengacu ke [Panduan untuk AI Agent](#panduan-untuk-ai-agent)** untuk konteks pola, konvensi, dan enhancement yang berlaku di project ini.

### Don't Repeat Yourself (DRY)

- **Hindari duplikasi**: logika, tampilan, atau data yang sama tidak ditulis berulang di banyak tempat.
- **Ekstraksi ke unit yang dapat dipakai ulang**: jika suatu blok kode dipakai di lebih dari satu lokasi, pindahkan ke fungsi, extension, atau komponen bersama.
- **Satu sumber kebenaran**: untuk aturan bisnis, konstanta, atau konfigurasi, definisikan di satu tempat dan rujuk dari sana.

### Standar Kode

- **Selalu menulis kode sesuai standar** yang berlaku di project (termasuk style guide Dart/Flutter, konvensi penamaan, dan aturan dari `analysis_options.yaml` / linter).
- **Konsisten** dalam pola yang dipilih (mis. struktur folder feature-based, penggunaan Riverpod/Drift, pola repository); rujuk contoh di `lib/features/projects/`, `lib/features/peoples/`, dan `lib/core/`.
- **Dokumentasi singkat** untuk API publik, use case non-trivial, dan keputusan arsitektur yang penting.
- **Enhance when editing**: saat mengubah file, perbaiki juga hal terkait yang konsisten dengan panduan (null-safety, tipe, reuse) selama tidak mengubah perilaku yang diharapkan.

### Komponen & Fungsi yang Dapat Dipakai Ulang (Shareable)

- **Manfaatkan komponen dan fungsi yang sudah ada** sebelum menulis implementasi baru: cek tema di `lib/core/theme/`, widget UI yang dipakai di feature lain, provider di `app_providers`, repository, dan helper di `core/`.
- **Buat komponen/fungsi shareable** ketika pola yang sama muncul di dua atau lebih tempat: letakkan di `lib/core/` atau modul shared yang sesuai (mis. widget di `lib/core/widgets/` atau per feature jika hanya dipakai di satu feature).
- **Gunakan tema dan `InputDecorationTheme`** untuk styling; hindari hardcode warna, radius, atau padding yang sudah didefinisikan di tema.

### Unit Test Wajib per Fitur

- **Setiap fitur harus memiliki unit test.** Tidak ada fitur baru yang dianggap selesai tanpa test yang mengcover logika inti (domain, repository, atau alur utama UI).
- **Lokasi test**: mengikuti struktur `lib/` — mis. `lib/features/projects/` → `test/features/projects/` untuk unit test repository/domain; widget test bisa di `test/` root atau `test/features/<feature>/` (mis. `home_page_test.dart`).
- **Cakupan minimal per fitur**:
  - **Domain/Repository**: test CRUD, validasi, dan query (dengan database in-memory atau mock).
  - **Provider (jika ada logika non-trivial)**: test state dan side-effect (override dependency bila perlu).
  - **UI (widget test)**: test tampilan utama, tombol/aksi yang mengubah state, dan feedback (snackbar, dialog) bila memungkinkan tanpa ketergantungan berat ke platform.
- **Alat**: `flutter test`; untuk test yang pakai Drift, gunakan `AppDatabase(DatabaseConnection(NativeDatabase.memory(), closeStreamsSynchronously: true))` atau override `appDatabaseProvider` agar tidak ada timer/stream tertinggal.

Dengan menerapkan DRY, standar kode, pemanfaatan komponen shareable, dan **unit test wajib per fitur**, kode tetap rapi, mudah diuji, dan siap untuk penambahan fitur baru.

---

## Rencana Unit Test

Rencana ini memetakan fitur ke jenis test dan file test yang harus ada. Setiap fitur baru wajib menyertakan test sesuai tabel di bawah.

### Prinsip

| Prinsip | Keterangan |
|--------|------------|
| **Satu fitur = satu set test** | Setiap fitur di `lib/features/<nama>/` memiliki padanan test di `test/` (unit dan/atau widget). |
| **Unit test dulu** | Repository, domain, dan helper diuji dengan unit test (tanpa UI). Database pakai in-memory. |
| **Widget test untuk alur kritis** | Halaman/ dialog utama diuji dengan widget test; bila ada masalah build-scope atau platform, test bisa di-skip dengan alasan terdokumentasi. |
| **Mock/override dependency** | SharedPreferences, database, dan provider di-override di test agar deterministik dan tidak bergantung ke lingkungan. |

### Struktur Folder Test

```
test/
├── features/
│   ├── projects/
│   │   └── projects_repository_test.dart   # unit: create, getProjectById, watchProjects, updateProject, deleteProject
│   ├── home/
│   │   └── home_page_test.dart             # widget: welcome/Projects, dialog Create, alur create
│   ├── peoples/
│   │   └── ...                             # unit + widget saat fitur Peoples ada
│   ├── tree/
│   │   └── ...                             # unit + widget saat fitur Tree ada
│   ├── settings/
│   │   └── ...                             # widget bila ada logika UI
│   └── devtools/
│       └── ...                             # widget/unit bila diperlukan
├── core/
│   ├── database/
│   │   └── app_database_test.dart          # optional: skema, migrasi
│   └── app_providers_test.dart             # optional: provider behaviour
└── widget_test.dart                        # smoke: main shell 4 tab saja
```

Setiap fitur punya file test mandiri (mis. `create_project` → unit di `projects_repository_test.dart`, UI create di `home_page_test.dart`). Jangan menumpuk semua test di satu `widget_test.dart`.

### Pemetaan Fitur → Test

| Fitur | Unit test | Widget test | Keterangan |
|-------|-----------|-------------|------------|
| **Projects (CRUD)** | `test/features/projects/projects_repository_test.dart`: createProject, getProjectById, watchProjects, **updateProject**, **deleteProject** dengan DB in-memory | `test/features/home/home_page_test.dart`: welcome/Projects, dialog Create (alur create di-skip) | Create, Edit, Delete project; unit test lengkap untuk repository. |
| **Import GEDCOM** | Parser/validator GEDCOM (saat ada); repository import | Halaman/ dialog import | Ditambah saat fitur diimplementasi. |
| **Export GEDCOM** | Generator/export service (saat ada) | Tombol export, feedback | Ditambah saat fitur diimplementasi. |
| **Peoples** | Repository/domain Person, CRUD | Daftar, form, filter | Ditambah saat fitur diimplementasi. |
| **Tree** | Logic layout/navigasi pohon (bila ada di domain) | Tampilan tree, klik node | Ditambah saat fitur diimplementasi. |
| **Settings** | — | Halaman settings bila ada logika | Opsional. |
| **Dev Tools** | — | Akses long-press, daftar tools, inspector | Opsional; bisa manual. |
| **Core (DB, providers)** | `app_database_test.dart` (skema/migrasi); `app_providers_test.dart` (currentProjectId, persist) | — | Prioritas setelah fitur per feature stabil. |

### Checklist per Fitur Baru

Saat menambah fitur baru:

1. **Buat atau perluas** file test di `test/features/<nama_fitur>/`.
2. **Unit test**: repository/domain (create, read, update, delete, query) dengan in-memory DB atau mock.
3. **Widget test**: minimal satu test untuk tampilan/aksi utama (bila layar/dialog baru).
4. **Jalankan** `flutter test` dan pastikan semua test lulus sebelum merge/PR.
5. **Dokumentasi**: jika suatu test di-skip (mis. karena build-scope di test env), tulis alasan di `skip:` dan tetap uji manual.

---

## Status Implementasi vs Spesifikasi

Dokumen ini mencatat kesesuaian implementasi saat ini dengan persyaratan di atas. Diperbarui seiring perkembangan.

| Aspek | Spesifikasi | Status saat ini |
|-------|-------------|-----------------|
| **Fitur GEDCOM – Create / Edit / Delete** | CRUD project: buat, edit (dialog), hapus (konfirmasi) | ✅ Terpenuhi |
| **Fitur GEDCOM – Import** | Import file .ged, validasi, ringkasan | ❌ Belum (placeholder) |
| **Fitur GEDCOM – Export** | Ekspor basis data aktif ke .ged | ❌ Belum (placeholder) |
| **Tab Home** | Create, Import, Export + daftar project & pilih project aktif | ✅ Create + list project + switch project |
| **Tab Peoples** | Daftar individu, search/filter, tambah/edit/hapus, relasi | ✅ Daftar person, CRUD person, filter chip, CRUD kontak per person, relasi (orang tua, anak, pasangan, saudara) — tambah/lepas; pilih orang ada atau tambah orang baru |
| **Tab Tree** | Visual pohon keluarga, zoom/pan, node klik | ❌ Placeholder |
| **Tab Settings** | Placeholder untuk pengaturan | ✅ Sesuai (placeholder) |
| **Model data – Project** | Tabel project di storage | ✅ Drift tabel `projects` |
| **Model data – Person/Family/Contact/Place/Relation** | Entitas utama untuk silsilah | ✅ Drift tabel `persons`, `families`, `contacts`, `places`, `person_relations`; model domain Person, Contact, PersonRelation |
| **Offline-first** | Semua data utama lokal | ⚠️ Sebagian (project + person + contact; family/event belum terpakai penuh) |
| **UI shadcn-style** | Tema, Card, Input, border, radius | ✅ Tema + komponen konsisten |
| **Dev Tools** | Akses long-press, Drift Inspector, Shared Prefs | ✅ Terpenuhi (long-press, list tools, inspector tabel + row detail) |

**Ringkasan gap:** Import/Export GEDCOM belum diimplementasikan; Tree masih placeholder; storage sudah dipakai untuk project, person, dan contact; tabel family/place ada di Drift namun integrasi penuh (UI/flow) belum.

---

## Roadmap Awal

- **M1 – Skeleton App**
  - Setup project.
  - Implementasi struktur tab (Home, Peoples, Tree, Settings).
  - Tombol/aksi stub untuk Create, Import, Export GEDCOM (belum full logic).

- **M2 – Storage & Model Dasar**
  - Implementasi lapisan storage offline berbasis IndexedDB (mis. Dexie).
  - Definisi model dasar `Person`, `Family`, `Event`.
  - Integrasi create/update/delete sederhana dari UI ke storage.

- **M3 – Peoples List & Detail**
  - Implementasi list individu (tabel/list) dengan search/filter dasar.
  - Form tambah/edit orang yang terhubung ke model dan storage.

- **M4 – Tree View Dasar**
  - Implementasi tampilan tree sederhana (ancestor/descendant).
  - Navigasi antar individu melalui tree.

Roadmap ini bersifat awal dan dapat diperluas seiring kebutuhan baru (mis. dukungan GEDCOM 7, sumber & citasi, statistik keluarga, laporan, dan fitur lanjutan lainnya).

