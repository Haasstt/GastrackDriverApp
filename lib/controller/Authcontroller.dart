// ignore_for_file: depend_on_referenced_packages, file_names

import 'package:flutter/material.dart';
import 'package:gastrack_driver/provider/AuthProvider.dart';
import 'package:get/get.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:sp_util/sp_util.dart';

class LoginController extends GetxController {
  TextEditingController txtEmail = TextEditingController();
  TextEditingController txtPass = TextEditingController();
  bool obscureText = true;

  void auth() {
    // String id = "1";
    // String emailPaten = "kurir@gmail.com";

    String email = txtEmail.text;
    String pass = txtPass.text;

    if (email.isEmpty || pass.isEmpty) {
      Get.snackbar(
        "Login Failed",
        "Please input field!",
        backgroundColor: const Color.fromARGB(90, 255, 17, 0),
        colorText: Colors.white,
      );
    } else {
      // if (email == emailPaten) {
      //   SpUtil.putString('email', email);
      //   SpUtil.putString('id', id);
      //   SpUtil.putBool('kurir', true);
      //   Get.offAllNamed('/home');
      // }
        EasyLoading.show();
        var data = {
          "email": email,
          "password": pass,
        };
        LoginProvider().auth(data).then((value) {
          print(value.body);
          if (value.statusCode == 200) {
            var data = value.body['datauser'];
            var token = value.body['token'];
            Get.snackbar(
              "Successs",
              "Login Berhasil",
              backgroundColor: Colors.green,
              colorText: Colors.white,
            );

            SpUtil.putInt('id', data['id_sopir']);
            SpUtil.putString('token', token);
            SpUtil.putString('nama_user', data['nama']);
            SpUtil.putBool('kurir', true);
            Get.offAllNamed('/home');
          } else if (value.statusCode == 422) { 
            Get.snackbar(
              "Login gagal",
              value.body['message'],
              backgroundColor: Colors.red,
              colorText: Colors.white,
            );
          } else if (value.hasError == true) {
            Get.snackbar(
              "Server Not Responding",
              'Gagal menghubungka ke server',
              colorText: Colors.white,
            );
          }
          EasyLoading.dismiss();
        });
    }
  }
}

class LogoutController extends GetxController {
  void logout() {
    // SpUtil.clear();
    // Get.offAllNamed('/cover');
    EasyLoading.show();
    var data = {
      "token": SpUtil.getString('token')!,
    };
    LogoutProvider().logout(data).then((value) {
      print(value.statusCode);
      if (value.statusCode == 200) {
        SpUtil.clear();
        Get.offAllNamed('/cover');
      }
      EasyLoading.dismiss();
    });
  }
}
