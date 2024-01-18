// ignore_for_file: depend_on_referenced_packages, file_names, non_constant_identifier_names

import 'package:another_flushbar/flushbar.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:gastrack_driver/animation/BounceAnimation.dart';
import 'package:gastrack_driver/controller/Authcontroller.dart';
import 'package:gastrack_driver/page/kontakkamiPage.dart';
import 'package:gastrack_driver/provider/UserProvider.dart';
import 'package:page_transition/page_transition.dart';
import 'package:sp_util/sp_util.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';

import '../animation/animations.dart';
import 'notfoundPage.dart';
import 'settingdetailPage.dart';

class Profilsaya extends StatefulWidget {
  const Profilsaya({super.key});

  @override
  State<Profilsaya> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<Profilsaya> {
  final LogoutController _controller = LogoutController();
  List<Map<String, dynamic>> Data = [];
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
        // print(data);
        EasyLoading.dismiss();
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
    GetData();
    super.initState();
  }

  Future<void> _showConfirmationDialog(BuildContext context) async {
    return showDialog<void>(
      context: context,
      barrierDismissible:
          false, // Dialog tidak bisa ditutup dengan mengetuk di luar dialog
      builder: (BuildContext context) {
        return  BounceAnimation(
          0.1,
          AlertDialog(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(
                  20.0), // Atur BorderRadius sesuai kebutuhan
            ),
            title: const Text(
              'Apakah Anda yakin ingin keluar?',
              style: TextStyle(
                  fontSize: 14,
                  fontFamily: 'Poppins-bold',
                  color: Colors.black),
            ),
            content: const Text(
              'Akun akan terhapus dan Anda akan keluar dari aplikasi. tetap lanjut?',
              style: TextStyle(
                  fontSize: 12, fontFamily: 'Poppins', color: Colors.black),
            ),
            actions: <Widget>[
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Expanded(
                    child: TextButton(
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      style: TextButton.styleFrom(
                        backgroundColor: const Color.fromRGBO(249, 1, 131, 1.0),
                        foregroundColor: Colors.white,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                      ),
                      child: Container(
                        margin: const EdgeInsets.symmetric(vertical: 5),
                        alignment: Alignment.center,
                        child: const Text(
                          'Batal',
                          style: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(
                    width: 8,
                  ),
                  Expanded(
                    child: TextButton(
                      onPressed: () {
                        _controller.logout(context);
                      },
                      style: TextButton.styleFrom(
                        backgroundColor:
                            const Color.fromARGB(255, 255, 255, 255),
                        foregroundColor:
                            const Color.fromRGBO(128, 38, 198, 1.0),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                      ),
                      child: Container(
                        margin: const EdgeInsets.symmetric(vertical: 5),
                        alignment: Alignment.center,
                        child: const Text(
                          'Iya',
                          style: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        );
      },
    );
  }
  
  Future<void> _refreshData() async {
    await Future.delayed(const Duration(seconds: 2));
    GetData();
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
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 10),
                    width: double.infinity,
                    height: MediaQuery.of(context).size.height - 130,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                  Expanded(
                    child: FadeAnimation(
                      0.5,
                      Container(
                        margin: const EdgeInsets.symmetric(vertical: 10),
                        width: double.infinity,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
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
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Text(
                                      'Akun',
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          fontSize: 20,
                                          fontFamily: 'Poppins',
                                          color: Colors.black),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                            FadeAnimation(
                              0.5,
                              Container(
                                width: double.infinity,
                                height: 40,
                                decoration: const BoxDecoration(
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(10))),
                                child: TextButton(
                                  style: TextButton.styleFrom(
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(20),
                                    ),
                                  ),
                                  onPressed: () {
                                    Navigator.push(
                                        context,
                                        PageTransition(
                                          child: const Changename(),
                                          type: PageTransitionType.rightToLeft,
                                        ));
                                  },
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      const Row(
                                        children: [
                                          FaIcon(FontAwesomeIcons.solidUser,
                                              size: 20, color: Colors.black),
                                          SizedBox(
                                            width: 10,
                                          ),
                                          Text(
                                            'Username',
                                            style: TextStyle(
                                                fontWeight: FontWeight.normal,
                                                fontSize: 16,
                                                fontFamily: 'Poppins',
                                                color: Colors.black),
                                          ),
                                        ],
                                      ),
                                      Row(
                                        children: [
                                          Data.isEmpty
                                              ? const Text("")
                                              : Padding(
                                                  padding: const EdgeInsets
                                                      .symmetric(
                                                      horizontal: 10),
                                                  child: Text(
                                                    Data[0]['nama'],
                                                    style: const TextStyle(
                                                        fontWeight:
                                                            FontWeight.normal,
                                                        fontSize: 10,
                                                        fontFamily: 'Poppins',
                                                        color: Colors.black26),
                                                  ),
                                                ),
                                          Image.asset(
                                            "assets/icon/navigate_icon.png",
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                            FadeAnimation(
                              0.6,
                              Container(
                                width: double.infinity,
                                height: 40,
                                decoration: const BoxDecoration(
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(10))),
                                child: TextButton(
                                  style: TextButton.styleFrom(
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(20),
                                    ),
                                  ),
                                  onPressed: () {
                                    Navigator.push(
                                        context,
                                        PageTransition(
                                          child: const Changeemail(),
                                          type: PageTransitionType.rightToLeft,
                                        ));
                                  },
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      const Row(
                                        children: [
                                          Icon(Icons.email,
                                              size: 20, color: Colors.black),
                                          SizedBox(
                                            width: 10,
                                          ),
                                          Text(
                                            'Email',
                                            style: TextStyle(
                                                fontWeight: FontWeight.normal,
                                                fontSize: 16,
                                                fontFamily: 'Poppins',
                                                color: Colors.black),
                                          ),
                                        ],
                                      ),
                                      Row(
                                        children: [
                                          Data.isEmpty
                                              ? const Text("")
                                              : Padding(
                                                  padding: const EdgeInsets
                                                      .symmetric(
                                                      horizontal: 10),
                                                  child: Text(
                                                    Data[0]['email'],
                                                    style: const TextStyle(
                                                        fontWeight:
                                                            FontWeight.normal,
                                                        fontSize: 10,
                                                        fontFamily: 'Poppins',
                                                        color: Colors.black26),
                                                  ),
                                                ),
                                          Image.asset(
                                            "assets/icon/navigate_icon.png",
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                            FadeAnimation(
                              0.6,
                              Container(
                                width: double.infinity,
                                height: 40,
                                decoration: const BoxDecoration(
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(10))),
                                child: TextButton(
                                  style: TextButton.styleFrom(
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(20),
                                    ),
                                  ),
                                  onPressed: () {
                                    Navigator.push(
                                        context,
                                        PageTransition(
                                          child: const Changephone(),
                                          type: PageTransitionType.rightToLeft,
                                        ));
                                  },
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      const Row(
                                        children: [
                                          Icon(Icons.phone,
                                              size: 20, color: Colors.black),
                                          SizedBox(
                                            width: 10,
                                          ),
                                          Text(
                                            'No. Telp',
                                            style: TextStyle(
                                                fontWeight: FontWeight.normal,
                                                fontSize: 16,
                                                fontFamily: 'Poppins',
                                                color: Colors.black),
                                          ),
                                        ],
                                      ),
                                      Row(
                                        children: [
                                          Data.isEmpty
                                              ? const Text("")
                                              : Data[0]['no_hp'] == null
                                                  ? const Padding(
                                                      padding:
                                                          EdgeInsets.symmetric(
                                                              horizontal: 10),
                                                      child: Text(
                                                        'Atur no. telp',
                                                        style: TextStyle(
                                                            fontWeight:
                                                                FontWeight
                                                                    .normal,
                                                            fontSize: 12,
                                                            fontFamily:
                                                                'Poppins',
                                                            color:
                                                                Colors.black26),
                                                      ),
                                                    )
                                                  : Padding(
                                                      padding: const EdgeInsets
                                                          .symmetric(
                                                          horizontal: 10),
                                                      child: Text(
                                                        Data[0]['no_hp'],
                                                        style: const TextStyle(
                                                            fontWeight:
                                                                FontWeight
                                                                    .normal,
                                                            fontSize: 10,
                                                            fontFamily:
                                                                'Poppins',
                                                            color:
                                                                Colors.black26),
                                                      ),
                                                    ),
                                          Image.asset(
                                            "assets/icon/navigate_icon.png",
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                            FadeAnimation(
                              0.7,
                              Container(
                                width: double.infinity,
                                height: 40,
                                decoration: const BoxDecoration(
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(10))),
                                child: TextButton(
                                  style: TextButton.styleFrom(
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(20),
                                    ),
                                  ),
                                  onPressed: () {
                                    Navigator.push(
                                      context,
                                      PageTransition(
                                        child: const Changepassword(),
                                        type: PageTransitionType.rightToLeft,
                                      ),
                                    );
                                  },
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      const Row(
                                        children: [
                                          Icon(Icons.lock,
                                              size: 20, color: Colors.black),
                                          SizedBox(
                                            width: 10,
                                          ),
                                          Text(
                                            'Ubah Password',
                                            style: TextStyle(
                                                fontWeight: FontWeight.normal,
                                                fontSize: 16,
                                                fontFamily: 'Poppins',
                                                color: Colors.black),
                                          ),
                                        ],
                                      ),
                                      Image.asset(
                                        "assets/icon/navigate_icon.png",
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                            const SizedBox(
                              height: 15,
                            ),
                            FadeAnimation(
                              0.7,
                              Container(
                                width: double.infinity,
                                height: 60,
                                decoration: const BoxDecoration(
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(10))),
                                child: const Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Text(
                                      'Pusat Bantuan',
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          fontSize: 20,
                                          fontFamily: 'Poppins',
                                          color: Colors.black),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                            FadeAnimation(
                              0.8,
                              Container(
                                width: double.infinity,
                                height: 40,
                                decoration: const BoxDecoration(
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(10))),
                                child: TextButton(
                                  style: TextButton.styleFrom(
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(20),
                                    ),
                                  ),
                                  onPressed: () {
                                    Navigator.push(
                                      context,
                                      PageTransition(
                                        child: const NotFoundPage(),
                                        type: PageTransitionType.rightToLeft,
                                      ),
                                    );
                                  },
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      const Row(
                                        children: [
                                          Icon(Icons.security_outlined,
                                              size: 20, color: Colors.black),
                                          SizedBox(
                                            width: 10,
                                          ),
                                          Text(
                                            'Kebijakan Gastrack',
                                            style: TextStyle(
                                                fontWeight: FontWeight.normal,
                                                fontSize: 16,
                                                fontFamily: 'Poppins',
                                                color: Colors.black),
                                          ),
                                        ],
                                      ),
                                      Image.asset(
                                        "assets/icon/navigate_icon.png",
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                            FadeAnimation(
                              0.9,
                              Container(
                                width: double.infinity,
                                height: 40,
                                decoration: const BoxDecoration(
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(10))),
                                child: TextButton(
                                  style: TextButton.styleFrom(
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(20),
                                    ),
                                  ),
                                  onPressed: () {
                                    Navigator.push(
                                      context,
                                      PageTransition(
                                        child: const KontakKamiPage(),
                                        type: PageTransitionType.rightToLeft,
                                      ),
                                    );
                                  },
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      const Row(
                                        children: [
                                          Icon(Icons.contact_page_outlined,
                                              size: 20, color: Colors.black),
                                          SizedBox(
                                            width: 10,
                                          ),
                                          Text(
                                            'Kontak Kami',
                                            style: TextStyle(
                                                fontWeight: FontWeight.normal,
                                                fontSize: 16,
                                                fontFamily: 'Poppins',
                                                color: Colors.black),
                                          ),
                                        ],
                                      ),
                                      Image.asset(
                                        "assets/icon/navigate_icon.png",
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 35),
                    child: BounceAnimation(
                      1.0,
                      Container(
                        width: 350,
                        height: 50,
                        decoration: BoxDecoration(
                            color: const Color.fromARGB(255, 255, 255, 255),
                            borderRadius: BorderRadius.circular(10),
                            border: Border.all(color: Colors.black)),
                        child: TextButton(
                          style: TextButton.styleFrom(
                            shape: const RoundedRectangleBorder(),
                          ),
                          onPressed: () {
                            _showConfirmationDialog(context);
                          },
                          child: const Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                "Keluar",
                                style: TextStyle(
                                  fontFamily: 'Poppins',
                                  fontSize: 15,
                                  color: Color.fromARGB(255, 0, 0, 0),
                                ),
                              ),
                              SizedBox(
                                width: 5,
                              ),
                              Icon(
                                Icons.logout_outlined,
                                size: 15,
                                color: Color.fromARGB(255, 0, 0, 0),
                              )
                            ],
                          ),
                        ),
                      ),
                    ),
                  )
                      ],
                    ),
                  ),
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
                      "Pengaturan",
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

