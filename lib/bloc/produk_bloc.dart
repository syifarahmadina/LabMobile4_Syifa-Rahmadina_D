import 'dart:convert';
import 'package:tokokita/helpers/api.dart';
import 'package:tokokita/helpers/api_url.dart';
import 'package:tokokita/model/produk.dart';

class ProdukBloc {
  // Fungsi untuk mengambil list produk dari API
  static Future<List<Produk>> getProduks() async {
    try {
      String apiUrl = ApiUrl.listProduk;
      var response = await Api().get(apiUrl);

      // Log untuk debug
      print('Response: $response');

      // Pastikan response tidak null dan memiliki status key dan bernilai true
      if (response != null && response['status'] == true) {
        List<dynamic> listProduk = response['data'];

        // Konversi list dynamic ke list Produk
        List<Produk> produks = listProduk.map((data) => Produk.fromJson(data)).toList();

        // Log produk yang berhasil diambil
        print('List produk: $produks');
        return produks;
      } else {
        throw Exception('Failed to load products or status is false');
      }
    } catch (e) {
      print('Error fetching products: $e');
      return [];
    }
  }

  // Fungsi untuk menambahkan produk baru ke API
  static Future<bool> addProduk({required Produk produk}) async {
    try {
      String apiUrl = ApiUrl.createProduk;
      var body = jsonEncode({
        "kode_produk": produk.kodeProduk,
        "nama_produk": produk.namaProduk,
        "harga": produk.hargaProduk,
      });

      var response = await Api().post(apiUrl, body);
      var jsonObj = json.decode(response.body);

      // Log respons untuk debug
      print('Add product response: $jsonObj');

      // Cek apakah status respons adalah true
      if (jsonObj.containsKey('status') && jsonObj['status'] == true) {
        return true;
      } else {
        throw Exception('Failed to save product');
      }
    } catch (e) {
      print('Error adding product: $e');
      return false;
    }
  }

  // Fungsi untuk memperbarui produk yang ada di API
  static Future<bool> updateProduk({required Produk produk}) async {
    try {
      String apiUrl = ApiUrl.updateProduk(int.parse(produk.id!));
      var body = jsonEncode({
        "kode_produk": produk.kodeProduk,
        "nama_produk": produk.namaProduk,
        "harga": produk.hargaProduk,
      });

      var response = await Api().put(apiUrl, body);
      var jsonObj = json.decode(response.body);

      // Log respons untuk debug
      print('Update product response: $jsonObj');

      // Cek apakah status respons adalah true
      if (jsonObj.containsKey('status') && jsonObj['status'] == true) {
        return true;
      } else {
        throw Exception('Failed to update product');
      }
    } catch (e) {
      print('Error updating product: $e');
      return false;
    }
  }

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