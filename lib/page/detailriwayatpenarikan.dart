// ignore_for_file: depend_on_referenced_packages, file_names, non_constant_identifier_names, deprecated_member_use

import 'package:another_flushbar/flushbar.dart';
import 'package:flutter/material.dart';
import 'package:gastrack_driver/provider/UserProvider.dart';
import 'package:get/get.dart';
import 'package:sp_util/sp_util.dart';

class DetailPenarikan extends StatefulWidget {
  const DetailPenarikan({super.key, required this.riwayat, required this.id});
  final bool riwayat;
  final String id;

  @override
  State<DetailPenarikan> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<DetailPenarikan> {
  List<Map<String, dynamic>> DataDetail = [];
  bool gagalmemuat = false;

  void GetData() {
    DataDetail.clear();
    setState(() {
      gagalmemuat = false;
    });
    UserProvider().getDataUpdateuser(SpUtil.getInt('id')).then((value) {
      if (value.statusCode == 200) {
        var data = value.body['datauser'];
        setState(() {
          DataDetail.clear();
          DataDetail.addAll([data]);
        });
      } else if (value.hasError == true) {
        var pesan = "Gagal Memuat, hubungkan perangkat ke jaringan";
        setState(() {
          gagalmemuat = !gagalmemuat;
        });
        Flushbar(
          backgroundColor: Colors.red,
          flushbarPosition: FlushbarPosition.TOP,
          margin: const EdgeInsets.all(10),
          borderRadius: BorderRadius.circular(8),
          message: pesan,
          icon: const Icon(
            Icons.info_outline,
            size: 28.0,
            color: Colors.white,
          ),
          duration: const Duration(seconds: 3),
        ).show(context);
      }
    });
  }

  @override
  void initState() {
    // GetData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        if (widget.riwayat) {
          return true;
        } else {
          Get.offAllNamed('/home');
          return false;
        }
      },
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        body: Stack(
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.only(
                  top: 120, left: 10, right: 10, bottom: 10),
              child: ListView(
                padding: EdgeInsets.zero,
                children: [],
              ),
            ),
            Container(
              padding: const EdgeInsets.only(top: 40),
              width: double.infinity,
              decoration: const BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    colors: [
                      Color.fromRGBO(249, 1, 131, 1.0),
                      Color.fromRGBO(128, 38, 198, 1.0)
                    ],
                  ),
                  borderRadius: BorderRadius.only(
                    bottomLeft: Radius.circular(20),
                    bottomRight: Radius.circular(20),
                  )),
              child: Row(
                children: [
                  Container(
                    margin:
                        const EdgeInsets.symmetric(vertical: 15, horizontal: 5),
                    height: 50,
                    width: 50,
                    child: TextButton(
                      onPressed: () {
                        if (widget.riwayat) {
                          Navigator.pop(context);
                        } else {
                          Get.offAllNamed('/home');
                        }
                      },
                      child: const Icon(
                        Icons.arrow_back,
                        color: Color.fromRGBO(255, 255, 255, 1),
                      ),
                    ),
                  ),
                  const Expanded(
                    child: Text(
                      "Detail Tarik Saldo",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontFamily: "Poppins-bold",
                        fontSize: 20,
                        color: Colors.white,
                      ),
                    ),
                  ),
                  const SizedBox(
                    width: 50,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
