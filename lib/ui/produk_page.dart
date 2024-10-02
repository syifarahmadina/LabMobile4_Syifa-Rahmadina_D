import 'package:flutter/material.dart';
import 'package:tokokita/model/produk.dart';
import 'package:tokokita/ui/produk_detail.dart';
import 'package:tokokita/ui/produk_form.dart';

class ProdukPage extends StatefulWidget {
  const ProdukPage({Key? key}) : super(key: key);

  @override
  _ProdukPageState createState() => _ProdukPageState();
}

class _ProdukPageState extends State<ProdukPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.pink[50],
      appBar: AppBar(
        title: const Text(
          'List Produk Syipe',
          style: TextStyle(color: Colors.white),
        ),
        backgroundColor: Colors.pink[200],
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 20.0),
            child: GestureDetector(
              child: const Icon(Icons.add, size: 26.0, color: Colors.white),
              onTap: () async {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => ProdukForm()));
              },
            ),
          ),
        ],
      ),
      drawer: Drawer(
        child: Container(
          color: Colors.blue[50],
          child: ListView(
            children: [
              ListTile(
                title: const Text('Logout', style: TextStyle(color: Colors.black54)),
                trailing: const Icon(Icons.logout, color: Colors.black54),
                onTap: () async {},
              ),
            ],
          ),
        ),
      ),
      body: ListView(
        padding: const EdgeInsets.all(10),
        children: [
          ItemProduk(
              produk: Produk(
                  id: 1,
                  kodeProduk: 'A001',
                  namaProduk: 'Kamera',
                  hargaProduk: 5000000)),
          ItemProduk(
              produk: Produk(
                  id: 2,
                  kodeProduk: 'A002',
                  namaProduk: 'Kulkas',
                  hargaProduk: 2500000)),
          ItemProduk(
              produk: Produk(
                  id: 3,
                  kodeProduk: 'A003',
                  namaProduk: 'Mesin Cuci',
                  hargaProduk: 2000000)),
        ],
      ),
    );
  }
}

class ItemProduk extends StatelessWidget {
  final Produk produk;

  const ItemProduk({Key? key, required this.produk}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => ProdukDetail(
              produk: produk,
            ),
          ),
        );
      },
      child: Card(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(15),
        ),
        elevation: 4,
        shadowColor: Colors.blue[100],
        color: Colors.pink[100],
        child: ListTile(
          contentPadding: const EdgeInsets.all(15),
          title: Text(
            produk.namaProduk!,
            style: TextStyle(
              fontWeight: FontWeight.bold,
              color: Colors.pink[800],
            ),
          ),
          subtitle: Text(
            'Rp. ${produk.hargaProduk.toString()}',
            style: TextStyle(
              color: Colors.blue[700],
              fontWeight: FontWeight.w600,
            ),
          ),
          trailing: const Icon(Icons.arrow_forward_ios, color: Colors.blueAccent),
        ),
      ),
    );
  }
}
