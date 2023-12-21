// ignore_for_file: non_constant_identifier_names, depend_on_referenced_packages

import 'package:flutter/material.dart';
import 'package:gastrack_driver/provider/PengirimanProvider.dart';
import 'package:get/get.dart';
import 'package:file_picker/file_picker.dart';

class PengirimanController extends GetxController {
  PlatformFile? photoprofile;
  TextEditingController txtGasMasuk = TextEditingController();
  TextEditingController txtGasKeluar = TextEditingController();

  void Input_Gas_Masuk(id) {
    String id_user = id.toString();
    String gas_masuk = txtGasMasuk.text.trim().toString();
    
    PengirimanProvider().ubahisiGasProvider(photoprofile!, gas_masuk, id_user);
  }

  void Input_Gas_Keluar(id) {
    String id_user = id.toString();
    String gas_keluar = txtGasKeluar.text.trim().toString();
    
    PengirimanProvider().gasKeluarProvider(photoprofile!, gas_keluar, id_user);
  }
}

