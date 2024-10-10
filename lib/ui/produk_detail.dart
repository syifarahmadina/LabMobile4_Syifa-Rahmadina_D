import 'package:flutter/material.dart';
import 'package:tokokita/bloc/produk_bloc.dart'; // Tambahan dari modul
import 'package:tokokita/model/produk.dart';
import 'package:tokokita/ui/produk_form.dart';
import 'package:tokokita/ui/produk_page.dart'; // Tambahan dari modul
import 'package:tokokita/widget/warning_dialog.dart'; // Tambahan dari modul

class ProdukDetail extends StatefulWidget {
  Produk? produk;

  ProdukDetail({Key? key, this.produk}) : super(key: key);

  @override
  _ProdukDetailState createState() => _ProdukDetailState();
}

class _ProdukDetailState extends State<ProdukDetail> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.pink[50], // Pink pastel sebagai latar belakang
      appBar: AppBar(
        title: const Text("Detail Produk Syipe"),
        backgroundColor: Colors.pink[300], // Warna AppBar Pink pastel
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Card(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(15.0),
          ),
          color: Colors.blue[50], // Biru pastel untuk card
          elevation: 5,
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  "Kode : ${widget.produk!.kodeProduk}",
                  style: const TextStyle(
                    fontSize: 22.0,
                    fontWeight: FontWeight.bold,
                    color: Colors.blueGrey, // Warna biru abu-abu
                  ),
                ),
                const SizedBox(height: 10),
                Text(
                  "Nama : ${widget.produk!.namaProduk}",
                  style: const TextStyle(
                    fontSize: 20.0,
                    color: Colors.black87,
                  ),
                ),
                const SizedBox(height: 10),
                Text(
                  "Harga : Rp. ${widget.produk!.hargaProduk.toString()}",
                  style: const TextStyle(
                    fontSize: 20.0,
                    color: Colors.black87,
                  ),
                ),
                const SizedBox(height: 20),
                _tombolHapusEdit(),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _tombolHapusEdit() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        // Tombol Edit
        OutlinedButton(
          style: OutlinedButton.styleFrom(
            backgroundColor: Colors.pink[100], // Warna tombol pink pastel
            side: BorderSide(color: Colors.pink[300]!), // Warna border pink lebih gelap
          ),
          child: const Text(
            "EDIT",
            style: TextStyle(color: Colors.pink),
          ),
          onPressed: () {
            Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => ProdukForm(
                      produk: widget.produk!,
                    )));
          },
        ),
        // Tombol Hapus
        OutlinedButton(
          style: OutlinedButton.styleFrom(
            backgroundColor: Colors.blue[100], // Warna tombol biru pastel
            side: BorderSide(color: Colors.blue[300]!), // Border biru lebih gelap
          ),
          child: const Text(
            "DELETE",
            style: TextStyle(color: Colors.blue),
          ),
          onPressed: () => confirmHapus(),
        ),
      ],
    );
  }

  void confirmHapus() {
    AlertDialog alertDialog = AlertDialog(
      backgroundColor: Colors.pink[50], // Background alert pink pastel
      content: const Text(
        "Yakin ingin menghapus data ini?",
        style: TextStyle(fontSize: 18.0),
      ),
      actions: [
        // Tombol hapus
        OutlinedButton(
          style: OutlinedButton.styleFrom(
            side: const BorderSide(color: Colors.red), // Border merah
          ),
          child: const Text(
            "Ya",
            style: TextStyle(color: Colors.red),
          ),
          onPressed: () {
            ProdukBloc.deleteProduk(id: int.parse(widget.produk!.id!)) // Tambahan dari modul
                .then(
                  (value) => {
                Navigator.of(context).push(MaterialPageRoute(
                    builder: (context) => const ProdukPage())) // Tambahan dari modul
              },
              onError: (error) {
                showDialog(
                  context: context,
                  builder: (BuildContext context) => const WarningDialog(
                    description: "Hapus gagal, silahkan coba lagi", // Tambahan dari modul
                  ),
                );
              },
            );
          },
        ),
        // Tombol batal
        OutlinedButton(
          style: OutlinedButton.styleFrom(
            side: const BorderSide(color: Colors.blueGrey), // Border abu-abu
          ),
          child: const Text(
            "Batal",
            style: TextStyle(color: Colors.blueGrey),
          ),
          onPressed: () => Navigator.pop(context),
        ),
      ],
    );

    showDialog(builder: (context) => alertDialog, context: context);
  }
}