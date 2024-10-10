# Project Toko Kita 
Nama  : Syifa Rahmadina
NIM   : H1D021094


## siapapunn asprak yang meriksa ini aku mau minta maaf banget ngumpulinnya telat karena aku ada sesuatu yang harus di kerjakan dan tidak dapat ditinggalkan dan sangat mendadak, jadi aku baru ngumpulin sekarang, maaf ya...


## Tampilan UI Project Toko Kita

## 1. Proses Login
   
a. Screenshot Form dan Isi Form

FORM LOGIN


![image](https://github.com/user-attachments/assets/43bf7577-5663-480a-8504-28382800f319)


ISI FORM LOGIN


![image](https://github.com/user-attachments/assets/ab2f8bcd-4772-4750-89bc-240e6bd52d82)


b. Pop-Up Berhasil Login dengan Langsung Masuk ke dalam Page Produk 


![image](https://github.com/user-attachments/assets/27380c62-bda5-490d-9f2d-d8e418d9a901)


Kode untuk login berhasil atau tidak:

 LoginBloc.login(
      email: _emailTextboxController.text,
      password: _passwordTextboxController.text,
    ).then((value) async {
      if (value.code == 200) {
        await UserInfo().setToken(value.token.toString());
        await UserInfo().setUserID(int.parse(value.userID.toString()));
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => const ProdukPage()),
        );
      } else {
        showDialog(
          context: context,
          barrierDismissible: false,
          builder: (BuildContext context) => const WarningDialog(
            description: "Login gagal, silahkan coba lagi",
          ),
        );
      }
    }).catchError((error) {
      print(error);
      showDialog(
        context: context,
        barrierDismissible: false,
        builder: (BuildContext context) => const WarningDialog(
          description: "Login gagal, silahkan coba lagi",
        ),
      );
    }).whenComplete(() {
      setState(() {
        _isLoading = false;
      });
    });
  }


Untuk penjelasan proses:

Proses login dimulai dengan mengambil email dan password dari input pengguna. Lalu data dikirimkan ke API, dan respons diperiksa. Jika login berhasil, token dan user ID disimpan, lalu navigasi dilakukan ke halaman produk. Jika login gagal, dialog peringatan ditampilkan. Jika terjadi kesalahan (seperti masalah jaringan), ditangani dengan menampilkan pesan error. Setelah proses login selesai, status loading diatur menjadi false untuk memperbarui tampilan UI.


## 2. Proses Tambah Data Produk 


a. SS Form Tambah Produk 


