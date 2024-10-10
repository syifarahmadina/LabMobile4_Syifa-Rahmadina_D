import 'package:flutter/material.dart';
import 'package:tokokita/bloc/logout_bloc.dart';
import 'package:tokokita/bloc/produk_bloc.dart';
import 'package:tokokita/model/produk.dart';
import 'package:tokokita/ui/login_page.dart';
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
                onTap: () async {
                  await LogoutBloc.logout().then((value) => {
                    Navigator.of(context).pushAndRemoveUntil(
                        MaterialPageRoute(builder: (context) => const LoginPage()),
                            (route) => false)
                  });
                },
              ),
            ],
          ),
        ),
      ),
      body: FutureBuilder<List<Produk>>(
        future: ProdukBloc.getProduks(),
        builder: (context, snapshot) {
          // Debug snapshot status dan data
          print('Snapshot connection state: ${snapshot.connectionState}');
          print('Snapshot data: ${snapshot.data}');
          print('Snapshot error: ${snapshot.error}');

          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return const Center(child: Text('No products available'));
          } else {
            return ListProduk(list: snapshot.data);
          }
        },
      ),
    );
  }
}

class ListProduk extends StatelessWidget {
  final List<Produk>? list;

  const ListProduk({Key? key, this.list}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      padding: const EdgeInsets.all(10),
      itemCount: list?.length ?? 0,
      itemBuilder: (context, index) {
        return ItemProduk(produk: list![index]);
      },
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
            builder: (context) => ProdukDetail(produk: produk),
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
            produk.namaProduk ?? 'No Name',
            style: TextStyle(
              fontWeight: FontWeight.bold,
              color: Colors.pink[800],
            ),
          ),
          subtitle: Text(
            produk.hargaProduk != null
                ? 'Rp. ${produk.hargaProduk.toString()}'
                : 'No Price',
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