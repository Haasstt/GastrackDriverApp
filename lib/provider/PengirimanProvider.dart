// ignore_for_file: file_names, depend_on_referenced_packages

import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:flutter_easyloading/flutter_easyloading.dart';

import 'Base_provider.dart';
import 'package:get/get.dart';

class PengirimanProvider extends BaseProvider {
  Future<Response> getDatapengiriman(id) async {
    return get('$Url/pengiriman/$id', headers: header);
  }
  Future<Response> getDatadetailpengiriman(id) async {
    return get('$Url/detailpengiriman/$id', headers: header);
  }

  Future<void> ubahisiGasProvider(PlatformFile file, String kapasitasGasMasuk, id) async {
    var request =
        http.MultipartRequest('POST', Uri.parse('$Url/update_gas_masuk/$id'));

    header.forEach((key, value) {
      request.headers[key] = value;
    });

    request.fields['kapasitas_gas_masuk'] = kapasitasGasMasuk;

    // Tambahkan gambar ke request
    request.files.add(http.MultipartFile(
      'bukti_gas_masuk', 
      http.ByteStream.fromBytes(
          file.bytes as List<int>), 
      file.size, // Ukuran file
      filename: file.name, // Nama file
    ));

    try {
      EasyLoading.show();
      var response = await request.send();

      if (response.statusCode == 200) {
        EasyLoading.dismiss();
        Get.snackbar(
          "Berhasil",
          "Bukti pengisian gas berhasil diunggah",
          colorText: Colors.white,
          backgroundColor: Colors.green,
        );
        Get.offAllNamed('/home');
      }  else {
        Get.snackbar(
          "Bukti pengisian gas gagal diunggah, coba lagi nanti!",
          response.statusCode as String,
          colorText: Colors.white,
          backgroundColor: Colors.red.withOpacity(0.50),
        );
        EasyLoading.dismiss();
      }
    } catch (e) {
      Get.snackbar(
        "Bukti pembayaran gagal diunggah",
        "Terjadi kesalahan: $e",
        colorText: Colors.white,
        backgroundColor: const Color.fromARGB(255, 202, 171, 169).withOpacity(0.50),
      );
      EasyLoading.dismiss();
    }
  }

  Future<void> gasKeluarProvider(PlatformFile file, String kapasitasGasMasuk, id) async {
    var request =
        http.MultipartRequest('POST', Uri.parse('$Url/update_gas_keluar/$id'));

    header.forEach((key, value) {
      request.headers[key] = value;
    });

    request.fields['kapasitas_gas_keluar'] = kapasitasGasMasuk;

    // Tambahkan gambar ke request
    request.files.add(http.MultipartFile(
      'bukti_gas_keluar', 
      http.ByteStream.fromBytes(
          file.bytes as List<int>), 
      file.size, // Ukuran file
      filename: file.name, // Nama file
    ));

    try {
      EasyLoading.show();
      var response = await request.send();

      if (response.statusCode == 200) {
        EasyLoading.dismiss();
        Get.snackbar(
          "Berhasil",
          "Bukti pengisian gas berhasil diunggah",
          colorText: Colors.white,
          backgroundColor: Colors.green,
        );
        Get.offAllNamed('/home');
      }  else {
        Get.snackbar(
          "Bukti pengisian gas gagal diunggah, coba lagi nanti!",
          response.statusCode as String,
          colorText: Colors.white,
          backgroundColor: Colors.red.withOpacity(0.50),
        );
        EasyLoading.dismiss();
      }
    } catch (e) {
      Get.snackbar(
        "Bukti pembayaran gagal diunggah",
        "Terjadi kesalahan: $e",
        colorText: Colors.white,
        backgroundColor: const Color.fromARGB(255, 202, 171, 169).withOpacity(0.50),
      );
      EasyLoading.dismiss();
    }
  }
}


