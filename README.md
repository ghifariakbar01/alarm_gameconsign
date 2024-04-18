# Accurate

### Ghifari Akbar

Merupakan aplikasi Android dan iOS dengan fitur sebagai berikut:

1. Melihat daftar user
2. Mencari user yang diinginkan
3. Mengurutkan user berdasarkan nama
4. Memfilter user berdasarkan kota
5. Menambahkan user baru

Dengan user experience yang baik dan mudah digunakan bagi pengguna, dengan perhatian terhadap prinsip SOLID dan Clean architecture.

## Cara penggunaan aplikasi

Untuk menjalankan aplikasi lakukan langkah-langkah berikut :

1.  Pastikan emulator sudah berjalan, dan buka terminal / command-line.

2.  Pastikan direktori terminal / command-line berada pada direktori projek. Dengan command :

        cd <nama_projek>

3.  Ambil packages yang terdaftar di pubspec.yaml, dengan command :

        flutter pub get

4.  Jalankan aplikasi dengan command :

        flutter run

## Teknologi yang digunakan

- BloC sebagai state management
- Get_It sebagai dependency injection
- GetX sebagai route navigation
- Dio sebagai networking
- flutter_hooks sebagai state management local (form)

## Kenapa tampilan/interaksi seperti itu

Dalam home, terdapat list dan search bar di atas, beserta fungsi filter dan sorting di sebelah kanan search bar.

#### 1. Melihat daftar user

Dalam home, terdapat list yang berisi tampilan user, dengan nama dan kota di atas karena digunakan dalam filter atau pencarian nama.

#### 2. Mencari user yang diinginkan

Dalam home, terdapat search bar di atas yang mereset list user agar list user yang dicari dalam searchbar dalam keadaan lengkap.

#### 3. Mengurutkan user berdasarkan nama

Dalam home, terdapat icon sorting berdasarkan nama di ujung kanan atas, dengan panah mengarah keatas untuk ascending, dan kebawah untuk descending.

#### 4. Memfilter user berdasarkan kota

Dalam home, terdapat icon filter yang membuka bottom sheet berisi nama-nama kota yang ada dari list user. Dalam membuka bottom sheet, bottom sheet masih dalam keadaan loading karena harus me refresh list user agar list kota yang didapatkan dalam keadaan lengkap / tidak kurang.

#### 5. Menambahkan user baru

Dalam home, terdapat icon add yang mengarah ke halaman insert, dengan validasi form dan toast success jika berhasil. Toast diikuti dengan navigasi kembali ke halaman sebelumnya dan me refresh list pada halaman, yakni list user pada halaman home.
