// ignore_for_file: depend_on_referenced_packages, file_names, non_constant_identifier_names, deprecated_member_use

import 'package:another_flushbar/flushbar.dart';
import 'package:flutter/material.dart';
import 'package:gastrack_driver/loading.dart';
import 'package:gastrack_driver/page/detailriwayatpenarikan.dart';
import 'package:gastrack_driver/provider/UserProvider.dart';
import 'package:intl/intl.dart';
import 'package:lottie/lottie.dart';
import 'package:page_transition/page_transition.dart';
import 'package:sliding_up_panel/sliding_up_panel.dart';
import 'package:sp_util/sp_util.dart';

class TarikSaldoPage extends StatefulWidget {
  const TarikSaldoPage({
    super.key,
    required this.saldo,
  });

  final String saldo;

  @override
  State<TarikSaldoPage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<TarikSaldoPage> {
  final List<List<Map>> Datajamberangkat = [
    [
      {"label": "1", "value": "1"},
      {"label": "2", "value": "2"},
      {"label": "3", "value": "3"},
    ],
    [
      {"label": "4", "value": "4"},
      {"label": "5", "value": "5"},
      {"label": "6", "value": "6"},
    ],
    [
      {"label": "7", "value": "7"},
      {"label": "8", "value": "8"},
      {"label": "9", "value": "9"},
    ],
    [
      {"label": "0", "value": "0"},
      {"label": "000", "value": "000"},
      {"label": "-", "value": "-"},
    ],
  ];
  TextEditingController txtSaldo = TextEditingController();
  TextEditingController txtValueSaldo = TextEditingController();
  final PanelController _panelController = PanelController();
  late bool indikator = true;
  late bool limitsaldo = false;
  late bool buttonValidation = false;
  late String message = "";

  @override
  void initState() {
    super.initState();
    txtSaldo.text = "Rp";
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _panelController.open();
    });
  }

  void checksaldo() {
    if (txtValueSaldo.text.isNotEmpty) {
      if (int.parse(widget.saldo) < int.parse(txtValueSaldo.text)) {
        setState(() {
          buttonValidation = false;
          message = "Saldo Anda tidak cukup";
        });
      } else {
        if (10000 > int.parse(txtValueSaldo.text)) {
          setState(() {
            buttonValidation = false;
            message = "Minimal penarikan Rp10.000";
          });
        } else {
          setState(() {
            buttonValidation = true;
            message = "";
          });
        }
      }
    } else {
      setState(() {
        buttonValidation = false;
        message = "Masukkan nominal penarikan";
      });
    }
  }

  void toggletariksaldo(jumlah) {
    customLoading(context);
      var data = {
        "jumlah_penarikan": jumlah
      };
    UserProvider().tariksaldo(SpUtil.getInt('id'), data).then((value) {
      if (value.statusCode == 200) {
    Navigator.pop(context);
        Navigator.push(
          context,
          PageTransition(
            child: DetailPenarikan(
              riwayat: false,
              id: value.body['id_penarikan'].toString(),
            ),
            type: PageTransitionType.rightToLeft,
          ),
        );
      } else if (value.statusCode == 422) {
    Navigator.pop(context);
        Flushbar(
          backgroundColor: Colors.red,
          flushbarPosition: FlushbarPosition.TOP,
          margin: const EdgeInsets.all(10),
          borderRadius: BorderRadius.circular(8),
          message: value.body['message'],
          icon: const Icon(
            Icons.info_outline,
            size: 28.0,
            color: Colors.white,
          ),
          duration: const Duration(seconds: 3),
        ).show(context);
      } else if (value.hasError == true) {
    Navigator.pop(context);
        var pesan = "Gagal Memuat, hubungkan perangkat ke jaringan";
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
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        if (_panelController.isPanelOpen) {
          _panelController.close();
          setState(() {
            indikator = false;
          });
          return false;
        } else {
          return true;
        }
      },
      child: Scaffold(
        backgroundColor: const Color.fromARGB(255, 244, 244, 244),
        resizeToAvoidBottomInset: false,
        body: Stack(
          children: <Widget>[
            Container(
              height: 200,
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
                        if (_panelController.isPanelOpen) {
                          _panelController.close();
                          setState(() {
                            indikator = false;
                          });
                        } else {
                          Navigator.pop(context);
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
                      "Tarik Saldo",
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
            Container(
              margin: const EdgeInsets.only(top: 140, left: 20, right: 20),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: const BorderRadius.all(Radius.circular(20)),
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.withOpacity(0.25), // Warna bayangan
                    spreadRadius: 2, // Seberapa jauh bayangan menyebar
                    blurRadius: 0, // Seberapa kabur bayangan
                    offset: const Offset(0, 1), // Posisi bayangan (x, y)
                  ),
                ],
              ),
              width: double.infinity,
              height: MediaQuery.of(context).size.height * 0.45,
              padding: const EdgeInsets.symmetric(
                horizontal: 20,
              ),
              child: ListView(
                padding: EdgeInsets.zero,
                children: [
                  Container(
                    width: MediaQuery.of(context).size.width,
                    margin: const EdgeInsets.symmetric(
                      vertical: 20,
                    ),
                    padding: const EdgeInsets.all(10),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          children: [
                            Image.asset(
                              "assets/icon/Profile_icon.png",
                            ),
                            const SizedBox(
                              width: 15,
                            ),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                const Text(
                                  "Saldo Anda",
                                  style: TextStyle(
                                    fontFamily: 'Poppins-bold',
                                    color: Colors.black,
                                    fontSize: 14,
                                  ),
                                ),
                                const SizedBox(
                                  height: 2,
                                ),
                                Text(
                                  'Rp${(NumberFormat.decimalPattern().format(int.parse(widget.saldo)))},-',
                                  style: const TextStyle(
                                    fontFamily: 'Poppins-bold',
                                    color: Colors.black,
                                    fontSize: 14,
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                  Container(
                    width: MediaQuery.of(context).size.width,
                    decoration: const BoxDecoration(
                      color: Color.fromARGB(255, 202, 202, 202),
                    ),
                    height: 1,
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  const Text(
                    "JUMLAH NOMINAL",
                    style: TextStyle(
                      fontFamily: 'Poppins-bold',
                      color: Colors.black38,
                      fontSize: 14,
                    ),
                  ),
                  GestureDetector(
                    onTap: () {
                      _panelController.open();
                      setState(() {
                        indikator = true;
                      });
                    },
                    child: Container(
                      color: Colors.white,
                      width: MediaQuery.of(context).size.width,
                      child: txtValueSaldo.text.isEmpty
                          ? Row(
                              children: [
                                indikator
                                    ? Lottie.asset(
                                        'assets/js/input_indikator.json',
                                      )
                                    : const SizedBox(
                                        width: 7,
                                      ),
                                Text(
                                  txtSaldo.text,
                                  style: TextStyle(
                                    fontFamily: 'Poppins-bold',
                                    color: txtValueSaldo.text.isNotEmpty
                                        ? Colors.black
                                        : Colors.black38,
                                    fontSize: 25,
                                  ),
                                ),
                              ],
                            )
                          : Row(
                              children: [
                                const SizedBox(
                                  width: 7,
                                ),
                                Text(
                                  txtSaldo.text +
                                      NumberFormat.decimalPattern().format(
                                          int.parse(txtValueSaldo.text)),
                                  style: TextStyle(
                                    fontFamily: 'Poppins-bold',
                                    color: txtValueSaldo.text.isNotEmpty
                                        ? Colors.black
                                        : Colors.black38,
                                    fontSize: 25,
                                  ),
                                ),
                                indikator
                                    ? Lottie.asset(
                                        'assets/js/input_indikator.json',
                                      )
                                    : const SizedBox(),
                              ],
                            ),
                    ),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  message != ""
                      ? Row(
                          children: [
                            const Icon(
                              Icons.warning_rounded,
                              size: 15,
                              color: Colors.red,
                            ),
                            const SizedBox(
                              width: 3,
                            ),
                            Text(
                              message,
                              style: const TextStyle(
                                fontFamily: 'Poppins',
                                color: Colors.red,
                                fontSize: 9,
                              ),
                            ),
                          ],
                        )
                      : const SizedBox()
                ],
              ),
            ),
            Column(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Container(
                  color: Colors.white,
                  child: GestureDetector(
                    onTap: buttonValidation
                        ? () {
                          toggletariksaldo(txtValueSaldo.text);
                          }
                        : null,
                    child: Container(
                      height: 50,
                      margin: const EdgeInsets.all(10),
                      padding: const EdgeInsets.all(10),
                      color: buttonValidation
                          ? const Color.fromRGBO(249, 1, 131, 1.0)
                          : const Color.fromARGB(255, 166, 166, 166),
                      width: double.infinity,
                      child: const Center(
                        child: Text(
                          "Lanjutkan",
                          style: TextStyle(
                              fontFamily: 'Poppins-bold',
                              fontSize: 14,
                              color: Colors.white),
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(
              height: MediaQuery.of(context).size.height,
              child: SlidingUpPanel(
                controller: _panelController,
                minHeight: 0,
                maxHeight: MediaQuery.of(context).size.height * 0.40,
                panel: Container(
                  decoration: BoxDecoration(
                    color: Colors.white,
                    boxShadow: [
                      BoxShadow(
                        color: Colors.grey.withOpacity(0.25), // Warna bayangan
                        spreadRadius: 2, // Seberapa jauh bayangan menyebar
                        blurRadius: 0, // Seberapa kabur bayangan
                        offset: const Offset(0, 1), // Posisi bayangan (x, y)
                      ),
                    ],
                  ),
                  width: double.infinity,
                  child: Column(
                    children: [
                      Expanded(
                        child: Column(
                          children: Datajamberangkat.map(
                            (row) => Expanded(
                              child: SizedBox(
                                width: double.infinity,
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: row.map((item) {
                                    return Expanded(
                                      child: GestureDetector(
                                        onTap: () {
                                          if (item['value'] == "-") {
                                            if (txtValueSaldo.text.isNotEmpty) {
                                              setState(() {
                                                txtValueSaldo.text =
                                                    txtValueSaldo.text
                                                        .substring(
                                                            0,
                                                            txtValueSaldo.text
                                                                    .length -
                                                                1);
                                              });
                                              checksaldo();
                                            }
                                          } else {
                                            if (item['value'] == "000") {
                                              if (txtValueSaldo
                                                  .text.isNotEmpty) {
                                                if (txtValueSaldo.text != "0") {
                                                  setState(() {
                                                    txtValueSaldo.text +=
                                                        item['value'];
                                                  });
                                                  checksaldo();
                                                }
                                              } else {
                                                setState(() {
                                                  txtValueSaldo.text += "0";
                                                });
                                              }
                                            } else if (item['value'] == "0") {
                                              if (txtValueSaldo
                                                  .text.isNotEmpty) {
                                                if (txtValueSaldo.text != "0") {
                                                  setState(() {
                                                    txtValueSaldo.text +=
                                                        item['value'];
                                                  });
                                                  checksaldo();
                                                }
                                              } else {
                                                setState(() {
                                                  txtValueSaldo.text +=
                                                      item['value'];
                                                });
                                              }
                                            } else {
                                              setState(() {
                                                txtValueSaldo.text +=
                                                    item['value'];
                                              });
                                              checksaldo();
                                            }
                                          }
                                        },
                                        child: Container(
                                          color: Colors.white,
                                          padding: const EdgeInsets.all(10),
                                          height: 40,
                                          width: 60,
                                          child: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            children: [
                                              Text(
                                                item['label'],
                                                style: const TextStyle(
                                                  fontFamily: 'Poppins-bold',
                                                  fontSize: 18,
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ),
                                    );
                                  }).toList(),
                                ),
                              ),
                            ),
                          ).toList(),
                        ),
                      ),
                      GestureDetector(
                        onTap: buttonValidation
                            ? () {
                                _panelController.close();
                                setState(() {
                                  indikator = false;
                                });
                              }
                            : null,
                        child: Container(
                          margin: const EdgeInsets.all(8),
                          padding: const EdgeInsets.all(10),
                          color: buttonValidation
                              ? const Color.fromRGBO(249, 1, 131, 1.0)
                              : const Color.fromARGB(255, 166, 166, 166),
                          width: double.infinity,
                          child: const Center(
                            child: Text(
                              "Selesai",
                              style: TextStyle(
                                  fontFamily: 'Poppins-bold',
                                  fontSize: 14,
                                  color: Colors.white),
                            ),
                          ),
                        ),
                      )
                    ],
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
