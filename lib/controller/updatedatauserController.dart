// ignore_for_file: non_constant_identifier_names, depend_on_referenced_packages, file_names, avoid_print

import 'package:flutter/material.dart';
import 'package:gastrack_driver/controller/Authcontroller.dart';
import 'package:gastrack_driver/loading.dart';
import 'package:gastrack_driver/provider/UserProvider.dart';
import 'package:get/get.dart';
// import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:sp_util/sp_util.dart';

class UpdateDataUserController extends GetxController {
  var id = SpUtil.getInt('id')!;
  TextEditingController txtUsername = TextEditingController();
  TextEditingController txtEmail = TextEditingController();
  TextEditingController txtnotelp = TextEditingController();
  TextEditingController txtLastPass = TextEditingController();
  TextEditingController txtNewPass = TextEditingController();
  TextEditingController txtConfirmNewPass = TextEditingController();

  void ChangeName(context) {
    customLoading(context);
    String name = txtUsername.text;

    var data = {
      "name": name,
    };
    UserProvider().updateUsernameuser(id, data).then((value) {
      var pesan = value.body['message'];
      if (value.statusCode == 200) {
        Get.snackbar(
          "Successs",
          pesan,
          backgroundColor: Colors.green.withOpacity(0.85),
          colorText: Colors.white,
        );
        Get.offAllNamed('/home');
      } else if (value.statusCode == 422) {
        Navigator.pop(context);
        Get.snackbar(
          "Failed",
          pesan,
          backgroundColor: Colors.red.withOpacity(0.50),
          colorText: Colors.white,
        );
      } else if (value.hasError == true) {
        Navigator.pop(context);
        Get.snackbar(
          "Server Not Responding",
          'Gagal menghubungka ke server',
          colorText: Colors.white,
        );
      }
    });
  }

  void ChangeEmail(context) {
    String email = txtEmail.text;

    var data = {
      "email": email,
    };
    UserProvider().updateEmailuser(id, data).then((value) {
      if (value.statusCode == 200) {
        Get.snackbar(
          "Successs",
          "Email berhasil diubah, lakukan login ulang dengan email baru anda",
          backgroundColor: Colors.green.withOpacity(0.85),
          colorText: Colors.white,
        );
        LogoutController().logout(context);
      } else if (value.hasError == true) {
        Get.snackbar(
          "Server Not Responding",
          'Gagal menghubungka ke server',
          colorText: Colors.white,
        );
      }
    });
  }

  void ChangeTelp(context) {
    customLoading(context);
    String telp = "0${txtnotelp.text}";

    var data = {
      "no_hp": telp,
    };
    UserProvider().updateNoTelpuser(id, data).then((value) {
      var pesan = value.body['message'];
      if (value.statusCode == 200) {
        Get.snackbar(
          "Successs",
          pesan,
          backgroundColor: Colors.green.withOpacity(0.85),
          colorText: Colors.white,
        );
        Get.offAllNamed('/home');
      } else if (value.statusCode == 422) {
        Navigator.pop(context);
        Get.snackbar(
          "Failed",
          pesan,
          backgroundColor: Colors.red.withOpacity(0.50),
          colorText: Colors.white,
        );
      } else if (value.hasError == true) {
        Navigator.pop(context);
        Get.snackbar(
          "Server Not Responding",
          'Gagal menghubungka ke server',
          colorText: Colors.white,
        );
      }
    });
  }

  void ChangePass(context) {
    customLoading(context);
    String PassLama = txtLastPass.text;
    String passBaru = txtNewPass.text;
    String KonfirmasiPass = txtConfirmNewPass.text;

    var data = {
      "old_password": PassLama,
      "new_password": passBaru,
      "new_password_confirmation": KonfirmasiPass,
    };
    UserProvider().updatePassworduser(id, data).then((value) {
      var pesan = value.body['message'];
      if (value.statusCode == 200) {
        Get.snackbar(
          "Successs",
          pesan,
          backgroundColor: Colors.green.withOpacity(0.85),
          colorText: Colors.white,
        );
        Get.offAllNamed('/home');
      } else if (value.statusCode == 422) {
        Navigator.pop(context);
        Get.snackbar(
          "Failed",
          pesan,
          backgroundColor: Colors.red.withOpacity(0.50),
          colorText: Colors.white,
        );
      } else if (value.hasError == true) {
        Navigator.pop(context);
        Get.snackbar(
          "Server Not Responding",
          'Gagal menghubungka ke server',
          colorText: Colors.white,
        );
      }
    });
  }
}