![image](https://github.com/user-attachments/assets/c32c0caa-e74d-460e-9d95-aa6dded10dc2)


b. Code Tambah Produk dan Penjelasan

Kode Tambah Produk di folder ui

bool _isLoading = false;
String judul = "Tambah Produk";
String tombolSubmit = "SIMPAN";

final _kodeProdukTextboxController = TextEditingController();
final _namaProdukTextboxController = TextEditingController();
final _hargaProdukTextboxController = TextEditingController();

Penjelasan:

1. Variabel _isLoading
   
Ini adalah variabel untuk menyimpan status apakah aplikasi sedang "sibuk" atau tidak. Bayangkan ada sebuah tombol "Simpan" di form yang kamu buat. Saat tombol itu ditekan, mungkin aplikasi perlu waktu sebentar untuk menyimpan data ke server. Selama proses itu berlangsung, kita set _isLoading menjadi true supaya aplikasi bisa menampilkan sesuatu seperti loading spinner, sehingga pengguna tahu kalau sedang ada proses berjalan. Begitu prosesnya selesai, kita kembalikan ke false, jadi loading spinner-nya hilang.

2. Variabel judul
   
judul ini dipakai buat menentukan apa yang tertulis di bagian atas halaman form kamu. Secara default, dia ditulis "Tambah Produk", karena awalnya memang form ini buat menambah produk baru.

3. Variabel tombolSubmit
   
Ini adalah teks yang muncul di tombol yang dipakai untuk mengirimkan data. Awalnya, tulisannya "SIMPAN" karena memang buat menyimpan produk baru.

4. TextEditingController
_kodeProdukTextboxController: Dipakai buat menangkap apa yang pengguna tulis di kolom kode produk.
_namaProdukTextboxController:  Dipakai buat menangkap apa yang pengguna tulis di kolom nama produk.
_hargaProdukTextboxController:  Dipakai buat menangkap apa yang pengguna tulis di kolom harga produk.


c. SS Pengisian Form Tambah Produk 


![image](https://github.com/user-attachments/assets/982f5619-c07f-472e-8475-a1616d86f810)


d. SS Pop-up Gagal 


![image](https://github.com/user-attachments/assets/20b4b8a5-8cbd-40d8-b871-5bd70c488226)


e. Hasil di Flutter

![image](https://github.com/user-attachments/assets/d705ff02-319a-42a6-bb8c-7ebf99da7c72)

sebenarnya masuk tapi ada kesalahan dalam penampilan datanya dan aku gatau salahnya dimana



## 3. Proses Ubah Produk

a. SS Form Ubah Produk

![image](https://github.com/user-attachments/assets/d5277663-4071-419b-83e2-2a41b861d568)

b. SS Form sudah di Ubah Produknya

![image](https://github.com/user-attachments/assets/7385a42c-a722-4ac8-ae28-090b1bd790ed)

c. Hasil Klik Button Ubah

![image](https://github.com/user-attachments/assets/5ca75200-1c4b-4d05-b66e-83a5ffce4f3e)

hasilnya gagal tapi di flutter berhasil masuk database

![image](https://github.com/user-attachments/assets/7d677f46-4da3-4c38-a520-b537c4c196c7)

d. Kode Untuk Ubah Produk 


void isUpdate() {
    if (widget.produk != null) {
      setState(() {
        judul = "UBAH PRODUK";
        tombolSubmit = "UBAH";
        _kodeProdukTextboxController.text = widget.produk!.kodeProduk!;
        _namaProdukTextboxController.text = widget.produk!.namaProduk!;
        _hargaProdukTextboxController.text =
            widget.produk!.hargaProduk.toString();
      });
    }
  }

Penjelasan:

1. void isUpdate(): Fungsi ini tidak mengembalikan nilai apa pun, hanya menjalankan beberapa aksi jika kondisi terpenuhi.

2. if (widget.produk != null): Ini adalah pengecekan kondisi. Jika properti widget.produk tidak kosong (artinya ada data produk yang diterima), maka akan menjalankan kode di dalam blok if.

3. setState(() { ... }): Fungsi ini digunakan untuk memberi tahu framework bahwa ada perubahan pada tampilan (state) sehingga tampilan di layar harus diperbarui. Ini penting dalam aplikasi yang berbasis Flutter.

4. Di dalam setState, beberapa hal diubah:

4.1 judul = "UBAH PRODUK": Ini mengubah variabel judul menjadi "UBAH PRODUK", menandakan bahwa user sedang dalam mode mengubah produk yang sudah ada, bukan menambah produk baru.

4.2 tombolSubmit = "UBAH": Tombol untuk submit diubah dari mungkin "SIMPAN" atau "TAMBAH" menjadi "UBAH", supaya sesuai dengan konteks pengubahan produk.

4.3 _kodeProdukTextboxController.text = widget.produk!.kodeProduk!: Mengisi kotak teks untuk kode produk dengan nilai kode produk yang sudah ada (diambil dari widget.produk).

4.4 _namaProdukTextboxController.text = widget.produk!.namaProduk!: Mengisi kotak teks untuk nama produk dengan nilai nama produk yang sudah ada.

4.5 _hargaProdukTextboxController.text = widget.produk!.hargaProduk.toString(): Mengisi kotak teks untuk harga produk dengan nilai harga produk yang sudah ada, diubah dulu ke bentuk string (karena harga mungkin berupa angka).




## 4. List Produk

a. SS Tampilan List Produk

![image](https://github.com/user-attachments/assets/2894accc-81da-412f-8aca-5500f2432975)


## 5. Hapus Produk

a. SS Hapus Produk 

1. Lihat Tampilan List dan Pilih Produk yang akan di hapus

   ![image](https://github.com/user-attachments/assets/6c4806fc-1683-493d-9474-d9b75ee73884)

  
2. Pilih produk

   ![image](https://github.com/user-attachments/assets/23ec72a2-b840-4af8-8bf5-46109fca929e)

3. Klik Tombol Delete
   
4. Pop Up Delete Data

   ![image](https://github.com/user-attachments/assets/e66926ac-454d-4e82-ac0c-9a8d361df639)

5. Data Terhapus di halaman List Produk

6. Penjelasan Kode Confirm Hapus

1. void confirmHapus(): Ini adalah sebuah fungsi tanpa nilai kembalian (`void`). Fungsinya untuk memicu dialog konfirmasi penghapusan data.

2. AlertDialog alertDialog = AlertDialog(...)**: 
   - Membuat sebuah objek `AlertDialog`, yaitu jendela pop-up kecil yang muncul di tengah layar.
   - Properti `AlertDialog` diisi sebagai berikut:
   - backgroundColor: Colors.pink[50]**: Mengatur warna latar belakang dialog menjadi pink pastel (lembut), menggunakan kode warna `Colors.pink` dengan transparansi yang lebih terang.
   - content: Text(...): Bagian `content` digunakan untuk menampilkan teks "Yakin ingin menghapus data ini?" di dalam dialog, dengan ukuran font sebesar `18.0`.

3. actions: [ ... ]: `actions` berisi daftar tombol yang ditampilkan di bagian bawah dialog. Ada satu tombol di sini:
   - OutlinedButton(...): Tombol ini dirancang dengan garis tepi (`outline border`) berwarna merah.
     - style: OutlinedButton.styleFrom(...)**: Mengatur gaya tombol:
     - side: BorderSide(color: Colors.red)**: Mengatur garis tepi tombol menjadi merah.
     - child: Text("Ya", style: TextStyle(color: Colors.red))**: Tulisan "Ya" di dalam tombol, dengan warna teks merah. Ini adalah tombol yang akan diklik jika pengguna ingin melanjutkan penghapusan data.
   
4. onPressed: () { ... }**: Aksi yang dijalankan saat tombol "Ya" ditekan.
   - ProdukBloc.deleteProduk(...): Memanggil fungsi `deleteProduk` dari `ProdukBloc` untuk menghapus data produk berdasarkan `id`. `id` diambil dari `widget.produk!.id`, dan dikonversi ke integer dengan `int.parse(...)`.
   
5. .then(...): Setelah proses penghapusan berhasil, maka:
   - **Navigator.of(context).push(...)**: Mengarahkan (navigate) pengguna ke halaman `ProdukPage` menggunakan `Navigator.push`. `ProdukPage` mungkin adalah halaman utama atau daftar produk, yang akan diperbarui setelah penghapusan selesai.
   
6. onError: (error) { ... }**: Jika terjadi kesalahan selama proses penghapusan, maka akan muncul dialog peringatan:
   - **showDialog(...)**: Menampilkan `WarningDialog` dengan pesan "Hapus gagal, silahkan coba lagi".


7. Penjelasan Kode HapusProduk di Produk_bloc.dart
 // Fungsi untuk menghapus produk dari API
  static Future<bool> deleteProduk({required int id}) async {
    try {
      String apiUrl = ApiUrl.deleteProduk(id);
      var response = await Api().delete(apiUrl);
      var jsonObj = json.decode(response.body);

      
      // Log respons untuk debug
      print('Delete product response: $jsonObj');

      // Cek apakah status respons adalah true
      if (jsonObj.containsKey('status') && jsonObj['status'] == true) {
        return true;
      } else {
        throw Exception('Failed to delete product');
      }
    } catch (e) {
      print('Error deleting product: $e');
      return false;
    }
  }
}

Fungsi deleteProduk ini dipakai buat menghapus produk lewat API. Caranya adalah dengan mengirim permintaan DELETE ke server menggunakan ID produk yang mau dihapus. Kalau berhasil, fungsi ini bakal mengembalikan true, kalau gagal, bakal kasih false.

Berikut langkah-langkahnya:

Pertama, Ambil URL: Fungsi ini bikin URL penghapusan produk berdasarkan ID produk. Kedua, Kirim permintaan DELETE: Mengirim permintaan ke server untuk menghapus produk, dan menunggu respons dari API. Ketiga, Cek respons: Kalau respons dari server ada kunci status dan nilainya true, artinya penghapusan berhasil dan akan mengembalikan true. Keempat, Tangani kesalahan: Kalau ada masalah (misal koneksi gagal atau responsnya buruk), fungsi ini bakal menangkap error, mencetaknya di konsol, dan mengembalikan false.

