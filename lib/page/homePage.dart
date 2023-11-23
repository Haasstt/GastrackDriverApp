// ignore_for_file: depend_on_referenced_packages, non_constant_identifier_names, avoid_print

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
// import 'package:gastrack_driver/controller/Authcontroller.dart';
import 'package:gastrack_driver/page/settingPage.dart';
import 'package:page_transition/page_transition.dart';
// import 'package:shimmer/shimmer.dart';
// import 'package:sp_util/sp_util.dart';
// import 'package:flutter_easyloading/flutter_easyloading.dart';
// import 'package:another_flushbar/flushbar.dart';

class Homepage extends StatefulWidget {
  const Homepage({super.key});

  @override
  State<Homepage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<Homepage> {
  // final LogoutController _controller = LogoutController();
  final List<Map> Data = [
    {
      'resi': "SHIP(GTK)-20231104131902nU",
      'nama_perusahaan': "PT Saya Pesan Gas Bang",
      'alamat_perusahaan':
          "Jalan Waru Gunung, RT.005/RW.002, Krajan Kulon, Warugunung, Kec. Karangpilang, Kabupaten Sidoarjo, Jawa Timur",
      'jumlah_pesanan': 3,
      'tanggal_pemesanaan': "2023-11-04"
    }
  ];
  // late var message = "";
  // bool gagalmemuat = false;

  // void GetData() {
  //   setState(() {
  //     gagalmemuat = false;
  //   });
  //   UserProvider().getDatauser(SpUtil.getInt('id')).then((value) {
  //     if (value.statusCode == 200) {
  //       var data = value.body['datauser'];
  //       setState(() {
  //         Datauser.add(data);
  //       });
  //       EasyLoading.dismiss();
  //     } else if (value.hasError == true) {
  //       var pesan = "Gagal Memuat, hubungkan perangkat ke jaringan";
  //       setState(() {
  //         message = pesan;
  //         gagalmemuat = !gagalmemuat;
  //       });
  //       Flushbar(
  //         backgroundColor: Colors.red,
  //         flushbarPosition: FlushbarPosition.TOP,
  //         margin: const EdgeInsets.all(10),
  //         borderRadius: BorderRadius.circular(8),
  //         message: message,
  //         icon: const Icon(
  //           Icons.info_outline,
  //           size: 28.0,
  //           color: Colors.white,
  //         ),
  //         duration: const Duration(seconds: 3),
  //       ).show(context);
  //       EasyLoading.dismiss();
  //     }
  //   });
  // }

  @override
  void initState() {
    // GetData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(
      const SystemUiOverlayStyle(
        statusBarColor: Colors.transparent,
        statusBarBrightness: Brightness.light,
      ),
    );
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Stack(
        children: <Widget>[
          SizedBox(
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  flex: 2,
                  child: Container(
                    decoration: BoxDecoration(
                      gradient: const LinearGradient(
                        begin: Alignment.topCenter,
                        end: Alignment.bottomCenter,
                        colors: [
                          Color.fromRGBO(128, 38, 198, 1.0),
                          Color.fromRGBO(249, 1, 131, 1.0),
                        ],
                      ),
                      borderRadius: const BorderRadius.only(
                        bottomLeft: Radius.circular(20),
                        bottomRight: Radius.circular(20),
                      ),
                      boxShadow: [
                        BoxShadow(
                          color:
                              Colors.grey.withOpacity(0.25), // Warna bayangan
                          spreadRadius: 0, // Seberapa jauh bayangan menyebar
                          blurRadius: 4, // Seberapa kabur bayangan
                          offset: const Offset(1, 1), // Posisi bayangan (x, y)
                        ),
                      ],
                    ),
                    child: Container(
                      padding: const EdgeInsets.symmetric(horizontal: 0),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          Container(
                            width: double.infinity,
                            margin: const EdgeInsets.only(top: 40),
                            padding: const EdgeInsets.symmetric(horizontal: 20),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                const SizedBox(
                                  width: 50,
                                ),
                                Column(
                                  children: [
                                    Image.asset(
                                      "assets/icon/gastrack_icon_white.png",
                                      width: 120,
                                    ),
                                    const Text(
                                      'Aplikasi untuk pengemudi',
                                      textAlign: TextAlign.start,
                                      style: TextStyle(
                                        fontFamily: 'Poppins',
                                        color: Colors.white,
                                        fontSize: 14,
                                      ),
                                    ),
                                  ],
                                ),
                                InkWell(
                                  onTap: () {
                                    Navigator.push(
                                        context,
                                        PageTransition(
                                          child: const Profilsaya(),
                                          type: PageTransitionType.rightToLeft,
                                        ));
                                  },
                                  child: Image.asset(
                                    "assets/icon/setting_icon.png",
                                    width: 35,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Container(
                            width: MediaQuery.of(context).size.width,
                            margin: const EdgeInsets.symmetric(horizontal: 20),
                            padding: const EdgeInsets.symmetric(vertical: 20),
                            decoration: BoxDecoration(
                              color: const Color.fromRGBO(255, 255, 255, 1),
                              borderRadius:
                                  const BorderRadius.all(Radius.circular(10)),
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.grey
                                      .withOpacity(0.15), // Warna bayangan
                                  spreadRadius:
                                      0, // Seberapa jauh bayangan menyebar
                                  blurRadius: 4, // Seberapa kabur bayangan
                                  offset: const Offset(
                                      1, 1), // Posisi bayangan (x, y)
                                ),
                              ],
                            ),
                            child: const Text(
                              'Nurafiif Almas',
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                fontFamily: 'Poppins-bold',
                                color: Colors.black,
                                fontSize: 14,
                              ),
                            ),
                          ),
                          SizedBox(
                            width: MediaQuery.of(context).size.width,
                            child: const Column(
                              children: [
                                Text(
                                  'Tetep berhati - hati dalam perjalanan.',
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                    fontFamily: 'Poppins',
                                    color: Colors.white,
                                    fontSize: 14,
                                  ),
                                ),
                                Text(
                                  'Jadilah pengemudi yang taat dalam aturan ',
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                    fontFamily: 'Poppins',
                                    color: Colors.white,
                                    fontSize: 14,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Image.asset(
                            "assets/icon/img_home.png",
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                Expanded(
                  flex: 1,
                  child: Container(
                    margin: const EdgeInsets.only(top: 25),
                    width: MediaQuery.of(context).size.width,
                    decoration: BoxDecoration(
                      color: Color.fromARGB(255, 255, 255, 255),
                      borderRadius: const BorderRadius.only(
                        topLeft: Radius.circular(20),
                        topRight: Radius.circular(20),
                      ),
                      boxShadow: [
                        BoxShadow(
                          color:
                              Colors.grey.withOpacity(0.25), // Warna bayangan
                          spreadRadius: 0, // Seberapa jauh bayangan menyebar
                          blurRadius: 4, // Seberapa kabur bayangan
                          offset: const Offset(1, 1), // Posisi bayangan (x, y)
                        ),
                      ],
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          padding: const EdgeInsets.only(
                            top: 20,
                            left: 20,
                          ),
                          child: const Text(
                            'Daftar Pengiriman',
                            style: TextStyle(
                              fontSize: 16,
                              fontFamily: 'Poppins-bold',
                              color: Colors.black,
                            ),
                          ),
                        ),
                        Expanded(
                          child: Container(
                            width: MediaQuery.of(context).size.width,
                            decoration: const BoxDecoration(
                              color: Colors.white,
                            ),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Expanded(
                                  child: Container(
                                    margin: const EdgeInsets.symmetric(
                                      vertical: 10,
                                      horizontal: 10,
                                    ),
                                    padding: const EdgeInsets.symmetric(
                                      horizontal: 10,
                                      vertical: 10,
                                    ),
                                    width: double.infinity,
                                    decoration: BoxDecoration(
                                      border: Border.all(
                                        width: 1,
                                        color: Colors.black38,
                                      ),
                                      borderRadius: const BorderRadius.all(
                                        Radius.circular(20),
                                      ),
                                    ),
                                    child: Column(
                                      children: Data.map((index) {
                                        return Expanded(
                                          child: SizedBox(
                                            child: Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              mainAxisAlignment:
                                                  MainAxisAlignment
                                                      .spaceBetween,
                                              children: [
                                                Text(
                                                  '${(index['resi'])}',
                                                  textAlign: TextAlign.center,
                                                  style: const TextStyle(
                                                    height: 2,
                                                    fontFamily: 'Poppins',
                                                    color: Colors.grey,
                                                    fontSize: 14,
                                                  ),
                                                ),
                                                Expanded(
                                                  child: Container(
                                                    margin: const EdgeInsets
                                                        .symmetric(
                                                        vertical: 10),
                                                    width: double.infinity,
                                                    child: Row(
                                                      children: [
                                                        Column(
                                                          children: [
                                                            Image.asset(
                                                              "assets/icon/pengiriman_icon.png",
                                                            ),
                                                          ],
                                                        ),
                                                        Expanded(
                                                          child: Container(
                                                            margin:
                                                                const EdgeInsets
                                                                    .only(
                                                                    left: 10),
                                                            child: Column(
                                                              children: [
                                                                Expanded(
                                                                  child: SizedBox(
                                                                    child: SingleChildScrollView(
                                                                      physics: const BouncingScrollPhysics(),
                                                                      child: Column(
                                                                        mainAxisAlignment:
                                                                            MainAxisAlignment
                                                                                .spaceBetween,
                                                                        crossAxisAlignment:
                                                                            CrossAxisAlignment
                                                                                .start,
                                                                        children: [
                                                                          Text(
                                                                            '${(index['nama_perusahaan'])}',
                                                                            style:
                                                                                const TextStyle(
                                                                              fontFamily:
                                                                                  'Poppins-bold',
                                                                              color: Colors
                                                                                  .black,
                                                                              fontSize:
                                                                                  12,
                                                                            ),
                                                                          ),
                                                                          Container(
                                                                            padding: EdgeInsets.symmetric(vertical: 5),
                                                                            child: Text(
                                                                              '${(index['alamat_perusahaan'])}',
                                                                              style:
                                                                                  const TextStyle(
                                                                                fontFamily:
                                                                                    'Poppins',
                                                                                color: Colors
                                                                                    .black,
                                                                                fontSize: 9,
                                                                              ),
                                                                            ),
                                                                          ),
                                                                          Column(
                                                                            children: [
                                                                              Row(
                                                                                children: [
                                                                                  const Text(
                                                                                    'Jumlah pemesanan ',
                                                                                    style:
                                                                                        TextStyle(
                                                                                      fontFamily:
                                                                                          'Poppins',
                                                                                      color:
                                                                                          Colors.black,
                                                                                      fontSize:
                                                                                          9,
                                                                                    ),
                                                                                  ),
                                                                                  Text(
                                                                                    '${(index['jumlah_pesanan'].toString())} bar',
                                                                                    style:
                                                                                        const TextStyle(
                                                                                      fontFamily:
                                                                                          'Poppins-bold',
                                                                                      color:
                                                                                          Colors.black,
                                                                                      fontSize:
                                                                                          9,
                                                                                    ),
                                                                                  ),
                                                                                ],
                                                                              ),
                                                                              Row(
                                                                                children: [
                                                                                  const Text(
                                                                                    'Tanggal pemesanan ',
                                                                                    style:
                                                                                        TextStyle(
                                                                                      fontFamily:
                                                                                          'Poppins',
                                                                                      color:
                                                                                          Colors.black,
                                                                                      fontSize:
                                                                                          9,
                                                                                    ),
                                                                                  ),
                                                                                  Text(
                                                                                    '${(index['tanggal_pemesanaan'])}',
                                                                                    style:
                                                                                        const TextStyle(
                                                                                      fontFamily:
                                                                                          'Poppins-bold',
                                                                                      color:
                                                                                          Colors.black,
                                                                                      fontSize:
                                                                                          9,
                                                                                    ),
                                                                                  ),
                                                                                ],
                                                                              ),
                                                                            ],
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
                                                      ],
                                                    ),
                                                  ),
                                                ),
                                                Container(
                                                  margin: const EdgeInsets.only(
                                                      top: 10),
                                                  child: Row(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .spaceAround,
                                                    children: [
                                                      Expanded(
                                                        flex: 1,
                                                        child: InkWell(
                                                          onTap: () {
                                                            print("isi gas");
                                                          },
                                                          child: Container(
                                                            height: 40,
                                                            decoration:
                                                                BoxDecoration(
                                                              color: const Color
                                                                  .fromRGBO(249,
                                                                  1, 131, 1.0),
                                                              borderRadius:
                                                                  BorderRadius
                                                                      .circular(
                                                                          10),
                                                            ),
                                                            child: Center(
                                                              child: Row(
                                                                mainAxisAlignment:
                                                                    MainAxisAlignment
                                                                        .center,
                                                                children: [
                                                                  Image.asset(
                                                                    "assets/icon/isiGas_icon.png",
                                                                  ),
                                                                  Container(
                                                                    padding: const EdgeInsets
                                                                        .symmetric(
                                                                        horizontal:
                                                                            10),
                                                                    child:
                                                                        const Text(
                                                                      "Isi Gas",
                                                                      style:
                                                                          TextStyle(
                                                                        height:
                                                                            2,
                                                                        fontFamily:
                                                                            'Poppins',
                                                                        color: Colors
                                                                            .white,
                                                                        fontSize:
                                                                            10,
                                                                      ),
                                                                    ),
                                                                  ),
                                                                ],
                                                              ),
                                                            ),
                                                          ),
                                                        ),
                                                      ),
                                                      const SizedBox(
                                                        width: 10,
                                                      ),
                                                      Expanded(
                                                        flex: 2,
                                                        child: InkWell(
                                                          onTap: () {
                                                            print(
                                                                "pesanan diterima");
                                                          },
                                                          child: Container(
                                                            height: 40,
                                                            decoration:
                                                                BoxDecoration(
                                                              color: const Color
                                                                  .fromRGBO(249,
                                                                  1, 131, 1.0),
                                                              borderRadius:
                                                                  BorderRadius
                                                                      .circular(
                                                                          10),
                                                            ),
                                                            child: Center(
                                                              child: Row(
                                                                mainAxisAlignment:
                                                                    MainAxisAlignment
                                                                        .center,
                                                                children: [
                                                                  Image.asset(
                                                                    "assets/icon/pesananSelesai_icon.png",
                                                                  ),
                                                                  Container(
                                                                    padding: const EdgeInsets
                                                                        .symmetric(
                                                                        horizontal:
                                                                            10),
                                                                    child:
                                                                        const Text(
                                                                      "Pesanan Diterima",
                                                                      style:
                                                                          TextStyle(
                                                                        height:
                                                                            2,
                                                                        fontFamily:
                                                                            'Poppins',
                                                                        color: Colors
                                                                            .white,
                                                                        fontSize:
                                                                            10,
                                                                      ),
                                                                    ),
                                                                  ),
                                                                ],
                                                              ),
                                                            ),
                                                          ),
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                        );
                                      }).toList(),
                                    ),
                                  ),
                                )
                                // Image.asset(
                                //   "assets/icon/noPengiriman_icon.png",
                                // ),
                                // const Text(
                                //   'Tidak ada pesanan yang harus dikirim',
                                //   textAlign: TextAlign.center,
                                //   style: TextStyle(
                                //     height: 2,
                                //     fontFamily: 'Poppins',
                                //     color: Colors.grey,
                                //     fontSize: 14,
                                //   ),
                                // ),
                              ],
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
        ],
      ),
    );
  }
}
