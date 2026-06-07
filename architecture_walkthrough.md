# Panduan Arsitektur Flutter App (Clean Architecture + Riverpod)

Aplikasi Flutter ini dibangun menggunakan pendekatan **Feature-First Clean Architecture** dan **Riverpod** sebagai manajemen state (state management). Arsitektur ini sangat populer di industri karena membuat kode menjadi rapi, mudah dites (testable), dan mudah dikembangkan (scalable).

Berikut adalah penjelasan lengkap yang bisa Anda gunakan untuk presentasi:

---

## 1. Pembagian Folder Utama: `core` vs `features`

Struktur utama aplikasi berada di dalam folder `lib/`, yang terbagi menjadi dua bagian penting: `core` dan `features`.

### 📁 `lib/core/` (Pondasi Aplikasi)
Folder ini berisi kode-kode yang bersifat **global** dan digunakan oleh banyak fitur lain di seluruh aplikasi.
*   **`constants/`**: Berisi nilai-nilai tetap seperti warna tema, ukuran, dan URL endpoint API Laravel Anda.
*   **`errors/`**: Tempat mendefinisikan jenis-jenis error (misalnya `Failure` atau `Exception`) agar penanganan error konsisten.
*   **`network/`**: Konfigurasi `Dio` (HTTP Client) untuk melakukan koneksi ke backend Laravel (seperti setting interceptor untuk menambahkan token).
*   **`router/`**: Konfigurasi `GoRouter` untuk mengatur navigasi pindah antar halaman (screen) di aplikasi.
*   **`storage/`**: Konfigurasi penyimpanan lokal (seperti `flutter_secure_storage`) untuk menyimpan token login.
*   **`utils/`**: Fungsi-fungsi bantuan (helper) kecil yang bisa dipakai di mana saja.

### 📁 `lib/features/` (Modul Fitur)
Alih-alih mengelompokkan file berdasarkan tipenya (seperti mengumpulkan semua UI di satu tempat), aplikasi ini **mengelompokkan file berdasarkan fiturnya**.
Setiap folder di dalam `features` mewakili satu modul utuh. Di aplikasi Anda ada fitur: `auth` (Login/Register), `chat`, `internship` (Tempat Magang), `moora` (Perhitungan SPK), dan `profile`.

---

## 2. Struktur Clean Architecture di Dalam Setiap Fitur

Jika Anda membuka salah satu fitur (misalnya `lib/features/auth`), Anda akan menemukan 3 folder utama: `data`, `domain`, dan `presentation`. Ini adalah inti dari Clean Architecture.

### 🗄️ A. Folder `data/` (Berhubungan dengan Sumber Data)
Tugas folder ini adalah **mengambil dan mengirim data** ke luar aplikasi (misal: ke API Laravel atau Firebase).
*   **`datasources/`**: Kode yang benar-benar melakukan pemanggilan internet atau database lokal. (Contoh: `AuthRemoteDataSource` yang memanggil API login di Laravel menggunakan Dio).
*   **`models/`**: Struktur data (blueprint) yang memetakan respon JSON dari API Laravel menjadi object Dart. Biasanya menggunakan `Freezed` dan `JsonSerializable`.
*   **`repositories/`**: Implementasi dari antarmuka (interface) yang ada di domain. Tempat di mana kita memutuskan apakah harus mengambil data dari internet atau dari database lokal.

### 🧠 B. Folder `domain/` (Inti Bisnis / Aturan Aplikasi)
Tugas folder ini adalah menyimpan **aturan bisnis**. Folder ini *tidak boleh tahu* dari mana data berasal (entah dari Laravel atau Firebase), ia hanya tahu bentuk data yang sudah matang.
*   **`entities/`**: Objek Dart murni yang digunakan di dalam aplikasi (UI). Bedanya dengan `models`, entity adalah versi bersih dari data, tidak peduli dengan format JSON.
*   **`repositories/`**: Berisi antarmuka (interface/contract) saja. Hanya mendefinisikan fungsi (misal: `login()`, `getInternships()`) tanpa isi kodenya.
*   **`usecases/`**: (Opsional) Berisi satu tugas spesifik. Misalnya `LoginUseCase`, yang tugasnya hanya satu: melakukan login.

### 📱 C. Folder `presentation/` (Antarmuka Pengguna / UI)
Tugas folder ini adalah **menampilkan data ke layar** dan menerima input dari pengguna (klik, ketikan).
*   **`screens/`**: Halaman utuh yang menempati satu layar penuh (misal: `InternshipListScreen`).
*   **`widgets/`**: Potongan-potongan UI kecil yang bisa dipakai berulang (misal: `CustomTextField`, `InternshipCard`).
*   **`providers/`**: Ini adalah tempat **Riverpod** berada. Menghubungkan antara UI dan Domain. Provider menyimpan *state* (misalnya: status loading, data sukses, atau error) dan memberitahu layar untuk memperbarui tampilannya jika data berubah.

---

## 3. Dependencies (Library/Package) yang Digunakan

Aplikasi ini menggunakan beberapa package pihak ketiga yang sangat powerful. Berikut daftarnya berdasarkan file `pubspec.yaml` Anda:

1.  **`flutter_riverpod` & `riverpod_annotation`**: Digunakan untuk **State Management** dan **Dependency Injection**. Ini adalah otak yang menghubungkan data API dengan UI Anda secara reaktif (UI otomatis berubah jika data berubah).
2.  **`dio`**: **HTTP Client**. Ini adalah alat yang digunakan aplikasi Flutter Anda untuk "berbicara" (Request GET/POST) dengan **Backend Laravel** Anda.
3.  **`go_router`**: Untuk **Navigasi/Routing**. Mengatur perpindahan antar layar dengan aman dan mendukung deep-linking.
4.  **`freezed_annotation` & `json_annotation`**: Digunakan untuk **Data Serialization/Pemodelan**. Secara otomatis mengubah data JSON dari Laravel menjadi objek Dart yang aman dari error, dan membuat objek tersebut *immutable* (tidak bisa diubah sembarangan).
5.  **`flutter_secure_storage`**: Untuk **Keamanan Penyimpanan Lokal**. Digunakan untuk menyimpan token autentikasi (seperti Bearer Token dari API Laravel) agar tidak mudah dicuri orang.
6.  **`firebase_core`, `firebase_auth`, `google_sign_in`**: Digunakan khusus untuk fitur **Login with Google**.
7.  **`google_generative_ai`**: SDK dari Google untuk mengintegrasikan **AI Gemini** (kemungkinan digunakan pada fitur `chat` di aplikasi Anda).

---

## Ringkasan Alur Kerja (Workflow) untuk Presentasi
Jika dosen/penguji bertanya **"Bagaimana cara data dari Laravel bisa tampil di layar?"**, Anda bisa menjawab dengan alur ini:

1.  **Presentation (Layar)** memanggil fungsi di dalam **Provider (Riverpod)**.
2.  **Provider** meminta data dari **Repository** (di folder Domain/Data).
3.  **Repository** menyuruh **DataSource** untuk mengambil data.
4.  **DataSource** menggunakan **Dio** untuk menembak endpoint API **Laravel**.
5.  Laravel mengembalikan JSON.
6.  **DataSource** mengubah JSON tersebut menjadi **Model** dan mengembalikannya ke Repository.
7.  **Repository** mengubah Model menjadi **Entity** dan memberikannya ke Provider.
8.  **Provider** memperbarui statusnya menjadi "Sukses", dan **Layar** otomatis menampilkan data tersebut.
