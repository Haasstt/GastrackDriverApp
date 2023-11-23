// ignore_for_file: depend_on_referenced_packages, file_names, non_constant_identifier_names

import 'dart:async';
import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:gastrack_driver/animation/BounceAnimation.dart';
// import 'package:gastrack/provider/UserProvider.dart';
// import 'package:sp_util/sp_util.dart';
// import 'package:flutter_easyloading/flutter_easyloading.dart';

import '../animation/animations.dart';

class IsigasPage extends StatefulWidget {
  const IsigasPage({super.key});

  @override
  State<IsigasPage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<IsigasPage> {
  PlatformFile? photoprofile;

  void getFilePicker() async {
    final result = await FilePicker.platform.pickFiles(type: FileType.image);
    if (result != null) {
      final selectedFile = File(result.files.first.path as String);

      if (selectedFile.existsSync()) {
        final bytes = await selectedFile.readAsBytes();
        final controller = StreamController<List<int>>();
        controller.sink.add(bytes);

        setState(() {
          photoprofile = PlatformFile(
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
                              width: double.infinity,
                              height: 60,
                              decoration: const BoxDecoration(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(10)),
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
                                padding:
                                    const EdgeInsets.symmetric(vertical: 20),
                                child: TextFormField(
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
                                borderRadius:
                                    const BorderRadius.all(Radius.circular(30)),
                                border:
                                    Border.all(width: 1, color: Colors.grey)),
                            child: photoprofile == null
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
                                      File(photoprofile!.path!),
                                      width: double.infinity,
                                    ),
                                ),
                          ),
                          photoprofile != null
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
                                  backgroundColor:
                                      const Color.fromRGBO(249, 1, 131, 1.0),
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(20),
                                  ),
                                ),
                                onPressed: () {
                                  FocusManager.instance.primaryFocus?.unfocus();
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
