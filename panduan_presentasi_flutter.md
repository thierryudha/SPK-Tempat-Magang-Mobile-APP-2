# 📱 Panduan Lengkap Arsitektur Flutter App — SPK Pemilihan Tempat Magang (MOORA)
> Dibuat khusus untuk keperluan **presentasi akhir** di hadapan dosen.

---

## 🗂️ Daftar Isi
1. [Gambaran Besar Aplikasi](#1-gambaran-besar-aplikasi)
2. [Arsitektur: Clean Architecture + Feature-First](#2-arsitektur-clean-architecture--feature-first)
3. [Struktur Folder `lib/` — Peta Lengkap](#3-struktur-folder-lib--peta-lengkap)
4. [Folder `core/` — Fondasi Bersama](#4-folder-core--fondasi-bersama)
5. [Folder `features/` — Fitur-Fitur Aplikasi](#5-folder-features--fitur-fitur-aplikasi)
6. [Perbedaan `core/` vs `features/`](#6-perbedaan-core-vs-features)
7. [Tiga Layer di Setiap Fitur (data / domain / presentation)](#7-tiga-layer-di-setiap-fitur)
8. [State Management: Riverpod](#8-state-management-riverpod)
9. [Navigasi: GoRouter](#9-navigasi-gorouter)
10. [HTTP Client: Dio](#10-http-client-dio)
11. [Dependencies Lengkap & Alasannya](#11-dependencies-lengkap--alasannya)
12. [Alur Data End-to-End (Contoh Login)](#12-alur-data-end-to-end-contoh-login)
13. [Alur Login Google + Firebase](#13-alur-login-google--firebase)
14. [Alur Kalkulasi MOORA](#14-alur-kalkulasi-moora)
15. [Alur Dashboard](#15-alur-dashboard)
16. [Cara Aplikasi Berkomunikasi dengan Laravel Backend](#16-cara-aplikasi-berkomunikasi-dengan-laravel-backend)
17. [Autentikasi Token (Bearer Token + Secure Storage)](#17-autentikasi-token-bearer-token--secure-storage)
18. [Fitur AI Chatbot (Gemini)](#18-fitur-ai-chatbot-gemini)
19. [Tips & Kemungkinan Pertanyaan Dosen](#19-tips--kemungkinan-pertanyaan-dosen)

---

## 1. Gambaran Besar Aplikasi

**Nama Proyek:** SPK Pemilihan Tempat Magang — Metode MOORA  
**Tech Stack:**
- **Frontend Mobile:** Flutter (Dart)
- **Backend:** Laravel (REST API)
- **Autentikasi Sosial:** Firebase + Google Sign-In
- **AI Chatbot:** Google Gemini API

**Tujuan Aplikasi:**  
Membantu mahasiswa memilih tempat magang terbaik secara objektif menggunakan metode **MOORA** (*Multi-Objective Optimization on the basis of Ratio Analysis*) — sebuah metode pengambilan keputusan multi-kriteria.

**Fitur Utama:**
| Fitur | Keterangan |
|---|---|
| 🔐 Auth | Login, Register, Lupa Password, Login Google |
| 🏠 Dashboard | Ringkasan aktivitas + hasil kalkulasi terakhir |
| 🏢 Magang | CRUD daftar tempat magang kandidat |
| 📊 MOORA | Setup kriteria → Penilaian → Hasil ranking |
| 👤 Profil | Edit profil, ganti foto, ganti password |
| 🤖 Chatbot | AI assistant berbasis Google Gemini |

---

## 2. Arsitektur: Clean Architecture + Feature-First

Aplikasi ini menggunakan **dua pola arsitektur sekaligus**:

### 🧱 Clean Architecture
Memisahkan kode menjadi **3 lapisan** agar tidak saling ketergantungan langsung:

```
Presentation Layer  ──►  Domain Layer  ──►  Data Layer
(UI, Provider)           (Kontrak/Aturan)    (API, Model)
```

- **Aturan utama:** Lapisan dalam (domain) **tidak boleh tahu** apa yang ada di lapisan luar (data/presentation).
- **Keuntungan:** Mudah diganti/diuji. Misalnya ganti backend dari Laravel ke Firebase cukup ganti Data Layer saja.

### 📦 Feature-First
Kode dikelompokkan berdasarkan **fitur bisnis**, bukan berdasarkan jenis file:

```
❌ Cara lama (layer-first):     ✅ Cara ini (feature-first):
/models/                        /features/auth/
/controllers/                   /features/moora/
/views/                         /features/dashboard/
```

- **Keuntungan:** Satu fitur = satu folder → lebih mudah dicari dan dikembangkan.

---

## 3. Struktur Folder `lib/` — Peta Lengkap

```
lib/
│
├── main.dart                    ← Entry point aplikasi
├── firebase_options.dart        ← Konfigurasi Firebase (auto-generated)
│
├── core/                        ← Kode BERSAMA (dipakai semua fitur)
│   ├── constants/
│   │   ├── api_constants.dart   ← URL endpoint API
│   │   ├── api_secrets.dart     ← API Key rahasia (tidak di-commit ke Git)
│   │   └── app_theme.dart       ← Warna, font, tema global
│   ├── errors/
│   │   └── app_exception.dart   ← Kelas error kustom
│   ├── network/
│   │   └── dio_client.dart      ← HTTP client (singleton + interceptor)
│   ├── router/
│   │   └── app_router.dart      ← Semua rute navigasi
│   ├── storage/
│   │   └── secure_storage_service.dart ← Simpan token secara aman
│   └── utils/
│       └── shared_widgets.dart  ← Widget yang dipakai banyak fitur
│
└── features/                    ← Kode PER FITUR
    ├── auth/                    ← Fitur autentikasi
    ├── dashboard/               ← Fitur dashboard
    ├── internship/              ← Fitur manajemen tempat magang
    ├── moora/                   ← Fitur kalkulasi MOORA
    ├── profile/                 ← Fitur profil pengguna
    └── chat/                    ← Fitur chatbot AI
```

---

## 4. Folder `core/` — Fondasi Bersama

> `core/` adalah **fondasi** — kode di sini dipakai oleh **semua fitur**. Isinya tidak spesifik ke satu fitur tertentu.

### 📄 `core/constants/api_constants.dart`
Menyimpan semua **URL endpoint** API Laravel dalam satu tempat.
```dart
static const String baseUrl = 'http://10.0.2.2:8000/api';
// 10.0.2.2 adalah alamat khusus Android Emulator
// untuk mengakses localhost komputer host

static const String login = '/login';
static const String calculate = '/calculate';
// ...dst
```
**Kenapa dipisah?** Jika URL backend berubah (misal pindah server), cukup ubah di satu file ini.

### 📄 `core/constants/api_secrets.dart`
Menyimpan **API Key rahasia** (Gemini API Key) yang **tidak di-commit ke Git** (ada di `.gitignore`). File `api_secrets.example.dart` adalah template kosong untuk panduan tim.

### 📄 `core/constants/app_theme.dart`
Mendefinisikan **design system** global:
- Kelas `AppColors` → semua warna app (primary `#1D4880`, error, success, dll.)
- Kelas `AppTheme` → konfigurasi `ThemeData` Material 3 (AppBar, Card, Button, Input, BottomNavBar)

### 📄 `core/errors/app_exception.dart`
Hierarki kelas error kustom:
```
AppException (parent)
├── NetworkException    → Timeout, tidak bisa konek
├── UnauthorizedException → Token expired / invalid (401)
├── ValidationException → Data tidak valid dari Laravel (422)
└── ServerException     → Error 500
```
Ini memastikan semua error dari network ditangani secara **konsisten** di seluruh app.

### 📄 `core/network/dio_client.dart`
HTTP Client tunggal (pola **Singleton**). Fitur penting:
- **Auto-inject token:** Setiap request otomatis ditambahkan header `Authorization: Bearer <token>` jika user sudah login.
- **Error handling terpusat:** Semua error HTTP dikonversi ke `AppException` yang sesuai.
- **Timeout:** 15 detik untuk connect dan receive.

### 📄 `core/router/app_router.dart`
Mengelola **semua navigasi** app menggunakan `go_router`. Fitur:
- **Route guard (`_guard`):** Cek apakah user sudah login. Jika belum, redirect ke `/login`.
- **Shell Route:** Membungkus halaman-halaman utama (Dashboard, Magang, MOORA, Profil) dengan `BottomNavigationBar` dan FAB chatbot.
- **Nested routes:** Rute seperti `/internships/:id` mendukung parameter dinamis.

### 📄 `core/storage/secure_storage_service.dart`
Menyimpan **Bearer Token** di penyimpanan terenkripsi perangkat menggunakan `flutter_secure_storage`. Di Android menggunakan `EncryptedSharedPreferences`.
```dart
SecureStorageService.saveToken(token);   // setelah login berhasil
SecureStorageService.getToken();          // diambil oleh DioClient tiap request
SecureStorageService.deleteToken();       // saat logout
SecureStorageService.hasToken();          // digunakan route guard
```

---

## 5. Folder `features/` — Fitur-Fitur Aplikasi

Setiap fitur memiliki struktur internal yang sama:
```
features/<nama_fitur>/
├── data/           ← Implementasi nyata (HTTP, parsing JSON)
│   ├── datasources/
│   ├── models/
│   └── repositories/
├── domain/         ← Kontrak/antarmuka (abstrak)
│   ├── entities/
│   ├── repositories/
│   └── usecases/
└── presentation/   ← Tampilan & logika UI
    ├── providers/
    ├── screens/
    └── widgets/
```

### 🔐 `features/auth/`
| File | Tugas |
|---|---|
| `data/datasources/auth_remote_datasource.dart` | Memanggil API: login, register, googleLogin, forgotPassword, updateProfile, changePassword, logout, getMe |
| `data/models/user_model.dart` | Kelas `UserModel` (id, name, email, photo, role) dengan `fromJson()` |
| `data/repositories/auth_repository.dart` | Jembatan antara datasource dan provider; menyimpan token setelah login |
| `presentation/providers/auth_provider.dart` | `AuthNotifier` — state management user yang sedang login |
| `presentation/screens/splash_screen.dart` | Layar loading awal; cek token → arahkan ke login/dashboard |
| `presentation/screens/login_screen.dart` | Form login + tombol Google Sign-In |
| `presentation/screens/register_screen.dart` | Form registrasi |
| `presentation/screens/forgot_password_screen.dart` | Form kirim email reset password |

### 🏠 `features/dashboard/`
| File | Tugas |
|---|---|
| `data/models/dashboard_models.dart` | Model data dashboard menggunakan **Freezed** (auto-generated, immutable) |
| `data/datasources/dashboard_remote_data_source.dart` | Memanggil `GET /api/dashboard` |
| `data/repositories/dashboard_repository_impl.dart` | Implementasi kontrak repository |
| `domain/repositories/dashboard_repository.dart` | **Kontrak abstrak** (interface) repository |
| `presentation/providers/dashboard_provider.dart` | Provider menggunakan `@riverpod` annotation |
| `presentation/screens/dashboard_screen.dart` | Tampilan dashboard: profil user, statistik, hasil analisis MOORA, aktivitas terbaru |

### 🏢 `features/internship/`
| File | Tugas |
|---|---|
| `data/models/internship_model.dart` | `InternshipModel` + `CategoryModel` |
| `data/datasources/internship_remote_datasource.dart` | CRUD lengkap: GET list, GET by id, POST, PUT, DELETE + GET categories |
| `presentation/providers/internship_provider.dart` | Provider list, detail, categories + `InternshipActionNotifier` untuk CRUD |
| `presentation/screens/internship_list_screen.dart` | Daftar tempat magang dengan opsi hapus & navigasi |
| `presentation/screens/internship_detail_screen.dart` | Detail satu tempat magang |
| `presentation/screens/internship_form_screen.dart` | Form tambah/edit tempat magang |

### 📊 `features/moora/`
| File | Tugas |
|---|---|
| `data/models/moora_models.dart` | `CriteriaModel`, `MooraResultModel`, `CalculateRequestModel`, `NormalizedScoreModel` |
| `data/datasources/moora_remote_datasource.dart` | GET kriteria, GET bobot tersimpan, POST kalkulasi |
| `presentation/providers/moora_provider.dart` | Kumpulan provider: bobot, kriteria aktif, internship terpilih, skor, hasil kalkulasi |
| `presentation/screens/moora_setup_screen.dart` | Langkah 1: pilih kriteria, atur bobot (harus total 100%) |
| `presentation/screens/moora_scoring_screen.dart` | Langkah 2: beri skor setiap internship per kriteria |
| `presentation/screens/moora_result_screen.dart` | Langkah 3: tampilkan ranking hasil MOORA |

### 👤 `features/profile/`
| File | Tugas |
|---|---|
| `presentation/screens/profile_screen.dart` | Tampilan profil: foto, nama, email, menu navigasi |
| `presentation/screens/edit_profile_screen.dart` | Form edit nama, email, upload foto (image_picker) |
| `presentation/screens/change_password_screen.dart` | Form ganti password |

### 🤖 `features/chat/`
| File | Tugas |
|---|---|
| `data/chat_service.dart` | Menginisialisasi model Gemini + mengelola sesi chat (context percakapan dijaga) |
| `presentation/screens/chat_screen.dart` | UI chat bubble — tampilkan percakapan user dengan AI |

---

## 6. Perbedaan `core/` vs `features/`

| Aspek | `core/` | `features/` |
|---|---|---|
| **Tujuan** | Fondasi bersama, infrastruktur | Logika bisnis spesifik fitur |
| **Dipakai oleh** | Semua fitur | Hanya fitur itu sendiri |
| **Contoh isi** | HTTP Client, Router, Theme, Error | Login, MOORA, Dashboard |
| **Boleh import** | Tidak boleh import dari `features/` | Boleh import dari `core/` |
| **Analogi** | Fondasi & kerangka gedung | Ruangan-ruangan di dalam gedung |

> 🔑 **Kunci:** `features/` boleh mengandalkan `core/`, tapi `core/` **tidak boleh** mengandalkan `features/`. Ini menjaga `core/` tetap generik dan dapat dipakai ulang.

---

## 7. Tiga Layer di Setiap Fitur

### 📦 Layer `data/` — "Dunia Nyata"
Berinteraksi langsung dengan dunia luar (server, database, device storage).

- **`datasources/`** → Kelas yang melakukan pemanggilan HTTP secara langsung. Hanya tahu cara memanggil API dan parsing JSON mentah.
- **`models/`** → Representasi data dalam format yang diterima dari API (`fromJson()`). Bisa lebih "kotor" dari entity (ada field teknis JSON).
- **`repositories/`** *(di data layer)* → Implementasi nyata dari kontrak yang didefinisikan di domain. Di sinilah token disimpan setelah login.

### 📜 Layer `domain/` — "Kontrak Bisnis"
Inti aplikasi yang bebas dari detail teknis. Tidak tahu Dio, tidak tahu Flutter, murni Dart.

- **`entities/`** → Objek bisnis murni (seringkali sama dengan model, tapi lebih bersih).
- **`repositories/`** → **Abstract class** (kontrak/interface). Mendefinisikan *apa* yang bisa dilakukan, bukan *bagaimana* caranya.
- **`usecases/`** → Satu aksi bisnis spesifik (misal: `LoginUseCase`, `CalculateMooraUseCase`). *Pada app ini, beberapa fitur tidak mengimplementasikan use case secara terpisah dan langsung menggunakan repository di provider.*

### 🎨 Layer `presentation/` — "Tampilan"
Semua yang dilihat dan diinteraksikan user.

- **`providers/`** → State management (Riverpod). Jembatan antara UI dan logika bisnis. Mengelola state loading, error, dan data.
- **`screens/`** → Widget halaman penuh (satu screen = satu halaman).
- **`widgets/`** → Widget kecil yang dapat digunakan ulang dalam satu fitur.

---

## 8. State Management: Riverpod

Aplikasi menggunakan **Flutter Riverpod v2** untuk state management.

### Kenapa Riverpod?
- **Type-safe:** Error terdeteksi saat compile, bukan runtime.
- **Tidak butuh `BuildContext`:** Provider bisa diakses dari mana saja.
- **Auto-dispose:** Memori dibersihkan otomatis saat tidak dipakai.
- **Testable:** Mudah di-mock untuk unit testing.

### Jenis Provider yang Digunakan

| Provider | Dipakai untuk | Contoh |
|---|---|---|
| `Provider<T>` | Objek yang tidak berubah (dependency injection) | `authRepositoryProvider` |
| `FutureProvider<T>` | Data async sekali fetch | `internshipsProvider`, `criteriasProvider` |
| `FutureProviderFamily<T,A>` | FutureProvider dengan parameter | `internshipDetailProvider(id)` |
| `StateNotifierProvider<N,S>` | State yang bisa berubah secara kompleks | `weightNotifierProvider`, `scoresNotifierProvider` |
| `AsyncNotifierProvider<N,T>` | State async dengan aksi (login, dll.) | `authProvider` |
| `@riverpod` (annotation) | Auto-generate provider (dipakai di dashboard) | `dashboardDataProvider` |

### Cara Kerja di UI
```dart
// Membaca state (rebuild otomatis saat data berubah)
final asyncUser = ref.watch(authProvider);

asyncUser.when(
  loading: () => CircularProgressIndicator(),
  error: (e, _) => Text('Error: $e'),
  data: (user) => Text('Halo, ${user?.name}'),
);
```

### `ref.invalidate()` — Refresh Data
Setelah CRUD, data di-refresh dengan:
```dart
ref.invalidate(internshipsProvider); // Provider akan fetch ulang dari API
```

---

## 9. Navigasi: GoRouter

Aplikasi menggunakan **GoRouter v14** untuk navigasi deklaratif.

### Struktur Rute
```
/splash          → SplashScreen (cek token)
/login           → LoginScreen
/register        → RegisterScreen
/forgot-password → ForgotPasswordScreen

StatefulShellRoute (dengan BottomNavigationBar):
├── /dashboard           → DashboardScreen      (tab 0)
├── /internships         → InternshipListScreen  (tab 1)
│   ├── /create          → InternshipFormScreen
│   ├── /edit/:id        → InternshipFormScreen (edit)
│   └── /:id             → InternshipDetailScreen
├── /moora/setup         → MooraSetupScreen     (tab 2)
└── /profile             → ProfileScreen        (tab 3)
    ├── /edit            → EditProfileScreen
    └── /change-password → ChangePasswordScreen

/moora/scoring   → MooraScoringScreen  (fullscreen, tanpa BottomNav)
/moora/result    → MooraResultScreen   (fullscreen, tanpa BottomNav)
/chat            → ChatScreen          (fullscreen, tanpa BottomNav)
```

### Route Guard (Proteksi Halaman)
```dart
static Future<String?> _guard(BuildContext context, GoRouterState state) async {
  final isPublic = _publicRoutes.contains(state.matchedLocation);
  final hasToken = await SecureStorageService.hasToken();

  if (!hasToken && !isPublic) return '/login';    // Belum login → paksa ke login
  if (hasToken && isPublic)   return '/dashboard'; // Sudah login → skip halaman publik
  return null; // Lanjut normal
}
```

### Data Antar Halaman
Data dikirim antar halaman MOORA via `extra`:
```dart
context.push('/moora/scoring', extra: {'criterias': ..., 'weights': ...});
```

---

## 10. HTTP Client: Dio

**Dio** digunakan sebagai HTTP client karena lebih powerful dari `http` package standar.

### Konfigurasi (di `DioClient`)
```dart
BaseOptions(
  baseUrl: 'http://10.0.2.2:8000/api', // Alias emulator ke localhost
  connectTimeout: Duration(seconds: 15),
  headers: {'Accept': 'application/json'},
)
```

### Interceptor — Otomatisasi Request
Setiap request **otomatis** mendapatkan:
1. Header `Authorization: Bearer <token>` (jika ada token)
2. Error handling terpusat (konversi DioException → AppException)

### Pola Error Handling
```dart
try {
  final response = await _dio.get('/endpoint');
  // proses response
} on DioException catch (e) {
  throw DioClient.extractException(e); // lempar AppException yang tepat
}
```

---

## 11. Dependencies Lengkap & Alasannya

### Dependencies Produksi

| Package | Versi | Fungsi | Alasan Dipilih |
|---|---|---|---|
| `firebase_core` | ^4.0.0 | Inisialisasi Firebase | Diperlukan untuk semua layanan Firebase |
| `firebase_auth` | ^6.0.0 | Autentikasi Firebase | Mengelola sesi Google Sign-In di sisi Firebase |
| `google_sign_in` | ^7.0.0 | OAuth Google | Login dengan akun Google |
| `dio` | ^5.4.3 | HTTP client | Interceptor, FormData, timeout — lebih powerful dari `http` |
| `flutter_riverpod` | ^2.5.1 | State management | Type-safe, scalable, tidak perlu BuildContext |
| `riverpod_annotation` | ^2.3.5 | Anotasi Riverpod | Untuk `@riverpod` annotation (di dashboard) |
| `go_router` | ^14.2.7 | Navigasi deklaratif | Deep linking, route guard, shell route dengan BottomNavBar |
| `freezed_annotation` | ^2.4.1 | Immutable model | Auto-generate `copyWith`, `==`, `hashCode` |
| `json_annotation` | ^4.9.0 | JSON serialization | Anotasi `@JsonKey` untuk mapping field JSON |
| `flutter_secure_storage` | ^9.2.2 | Penyimpanan aman | Token disimpan terenkripsi (EncryptedSharedPreferences) |
| `image_picker` | ^1.2.2 | Ambil foto | Untuk upload foto profil dari galeri/kamera |
| `google_generative_ai` | ^0.4.7 | Gemini API | SDK resmi untuk Google Gemini AI (chatbot) |
| `url_launcher` | ^6.3.1 | Buka URL | Membuka link website tempat magang di browser |
| `intl` | ^0.20.2 | Format tanggal/angka | Lokalisasi format tanggal dan angka |
| `fl_chart` | ^1.2.0 | Grafik | Visualisasi data (chart di dashboard) |
| `cupertino_icons` | ^1.0.8 | Ikon iOS | Set ikon tambahan |

### Dev Dependencies (Hanya untuk Development)

| Package | Fungsi |
|---|---|
| `build_runner` | Menjalankan code generation (`dart run build_runner build`) |
| `freezed` | Generator kode untuk model immutable |
| `json_serializable` | Generator `fromJson`/`toJson` |
| `riverpod_generator` | Generator untuk `@riverpod` annotation |
| `custom_lint` + `riverpod_lint` | Lint rule khusus untuk Riverpod |

---

## 12. Alur Data End-to-End (Contoh Login)

Berikut alur lengkap saat user menekan tombol **"Login"**:

```
User klik tombol Login
        │
        ▼
[LoginScreen] — memanggil:
ref.read(authProvider.notifier).login(email, password)
        │
        ▼
[AuthNotifier.login()] — memanggil:
ref.read(authRepositoryProvider).login(email, password)
        │
        ▼
[AuthRepository.login()] — memanggil:
_dataSource.login(email, password)
        │
        ▼
[AuthRemoteDataSource.login()] — HTTP POST via DioClient:
POST http://10.0.2.2:8000/api/login
Body: { email, password, device_name: "flutter_app" }
        │
        ▼
[DioClient Interceptor] — otomatis tambah header jika ada token
        │
        ▼
[Laravel Backend] — validasi, return { token, user }
        │
        ▼
[AuthRemoteDataSource] — return Map<String, dynamic>
        │
        ▼
[AuthRepository] — extract token → simpan ke SecureStorage
                 — parse user → return UserModel
        │
        ▼
[AuthNotifier] — state = AsyncData(userModel)
        │
        ▼
[GoRouter guard] — deteksi token ada → redirect ke /dashboard
        │
        ▼
[LoginScreen] — ref.listen(authProvider) → navigasi ke dashboard
```

---

## 13. Alur Login Google + Firebase

> Ini adalah bagian yang Anda setup sendiri — penting untuk dijelaskan di presentasi!

```
User klik "Login dengan Google"
        │
        ▼
[AuthNotifier.googleLogin()]
        │
        ▼
[GoogleSignIn.instance.authenticate()]
— Membuka dialog pilih akun Google (SDK Google Sign-In v7)
— GoogleSignIn.instance.initialize() sudah dipanggil di main.dart
  dengan serverClientId dari Google Cloud Console
        │
        ▼
[Firebase Auth] — verifikasi identitas Google
— Firebase project dikonfigurasi di firebase.json + firebase_options.dart
        │
        ▼
Berhasil → dapat { googleUser.email, .displayName, .id }
        │
        ▼
[AuthRepository.googleLogin()] — HTTP POST:
POST /api/google-login
Body: { email, name, google_id, device_name }
        │
        ▼
[Laravel Backend] — cek/buat user berdasarkan google_id
                 — return { token, user }
        │
        ▼
Token disimpan → user diarahkan ke Dashboard
```

**Komponen yang Anda Setup:**
1. **Firebase Console** → Buat project, aktifkan Google Sign-In provider
2. **`google-services.json`** → Download dari Firebase Console, taruh di `android/app/`
3. **`firebase_options.dart`** → Auto-generated oleh `flutterfire configure`
4. **`firebase.json`** → Konfigurasi Firebase CLI
5. **`main.dart`** → Inisialisasi Firebase + `GoogleSignIn.instance.initialize()` dengan `serverClientId`

---

## 14. Alur Kalkulasi MOORA

MOORA di app ini adalah proses **3 langkah**:

### Langkah 1: Setup (`MooraSetupScreen`)
```
Fetch kriteria dari API (GET /api/criterias)
    → Tampilkan list kriteria (nama, tipe: benefit/cost, skala penilaian)
    → User aktifkan/nonaktifkan kriteria (activeCriteriaProvider)
    → User atur bobot tiap kriteria (weightNotifierProvider)
    → Validasi: total bobot HARUS = 100%
    → User pilih tempat magang yang akan dibandingkan (selectedInternshipsProvider)
    → Navigasi ke Scoring dengan kirim data via GoRouter extra
```

### Langkah 2: Penilaian (`MooraScoringScreen`)
```
Tampilkan tabel: baris = internship, kolom = kriteria
    → User beri nilai 1-5 untuk setiap sel (scoresNotifierProvider)
    → Nilai menggunakan skala dari CriteriaScale (ada deskripsinya)
    → Validasi: semua sel harus diisi
    → Klik "Hitung" → kirim data ke backend
```

### Langkah 3: Hasil (`MooraResultScreen`)
```
POST /api/calculate
Body: {
  criteria: { "1": true, "2": true },
  weights:   { "1": 40.0, "2": 60.0 },
  internships: [1, 2, 3],
  scores: {
    "1": { "1": 4, "2": 3 },  // internship_id: { criteria_id: score }
    ...
  }
}
    → Laravel hitung MOORA:
       1. Normalisasi dengan akar kuadrat
       2. Kalikan dengan bobot
       3. Sum benefit - Sum cost = Optimization Value
       4. Ranking berdasarkan Optimization Value tertinggi
    → Return ranked list
    → Tampilkan di MooraResultScreen (ranking, nama, nilai optimasi)
```

**Provider yang Terlibat di MOORA:**
| Provider | Tipe | Tugas |
|---|---|---|
| `criteriasProvider` | `FutureProvider` | Ambil daftar kriteria dari API |
| `savedWeightsProvider` | `FutureProvider` | Ambil bobot tersimpan dari API |
| `weightNotifierProvider` | `StateNotifier` | State bobot yang sedang diatur user |
| `activeCriteriaProvider` | `StateNotifier` | Kriteria mana yang aktif (dicentang) |
| `selectedInternshipsProvider` | `StateNotifier` | Daftar magang yang dipilih |
| `scoresNotifierProvider` | `StateNotifier` | Nilai per internship per kriteria |
| `mooraCalculationProvider` | `StateNotifier` | State hasil kalkulasi (loading/error/data) |

---

## 15. Alur Dashboard

```
DashboardScreen dibuka
        │
        ▼
ref.watch(dashboardDataProvider)  ← FutureProvider (@riverpod)
        │
        ▼
dashboardRepositoryProvider.getDashboardData()
        │
        ▼
DashboardRepositoryImpl.getDashboardData()
        │
        ▼
DashboardRemoteDataSource.getDashboardData()
GET /api/dashboard  (dengan Bearer Token otomatis dari Dio interceptor)
        │
        ▼
Response JSON diparse dengan Freezed (DashboardResponseModel.fromJson)
        │
        ▼
DashboardScreen render:
- Kartu profil user (nama, email, foto)
- Statistik (jumlah magang saya, total perusahaan global, jumlah sektor)
- Analisis Personal (hasil kalkulasi terakhir + top recommendation)
- Top 5 Perusahaan terbaik hasil MOORA
- Aktivitas terbaru (sesi kalkulasi)
```

**Mengapa Dashboard menggunakan Freezed?**
Model dashboard lebih kompleks (banyak nested object), sehingga Freezed digunakan untuk:
- Auto-generate `fromJson` yang aman
- Immutable data → tidak ada mutasi tak sengaja
- `copyWith` untuk update partial

---

## 16. Cara Aplikasi Berkomunikasi dengan Laravel Backend

### Protokol Komunikasi
```
Flutter App ──HTTP/REST──► Laravel API
            ◄──JSON──────
```

### Format Request
- **Method:** GET, POST, PUT, DELETE
- **Header:** `Accept: application/json` + `Authorization: Bearer <token>`
- **Body:** JSON (`data: {...}`) atau FormData (untuk upload file)

### Format Response Laravel
```json
{
  "message": "Berhasil",
  "data": { ... }  ← diambil oleh datasource
}
```

### Endpoint yang Digunakan

| Method | Endpoint | Fitur |
|---|---|---|
| POST | `/api/login` | Login email |
| POST | `/api/google-login` | Login Google |
| POST | `/api/register` | Registrasi |
| POST | `/api/forgot-password` | Lupa password |
| POST | `/api/logout` | Logout |
| GET | `/api/me` | Data user aktif |
| POST | `/api/profile/update` | Update profil |
| POST | `/api/profile/change-password` | Ganti password |
| GET | `/api/internships` | Daftar magang |
| GET | `/api/internships/:id` | Detail magang |
| POST | `/api/internships` | Tambah magang |
| PUT | `/api/internships/:id` | Edit magang |
| DELETE | `/api/internships/:id` | Hapus magang |
| GET | `/api/categories` | Daftar kategori |
| GET | `/api/criterias` | Daftar kriteria MOORA |
| GET | `/api/weights` | Bobot tersimpan |
| POST | `/api/calculate` | Kalkulasi MOORA |
| GET | `/api/dashboard` | Data dashboard |

---

## 17. Autentikasi Token (Bearer Token + Secure Storage)

Aplikasi menggunakan **Laravel Sanctum** (token-based auth):

```
1. Login berhasil → Laravel return token (string acak)
2. Flutter simpan token di EncryptedSharedPreferences (SecureStorage)
3. Setiap request ke API → DioClient otomatis tambah header:
   Authorization: Bearer eyJ0eXAiOiJKV1QiLCJhbGci...
4. Laravel validasi token → return data / 401 Unauthorized
5. Logout → token dihapus dari backend + SecureStorage
```

**Kenapa `flutter_secure_storage`?**
- Token auth adalah data sensitif — TIDAK boleh disimpan di `SharedPreferences` biasa (tidak terenkripsi, bisa dibaca dengan root)
- `flutter_secure_storage` menggunakan Android Keystore (hardware-backed encryption)

---

## 18. Fitur AI Chatbot (Gemini)

`ChatService` menggunakan **Google Gemini API** dengan konteks percakapan:

```dart
_model = GenerativeModel(
  model: 'gemini-3.5-flash',
  apiKey: ApiConstants.geminiApiKey,  // dari api_secrets.dart (aman, tidak di Git)
  systemInstruction: Content.system('Kamu adalah asisten SPK Magang...'),
);
_chat = _model.startChat(); // sesi chat — menyimpan konteks percakapan
```

**Fitur Kunci:**
- **System instruction:** Chatbot dikonfigurasi untuk hanya membahas topik aplikasi SPK Magang
- **Chat session:** `startChat()` menjaga konteks percakapan (bot ingat pesan sebelumnya)
- **API Key aman:** Disimpan di `api_secrets.dart` yang ada di `.gitignore`
- **Chatbot bisa diakses dari semua halaman** via FAB (floating action button) di `_AppShell`

---

## 19. Tips & Kemungkinan Pertanyaan Dosen

### ❓ "Apa itu metode MOORA?"
**MOORA** *(Multi-Objective Optimization on the basis of Ratio Analysis)* adalah metode pengambilan keputusan multi-kriteria. Langkah-langkahnya:
1. **Normalisasi** nilai dengan rumus akar kuadrat (x_ij / √Σx²_ij)
2. **Pembobotan** nilai yang sudah dinormalisasi × bobot kriteria
3. **Optimasi:** nilai benefit dijumlah, nilai cost dikurangi
4. **Hasil:** Optimization Value = Σ(benefit) - Σ(cost) → semakin tinggi semakin baik

### ❓ "Kenapa menggunakan Flutter bukan React Native / native Android?"
- **Cross-platform:** Satu codebase untuk Android & iOS
- **Performance:** Dikompilasi ke kode native (bukan interpreted)
- **Widget system:** Kontrol penuh atas UI
- **Ekosistem Google:** Selaras dengan Firebase dan Gemini API

### ❓ "Apa perbedaan Provider dan Notifier di Riverpod?"
- **Provider** (FutureProvider, dll.) → Data yang di-fetch dan di-cache, bersifat reaktif
- **StateNotifier** → State yang bisa diubah secara aktif dari luar (via method)
- **AsyncNotifier** → Kombinasi keduanya — state async yang punya aksi (seperti `AuthNotifier`)

### ❓ "Kenapa token tidak disimpan di SharedPreferences?"
SharedPreferences tidak terenkripsi → data bisa dibaca jika device di-root. `flutter_secure_storage` menggunakan Android Keystore (enkripsi hardware) sehingga jauh lebih aman untuk menyimpan data sensitif seperti token autentikasi.

### ❓ "Bagaimana cara Google Sign-In bekerja di sini?"
1. Flutter memanggil `GoogleSignIn.instance.authenticate()` → membuka popup Google
2. User pilih akun Google → Firebase memverifikasi
3. Flutter mendapat profil Google (email, nama, Google ID)
4. Data ini dikirim ke Laravel backend via `POST /api/google-login`
5. Laravel membuat/menemukan user berdasarkan `google_id` → return token Sanctum
6. Token disimpan di SecureStorage → user login

### ❓ "Apa fungsi `build_runner`?"
`build_runner` adalah tool code generation. Dijalankan dengan:
```bash
dart run build_runner build
```
Menghasilkan file `*.g.dart` (JSON serializer) dan `*.freezed.dart` (immutable model) secara otomatis dari anotasi di kode.

### ❓ "Mengapa ada file `.freezed.dart` dan `.g.dart`?"
- `.g.dart` → Generated oleh `json_serializable`: berisi `fromJson`/`toJson`
- `.freezed.dart` → Generated oleh `freezed`: berisi `copyWith`, `==`, `hashCode`, pattern matching
- File-file ini **tidak boleh diedit manual** — selalu di-generate ulang oleh `build_runner`

### ❓ "Bagaimana app tahu user sudah login atau belum saat dibuka?"
1. App dibuka → `SplashScreen` ditampilkan
2. `AuthNotifier.build()` dipanggil → coba `GET /api/me` dengan token yang ada
3. Jika berhasil → user sudah login → redirect ke `/dashboard`
4. Jika gagal (401 / tidak ada token) → redirect ke `/login`
5. **Selain itu**, GoRouter `_guard` juga dicek setiap navigasi

### ❓ "Kenapa `10.0.2.2` digunakan sebagai base URL?"
Di Android Emulator, `localhost` merujuk ke emulator itu sendiri (bukan komputer host). `10.0.2.2` adalah alias khusus Android Emulator yang mengarah ke `localhost` komputer tempat emulator berjalan.

### ❓ "Mengapa menggunakan GoRouter bukan Navigator biasa?"
- **Deklaratif:** Rute didefinisikan di satu tempat
- **Deep linking support:** URL-based navigation
- **Route guard:** Mudah implementasi auth protection
- **Shell route:** Mendukung persistent BottomNavigationBar antar tab

---

## 📋 Ringkasan Cepat untuk Presentasi

```
main.dart
  └─ Init Firebase + GoogleSignIn → ProviderScope → MyApp → AppRouter

core/
  ├─ constants/ → URL, API Key, Theme
  ├─ errors/    → Error types
  ├─ network/   → Dio singleton + interceptor (auto token + error)
  ├─ router/    → GoRouter + route guard
  ├─ storage/   → EncryptedSharedPreferences (token)
  └─ utils/     → Shared widgets

features/<fitur>/
  ├─ data/
  │   ├─ datasources/ → Panggil HTTP langsung
  │   ├─ models/      → Parse JSON (fromJson)
  │   └─ repositories/→ Gabungkan datasource + business logic
  ├─ domain/
  │   └─ repositories/→ Abstract class (kontrak)
  └─ presentation/
      ├─ providers/   → State management (Riverpod)
      ├─ screens/     → Halaman UI
      └─ widgets/     → Komponen kecil

Alur Request:
Screen → Provider (Notifier) → Repository → DataSource → DioClient → Laravel API
```

---

*Dokumen ini dibuat berdasarkan analisis kode aktual dari proyek. Semoga presentasi berjalan lancar! 🎉*
