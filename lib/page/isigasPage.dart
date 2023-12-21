// ignore_for_file: depend_on_referenced_packages, file_names, non_constant_identifier_names, prefer_typing_uninitialized_variables, unused_element

import 'dart:async';
import 'dart:io';

import 'package:another_flushbar/flushbar.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:gastrack_driver/animation/BounceAnimation.dart';
import 'package:gastrack_driver/controller/PengirimanController.dart';
import 'package:gastrack_driver/provider/Base_provider.dart';
import 'package:gastrack_driver/provider/PengirimanProvider.dart';

import '../animation/animations.dart';

class IsigasPage extends StatefulWidget {
  const IsigasPage({super.key, required this.id});

  final int id;

  @override
  State<IsigasPage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<IsigasPage> {
  List<Map<String, dynamic>> Data = [];

  bool gagalmemuat = false;
  bool datakosong = true;
  var message;

  final PengirimanController _controller = PengirimanController();
  final BaseProvider _baseProvider = BaseProvider();
  late var id = widget.id.toInt();

  Future<void> _showConfirmationDialog(BuildContext context) async {
    return showDialog<void>(
      context: context,
      barrierDismissible:
          false, // Dialog tidak bisa ditutup dengan mengetuk di luar dialog
      builder: (BuildContext context) {
        return AlertDialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(
                20.0), // Atur BorderRadius sesuai kebutuhan
          ),
          title: const Text('Konfirmasi'),
          content: const Text(
              'Sebelum melanjutkan proses unggah pastikan Anda telah memilih foto yang benar karena Anda tidak bisa mengubah unggahan Anda kembali'),
          actions: <Widget>[
            TextButton(
              child: const Text('Batal'),
              onPressed: () {
                Navigator.of(context).pop(); // Menutup dialog
              },
            ),
            TextButton(
                child: const Text('Lanjutkan'),
                onPressed: () {
                  _controller.Input_Gas_Masuk(id);
                }),
          ],
        );
      },
    );
  }

  void getFilePicker() async {
    final result = await FilePicker.platform.pickFiles(type: FileType.image);
    if (result != null) {
      final selectedFile = File(result.files.first.path as String);

      if (selectedFile.existsSync()) {
        final bytes = await selectedFile.readAsBytes();
        final controller = StreamController<List<int>>();
        controller.sink.add(bytes);

        setState(() {
          _controller.photoprofile = PlatformFile(
            path: selectedFile.path,
            name: selectedFile.uri.pathSegments.last,
            readStream: controller.stream,
            size: bytes.length,
            bytes: bytes,
          );
        });
      }
    }
  }

  void GetData() {
    setState(() {
      Data.clear();
    });
    setState(() {
      gagalmemuat = false;
      datakosong = true;
    });
    PengirimanProvider().getDatadetailpengiriman(id).then((value) {
      if (value.statusCode == 200) {
        var data = value.body['data'];
        setState(() {
          Data.addAll([data]);
        });
        if (data['kapasitas_gas_masuk'] != null ||
            data['bukti_gas_masuk'] != null) {
          setState(() {
            datakosong = !datakosong;
          });
        }
      } else if (value.statusCode == 422) {
        var pesan = value.body['message'];
        setState(() {
          message = pesan;
        });
        Flushbar(
          backgroundColor: Colors.green,
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
      } else {
        setState(() {
          gagalmemuat = !gagalmemuat;
        });
      }
    });
  }

  @override
  void initState() {
    GetData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Stack(
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.only(top: 130),
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              width: double.infinity,
              height: MediaQuery.of(context).size.height,
              child: Data.isEmpty
                  ? gagalmemuat
                      ? GagalMemuat()
                      : const Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            CircularProgressIndicator(
                              strokeWidth: 1,
                              color: Color.fromRGBO(249, 1, 131, 1.0),
                            ),
                          ],
                        )
                  : datakosong
                      ? DataPengisianNull(context)
                      : Column(
                          children: Data.map((index) {
                            return Column(
                              children: [
                                FadeAnimation(
                                  0.5,
                                  SizedBox(
                                    width: double.infinity,
                                    child: FadeAnimation(
                                      0.5,
                                      Container(
                                        width: double.infinity,
                                        height:
                                            MediaQuery.of(context).size.height *
                                                0.10,
                                        decoration: const BoxDecoration(
                                          borderRadius: BorderRadius.all(
                                              Radius.circular(10)),
                                        ),
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          children: [
                                            Text(
                                              'Detail Pengisian Gas',
                                              style: TextStyle(
                                                fontSize: 18,
                                                fontFamily: 'Poppins-ExtraBold',
                                                color: Color.fromRGBO(
                                                    249, 1, 131, 1.0),
                                              ),
                                            ),
                                            Text(
                                              'Kapasitas pengisian gas : ${(index['kapasitas_gas_masuk'])} bar',
                                              style: TextStyle(
                                                fontSize: 18,
                                                fontFamily: 'Poppins',
                                                color: Colors.black38,
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                                FadeAnimation(
                                  0.5,
                                  SizedBox(
                                    width: double.infinity,
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          'Bukti pengisian gas',
                                          style: TextStyle(
                                            fontSize: 18,
                                            fontFamily: 'Poppins',
                                            color: Colors.black38,
                                          ),
                                        ),
                                        Container(
                                          width: double.infinity,
                                          margin: const EdgeInsets.symmetric(
                                            vertical: 10,
                                          ),
                                          height: MediaQuery.of(context).size.height * 0.65,
                                          padding: EdgeInsets.all(10),
                                          decoration: BoxDecoration(
                                              borderRadius: BorderRadius.all(
                                                  Radius.circular(10)),
                                              border: Border.all(
                                                  width: 1,
                                                  color: Colors.black38)),
                                          child: Image.network(
                                            '${(_baseProvider.UrlImageBuktiGasMasuk)}/${(index['bukti_gas_masuk'])}',
                                            fit: BoxFit.contain,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ],
                            );
                          }).toList(),
                        ),
            ),
          ),
          Appbar(context),
        ],
      ),
    );
  }

  Container Appbar(BuildContext context) {
    return Container(
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
            margin: const EdgeInsets.symmetric(vertical: 15, horizontal: 5),
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
              "Pengisian Gas",
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
    );
  }

  Column GagalMemuat() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Column(
          children: [
            Container(
              margin: const EdgeInsets.symmetric(vertical: 5),
              child: const Icon(
                Icons.cloud_off,
                size: 50,
                color: Colors.black26,
              ),
            ),
            const Text(
              'Offline',
              style: TextStyle(
                fontSize: 14,
                fontFamily: 'Poppins',
                fontWeight: FontWeight.normal,
              ),
            ),
          ],
        ),
      ],
    );
  }

  Column DataPengisianNull(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        FadeAnimation(
          0.5,
          SizedBox(
            width: double.infinity,
            child: Column(
              children: [
                FadeAnimation(
                  0.5,
                  Container(
                    width: double.infinity,
                    height: 60,
                    decoration: const BoxDecoration(
                      borderRadius: BorderRadius.all(Radius.circular(10)),
                    ),
                    child: const Row(
                      children: [
                        Text(
                          'Form Pengisian Gas',
                          style: TextStyle(
                            fontSize: 18,
                            fontFamily: 'Poppins-ExtraBold',
                            color: Color.fromRGBO(249, 1, 131, 1.0),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                FadeAnimation(
                  0.6,
                  Form(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(vertical: 20),
                      child: TextFormField(
                        controller: _controller.txtGasMasuk,
                        decoration: const InputDecoration(
                          suffixIcon: Padding(
                              padding: EdgeInsets.symmetric(
                                  horizontal: 20, vertical: 20),
                              child: Text(
                                '/ bar',
                                style: TextStyle(
                                  fontFamily: 'Poppins',
                                ),
                              )),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.all(Radius.circular(40)),
                          ),
                          labelText: "Masukkan jumlah pesanan gas",
                          filled: true,
                          fillColor: Colors.white,
                        ),
                        style: const TextStyle(
                          fontFamily: 'Poppins',
                        ),
                      ),
                    ),
                  ),
                ),
                Container(
                  height: MediaQuery.of(context).size.height * 0.30,
                  margin: const EdgeInsets.symmetric(vertical: 20),
                  decoration: BoxDecoration(
                      borderRadius: const BorderRadius.all(Radius.circular(30)),
                      border: Border.all(width: 1, color: Colors.grey)),
                  child: _controller.photoprofile == null
                      ? InkWell(
                          onTap: () {
                            getFilePicker();
                          },
                          child: const SizedBox(
                            width: double.infinity,
                            child: Center(
                              child: Text('Unggah Bukti Pengisian'),
                            ),
                          ),
                        )
                      : Container(
                          margin: const EdgeInsets.symmetric(vertical: 20),
                          child: Image.file(
                            File(_controller.photoprofile!.path!),
                            width: double.infinity,
                          ),
                        ),
                ),
                _controller.photoprofile != null
                    ? ElevatedButton(
                        onPressed: () {
                          getFilePicker();
                        },
                        child: const Text("Pilih Foto Lainnya"),
                      )
                    : const Text(""),
                BounceAnimation(
                  0.7,
                  Container(
                    margin: const EdgeInsets.symmetric(vertical: 20),
                    width: double.infinity,
                    height: 50,
                    child: ElevatedButton(
                      style: TextButton.styleFrom(
                        backgroundColor: const Color.fromRGBO(249, 1, 131, 1.0),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20),
                        ),
                      ),
                      onPressed: () {
                        FocusManager.instance.primaryFocus?.unfocus();
                        _showConfirmationDialog(context);
                      },
                      child: const Text(
                        "Submit",
                        style: TextStyle(
                          fontFamily: 'Poppins',
                          fontSize: 15,
                          color: Color(0xffffffff),
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
