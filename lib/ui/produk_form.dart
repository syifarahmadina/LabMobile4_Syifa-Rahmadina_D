import 'package:flutter/material.dart';
import 'package:tokokita/model/produk.dart';
import 'package:tokokita/bloc/produk_bloc.dart';
import 'package:tokokita/ui/produk_page.dart';
import 'package:tokokita/widget/warning_dialog.dart';

class ProdukForm extends StatefulWidget {
  final Produk? produk;

  ProdukForm({Key? key, this.produk}) : super(key: key);

  @override
  _ProdukFormState createState() => _ProdukFormState();
}

class _ProdukFormState extends State<ProdukForm> {
  final _formKey = GlobalKey<FormState>();
  bool _isLoading = false;
  String judul = "Tambah Produk";
  String tombolSubmit = "SIMPAN";

  final _kodeProdukTextboxController = TextEditingController();
  final _namaProdukTextboxController = TextEditingController();
  final _hargaProdukTextboxController = TextEditingController();

  @override
  void initState() {
    super.initState();
    isUpdate();
  }

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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blue[50],
      appBar: AppBar(
        title: Text(judul),
        backgroundColor: Colors.pink[200],
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Form(
            key: _formKey,
            child: Column(
              children: [
                _kodeProdukTextField(),
                const SizedBox(height: 10),
                _namaProdukTextField(),
                const SizedBox(height: 10),
                _hargaProdukTextField(),
                const SizedBox(height: 20),
                _isLoading ? CircularProgressIndicator() : _buttonSubmit(),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _kodeProdukTextField() {
    return TextFormField(
      decoration: InputDecoration(
        labelText: "Kode Produk",
        filled: true,
        fillColor: Colors.white,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
        ),
      ),
      controller: _kodeProdukTextboxController,
      validator: (value) {
        if (value!.isEmpty) {
          return 'Kode Produk harus diisi';
        }
        return null;
      },
    );
  }

  Widget _namaProdukTextField() {
    return TextFormField(
      decoration: InputDecoration(
        labelText: "Nama Produk",
        filled: true,
        fillColor: Colors.white,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
        ),
      ),
      controller: _namaProdukTextboxController,
      validator: (value) {
        if (value!.isEmpty) {
          return 'Nama Produk harus diisi';
        }
        return null;
      },
    );
  }

  Widget _hargaProdukTextField() {
    return TextFormField(
      decoration: InputDecoration(
        labelText: "Harga",
        filled: true,
        fillColor: Colors.white,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
        ),
      ),
      keyboardType: TextInputType.number,
      controller: _hargaProdukTextboxController,
      validator: (value) {
        if (value!.isEmpty) {
          return "Harga harus diisi";
        }
        return null;
      },
    );
  }

  Widget _buttonSubmit() {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        backgroundColor: Colors.pink[300],
        padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 16),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
        ),
      ),
      child: Text(tombolSubmit),
      onPressed: () {
        if (_formKey.currentState!.validate()) {
          setState(() {
            _isLoading = true;
          });

          if (widget.produk != null) {
            ubah();
          } else {
            simpan();
          }
        }
      },
    );
  }

  void simpan() {
    Produk createProduk = Produk(
      id: null,
      kodeProduk: _kodeProdukTextboxController.text,
      namaProduk: _namaProdukTextboxController.text,
      hargaProduk: int.parse(_hargaProdukTextboxController.text),
    );

    ProdukBloc.addProduk(produk: createProduk).then((value) {
      if (value) {
        Navigator.of(context).pushReplacement(
          MaterialPageRoute(builder: (context) => ProdukPage()),
        );
      } else {
        _showWarningDialog("Simpan gagal, silahkan coba lagi");
      }
    }).catchError((error) {
      _showWarningDialog("Simpan gagal, silahkan coba lagi: $error");
    }).whenComplete(() {
      setState(() {
        _isLoading = false;
      });
    });
  }

  void ubah() {
    Produk updateProduk = Produk(
      id: widget.produk!.id,
      kodeProduk: _kodeProdukTextboxController.text,
      namaProduk: _namaProdukTextboxController.text,
      hargaProduk: int.parse(_hargaProdukTextboxController.text),
    );

    ProdukBloc.updateProduk(produk: updateProduk).then((value) {
      if (value) {
        Navigator.of(context).pushReplacement(
          MaterialPageRoute(builder: (context) => ProdukPage()),
        );
      } else {
        _showWarningDialog("Ubah gagal, silahkan coba lagi");
      }
    }).catchError((error) {
      _showWarningDialog("Ubah gagal, silahkan coba lagi: $error");
    }).whenComplete(() {
      setState(() {
        _isLoading = false;
      });
    });
  }

  void _showWarningDialog(String message) {
    showDialog(
      context: context,
      builder: (context) => WarningDialog(description: message),
    );
  }
}