// ignore_for_file: depend_on_referenced_packages, file_names, non_constant_identifier_names

import 'package:another_flushbar/flushbar.dart';
import 'package:flutter/material.dart';
import 'package:gastrack_driver/animation/animations.dart';
import 'package:gastrack_driver/page/detailriwayatpenarikan.dart';
import 'package:gastrack_driver/provider/UserProvider.dart';
import 'package:intl/intl.dart';
import 'package:page_transition/page_transition.dart';
import 'package:sp_util/sp_util.dart';

class RiwayatPenarikan extends StatefulWidget {
  const RiwayatPenarikan({super.key});

  @override
  State<RiwayatPenarikan> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<RiwayatPenarikan> {
  List<Map> Data = [
    {
      "id_penarikan": 1,
      "tanggal_penarikan": "2024-02-08 12:37:18",
      "jumlah_penarikan": "100000"
    },
    {
      "id_penarikan": 2,
      "tanggal_penarikan": "2024-02-08 13:24:59",
      "jumlah_penarikan": "100000"
    },
    {
      "id_penarikan": 3,
      "tanggal_penarikan": "2024-02-08 13:26:07",
      "jumlah_penarikan": "100000"
    }
  ];
  bool gagalmemuat = false;

  void GetData() {
    Data.clear();
    setState(() {
      gagalmemuat = false;
    });
    UserProvider().getDataUpdateuser(SpUtil.getInt('id')).then((value) {
      if (value.statusCode == 200) {
        var data = value.body['datauser'];
        setState(() {
          Data.clear();
          Data.addAll([data]);
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

  Future<void> _refreshData() async {
    await Future.delayed(const Duration(seconds: 2));
    // GetData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: RefreshIndicator(
        onRefresh: _refreshData,
        child: Stack(
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.only(
                  top: 120, left: 10, right: 10, bottom: 10),
              child: ListView(
                padding: EdgeInsets.zero,
                children: [
                  const SizedBox(
                    height: 10,
                  ),
                  Column(
                    children: Data.map((index) {
                      return FadeAnimation(
                        0.5, GestureDetector(
                          onTap: () {
                            Navigator.push(
                              context,
                              PageTransition(
                                child: DetailPenarikan(
                                  riwayat: true,
                                  id: index['jumlah_penarikan'].toString(),
                                ),
                                type: PageTransitionType.rightToLeft,
                              ),
                            );
                          },
                          child: Container(
                            color: Colors.white,
                            margin: const EdgeInsets.symmetric(vertical: 10),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Row(
                                  children: [
                                    Image.asset(
                                      "assets/icon/riwayatiem_icon.png",
                                    ),
                                    Container(
                                      padding: const EdgeInsets.symmetric(
                                        horizontal: 10,
                                      ),
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          const Text(
                                            "Tarik Saldo",
                                            textAlign: TextAlign.center,
                                            style: TextStyle(
                                              fontFamily: "Poppins",
                                              fontSize: 12,
                                              color: Colors.black,
                                            ),
                                          ),
                                          Text(
                                            "${DateFormat('D MMM yyy', 'id_ID').format(DateTime.parse(index['tanggal_penarikan']))} . ${DateFormat('h m', 'id_ID').format(DateTime.parse(index['tanggal_penarikan']))}",
                                            textAlign: TextAlign.center,
                                            style: const TextStyle(
                                              height: 2,
                                              fontFamily: "Poppins",
                                              fontSize: 10,
                                              color: Colors.black54,
                                            ),
                                          ),
                                        ],
                                      ),
                                    )
                                  ],
                                ),
                                Text(
                                  "-Rp${(NumberFormat.decimalPattern().format(int.parse(index['jumlah_penarikan'])))}",
                                  textAlign: TextAlign.center,
                                  style: const TextStyle(
                                    fontFamily: "Poppins-bold",
                                    fontSize: 14,
                                    color: Colors.black,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      );
                    }).toList(),
                  )
                ],
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
                        Navigator.pop(context);
                      },
                      child: const Icon(
                        Icons.arrow_back,
                        color: Color.fromRGBO(255, 255, 255, 1),
                      ),
                    ),
                  ),
                  const Expanded(
                    child: Text(
                      "Riwayat Penarikan",
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
