// ignore_for_file: depend_on_referenced_packages, file_names, non_constant_identifier_names

import 'dart:async';
import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:gastrack_driver/animation/BounceAnimation.dart';
import 'package:gastrack_driver/controller/PengirimanController.dart';

import '../animation/animations.dart';

class PesananDiterimaPage extends StatefulWidget {
  const PesananDiterimaPage({super.key, required this.id});

  final int id;

  @override
  State<PesananDiterimaPage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<PesananDiterimaPage> {
  late var id = widget.id.toInt();
  final PengirimanController _controller = PengirimanController();

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
                  _controller.Input_Gas_Keluar(id);
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

  @override
  void initState() {
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
              child: Column(
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
                              margin: const EdgeInsets.only(top: 20),
                              width: double.infinity,
                              decoration: const BoxDecoration(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(10)),
                              ),
                              child: const Text(
                                'Form Bukti Diterima',
                                style: TextStyle(
                                  fontSize: 18,
                                  fontFamily: 'Poppins-ExtraBold',
                                  color: Color.fromRGBO(249, 1, 131, 1.0),
                                ),
                              ),
                            ),
                          ),
                          FadeAnimation(
                            0.6,
                            Container(
                              margin: const EdgeInsets.symmetric(vertical: 20),
                              child: const Text(
                                '*mohon untuk melampirkan foto penerimaan (terlihat jumlah bar yang diterima)',
                                style: TextStyle(
                                  fontSize: 14,
                                  fontFamily: 'Poppins',
                                  color: Color.fromRGBO(249, 1, 131, 1.0),
                                ),
                              ),
                            ),
                          ),
                          FadeAnimation(
                            0.6,
                            Form(
                              child: Padding(
                                padding:
                                    const EdgeInsets.symmetric(vertical: 20),
                                child: TextFormField(
                                  controller: _controller.txtGasKeluar,
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
                                      borderRadius:
                                          BorderRadius.all(Radius.circular(40)),
                                    ),
                                    labelText: "Masukkan jumlah gas diterima",
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
                            decoration: BoxDecoration(
                                borderRadius:
                                    const BorderRadius.all(Radius.circular(30)),
                                border:
                                    Border.all(width: 1, color: Colors.grey)),
                            child: _controller.photoprofile == null
                                ? InkWell(
                                    onTap: () {
                                      getFilePicker();
                                    },
                                    child: const SizedBox(
                                      width: double.infinity,
                                      child: Center(
                                        child: Text('Unggah Bukti Penerimaan'),
                                      ),
                                    ),
                                  )
                                : Container(
                                    margin: const EdgeInsets.symmetric(
                                        vertical: 20),
                                    child: Image.file(
                                      File(_controller.photoprofile!.path!),
                                      width: double.infinity,
                                    ),
                                  ),
                          ),
                          _controller.photoprofile != null
                              ? Container(
                                  margin: const EdgeInsets.only(top: 20),
                                  child: ElevatedButton(
                                    onPressed: () {
                                      getFilePicker();
                                    },
                                    child: const Text("Pilih Foto Lainnya"),
                                  ),
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
                                  backgroundColor:
                                      const Color.fromRGBO(249, 1, 131, 1.0),
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
              ),
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
          ),
        ],
      ),
    );
  }
}
