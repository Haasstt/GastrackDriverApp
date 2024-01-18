// ignore_for_file: depend_on_referenced_packages, non_constant_identifier_names, avoid_print, file_names, deprecated_member_use, prefer_typing_uninitialized_variables

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:gastrack_driver/page/isigasPage.dart';
import 'package:gastrack_driver/page/pesanditerimaPage.dart';
import 'package:gastrack_driver/page/settingPage.dart';
import 'package:gastrack_driver/page/tariksaldoPage.dart';
import 'package:gastrack_driver/provider/PengirimanProvider.dart';
import 'package:gastrack_driver/provider/UserProvider.dart';
import 'package:intl/intl.dart';
import 'package:liquid_pull_to_refresh/liquid_pull_to_refresh.dart';
import 'package:page_transition/page_transition.dart';
import 'package:shimmer/shimmer.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:sp_util/sp_util.dart';
import 'package:another_flushbar/flushbar.dart';

class Homepage extends StatefulWidget {
  const Homepage({super.key});

  @override
  State<Homepage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<Homepage> {
  List<Map<String, dynamic>> Data = [];
  List<Map<String, dynamic>> DataUser = [];
  bool gagalmemuat = false;
  bool loading = false;
  var message;

  void GetData() {
    Data.clear();
    DataUser.clear();
    setState(() {
      gagalmemuat = false;
      loading = true;
    });

    UserProvider().getDatauser(SpUtil.getInt('id')).then((value) {
      if (value.statusCode == 200) {
        print(value.body);
        var data = value.body['datauser'];
        setState(() {
          DataUser.addAll([data]);
        });

        PengirimanProvider()
            .getDatapengiriman(SpUtil.getInt('id'))
            .then((value) {
          if (value.statusCode == 200) {
            var data = value.body['data'];
            setState(() {
              Data.addAll([data]);
              loading = false;
            });
          } else if (value.statusCode == 422) {
            var pesan = value.body['message'];
            setState(() {
              message = pesan;
              loading = false;
            });
            Flushbar(
              backgroundColor: Colors.red,
              flushbarPosition: FlushbarPosition.TOP,
              margin: const EdgeInsets.all(10),
              borderRadius: BorderRadius.circular(8),
              message: message,
              icon: const Icon(
                Icons.info_outline,
                size: 28.0,
                color: Colors.white,
              ),
              duration: const Duration(seconds: 3),
            ).show(context);
          } else if (value.hasError == true) {
            var pesan = "Gagal Memuat, hubungkan perangkat ke jaringan";
            setState(() {
              message = pesan;
              gagalmemuat = !gagalmemuat;
              loading = false;
            });
            Flushbar(
              backgroundColor: Colors.red,
              flushbarPosition: FlushbarPosition.TOP,
              margin: const EdgeInsets.all(10),
              borderRadius: BorderRadius.circular(8),
              message: message,
              icon: const Icon(
                Icons.info_outline,
                size: 28.0,
                color: Colors.white,
              ),
              duration: const Duration(seconds: 3),
            ).show(context);
          }
        });
      } else if (value.statusCode == 422) {
        var pesan = value.body['message'];
        setState(() {
          message = pesan;
          loading = false;
        });
        Flushbar(
          backgroundColor: Colors.red,
          flushbarPosition: FlushbarPosition.TOP,
          margin: const EdgeInsets.all(10),
          borderRadius: BorderRadius.circular(8),
          message: message,
          icon: const Icon(
            Icons.info_outline,
            size: 28.0,
            color: Colors.white,
          ),
          duration: const Duration(seconds: 3),
        ).show(context);
      } else if (value.hasError == true) {
        var pesan = "Gagal Memuat, hubungkan perangkat ke jaringan";
        setState(() {
          message = pesan;
          gagalmemuat = !gagalmemuat;
          loading = false;
        });
        Flushbar(
          backgroundColor: Colors.red,
          flushbarPosition: FlushbarPosition.TOP,
          margin: const EdgeInsets.all(10),
          borderRadius: BorderRadius.circular(8),
          message: message,
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

  Future<void> _refreshData() async {
    await Future.delayed(const Duration(seconds: 2));
    GetData();
  }

  Future<void> openMap(String latLongString) async {
    // Split the latLongString into latitude and longitude
    List<String> latLongList = latLongString.split(',');

    if (latLongList.length == 2) {
      double latitude = double.parse(latLongList[0]);
      double longitude = double.parse(latLongList[1]);

      final url = "https://maps.google.com/maps?q=$latitude,$longitude";

      try {
        await launch(url);
      } catch (e) {
        // URL cannot be launched, handle the error
        print("Could not launch map $e");
      }
    } else {
      // Handle incorrect latLongString format
      print("Invalid latLongString format");
    }
  }

  @override
  void initState() {
    GetData();
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
      backgroundColor: const Color.fromRGBO(128, 38, 198, 1.0),
      resizeToAvoidBottomInset: false,
      body: LiquidPullToRefresh(
        onRefresh: _refreshData,
        height: 150,
        backgroundColor: const Color.fromRGBO(128, 38, 198, 1.0),
        color: const Color.fromARGB(255, 255, 255, 255),
        animSpeedFactor: 2,
        showChildOpacityTransition: false,
        child: ListView(
            padding: const EdgeInsets.symmetric(vertical: 0.1),
            shrinkWrap: true,
            physics: const AlwaysScrollableScrollPhysics(),
            children: [
              Container(
                color: const Color.fromARGB(255, 255, 255, 255),
                width: MediaQuery.of(context).size.width,
                height: MediaQuery.of(context).size.height,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(
                      flex: 3,
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
                              color: Colors.grey
                                  .withOpacity(0.25), // Warna bayangan
                              spreadRadius:
                                  0, // Seberapa jauh bayangan menyebar
                              blurRadius: 4, // Seberapa kabur bayangan
                              offset:
                                  const Offset(1, 1), // Posisi bayangan (x, y)
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
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 20),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
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
                                            height: 2,
                                            fontFamily: 'Poppins',
                                            color: Colors.white,
                                            fontSize: 12,
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
                                            type:
                                                PageTransitionType.rightToLeft,
                                          ),
                                        );
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
                                margin:
                                    const EdgeInsets.symmetric(horizontal: 20),
                                padding: const EdgeInsets.all(10),
                                decoration: BoxDecoration(
                                  color: const Color.fromRGBO(255, 255, 255, 1),
                                  borderRadius: const BorderRadius.all(
                                      Radius.circular(10)),
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
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Row(
                                      children: [
                                        Image.asset(
                                          "assets/icon/dompet_icon.png",
                                        ),
                                        const SizedBox(
                                          width: 10,
                                        ),
                                        Data.isEmpty
                                            ? Column(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                children: [
                                                  Shimmer.fromColors(
                                                    direction:
                                                        ShimmerDirection.ltr,
                                                    baseColor:
                                                        Colors.grey.shade300,
                                                    highlightColor:
                                                        Colors.grey.shade100,
                                                    child: Container(
                                                      width: 100,
                                                      height: 15,
                                                      decoration: BoxDecoration(
                                                        color: Colors
                                                            .grey.shade300,
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(5),
                                                      ),
                                                    ),
                                                  ),
                                                  const SizedBox(
                                                    height: 10,
                                                  ),
                                                  Shimmer.fromColors(
                                                    direction:
                                                        ShimmerDirection.ltr,
                                                    baseColor:
                                                        Colors.grey.shade300,
                                                    highlightColor:
                                                        Colors.grey.shade100,
                                                    child: Container(
                                                      width: 60,
                                                      height: 15,
                                                      decoration: BoxDecoration(
                                                        color: Colors
                                                            .grey.shade300,
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(5),
                                                      ),
                                                    ),
                                                  ),
                                                ],
                                              )
                                            : Column(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                children: [
                                                  Text(
                                                    DataUser[0]['nama'],
                                                    style: const TextStyle(
                                                      fontFamily:
                                                          'Poppins-bold',
                                                      color: Colors.black,
                                                      fontSize: 14,
                                                    ),
                                                  ),
                                                  const SizedBox(
                                                    height: 2,
                                                  ),
                                                  Text(
                                                    'Rp${(NumberFormat.decimalPattern().format(int.parse(
                                                      DataUser[0]['bop_sopir'],
                                                    )))},-',
                                                    style: const TextStyle(
                                                      fontFamily:
                                                          'Poppins-bold',
                                                      color: Colors.black,
                                                      fontSize: 14,
                                                    ),
                                                  ),
                                                ],
                                              ),
                                      ],
                                    ),
                                    Container(
                                      padding: const EdgeInsets.only(
                                        right: 5,
                                        top: 4,
                                      ),
                                      child: Row(
                                        children: [
                                          GestureDetector(
                                            onTap: () {
                                              Navigator.push(
                                                context,
                                                PageTransition(
                                                  child: TarikSaldoPage(
                                                    saldo: DataUser[0]['bop_sopir'],
                                                  ),
                                                  type: PageTransitionType
                                                      .rightToLeft,
                                                ),
                                              );
                                            },
                                            child: Column(
                                              children: [
                                                Image.asset(
                                                  "assets/icon/tariktunai_icon.png",
                                                ),
                                                const SizedBox(
                                                  height: 2,
                                                ),
                                                const Text(
                                                  'Tarik Tunai',
                                                  style: TextStyle(
                                                    fontFamily: 'Poppins',
                                                    color: Colors.black,
                                                    fontSize: 6,
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                          const SizedBox(
                                            width: 10,
                                          ),
                                          Column(
                                            children: [
                                              Image.asset(
                                                "assets/icon/riwayatpenarikan_icon.png",
                                              ),
                                              const SizedBox(
                                                height: 2,
                                              ),
                                              const Text(
                                                'Riwayat',
                                                style: TextStyle(
                                                  fontFamily: 'Poppins',
                                                  color: Colors.black,
                                                  fontSize: 6,
                                                ),
                                              ),
                                            ],
                                          ),
                                        ],
                                      ),
                                    ),
                                  ],
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
                      flex: 2,
                      child: Container(
                        margin: const EdgeInsets.only(top: 25),
                        width: MediaQuery.of(context).size.width,
                        decoration: BoxDecoration(
                          color: const Color.fromARGB(255, 255, 255, 255),
                          borderRadius: const BorderRadius.only(
                            topLeft: Radius.circular(20),
                            topRight: Radius.circular(20),
                          ),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.grey
                                  .withOpacity(0.25), // Warna bayangan
                              spreadRadius:
                                  4, // Seberapa jauh bayangan menyebar
                              blurRadius: 4, // Seberapa kabur bayangan
                              offset:
                                  const Offset(1, 1), // Posisi bayangan (x, y)
                            ),
                          ],
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Container(
                              padding: const EdgeInsets.only(
                                top: 15,
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
                                child: Data.isEmpty
                                    ? loading
                                        ? const Column(
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            children: [
                                              CircularProgressIndicator(
                                                strokeWidth: 2,
                                                color: Color.fromRGBO(
                                                    249, 1, 131, 1.0),
                                              )
                                            ],
                                          )
                                        : gagalmemuat
                                            ? Column(
                                                mainAxisAlignment:
                                                    MainAxisAlignment.center,
                                                children: [
                                                  Text(
                                                    message,
                                                    textAlign: TextAlign.center,
                                                    style: const TextStyle(
                                                      height: 2,
                                                      fontFamily: 'Poppins',
                                                      color: Colors.grey,
                                                      fontSize: 14,
                                                    ),
                                                  ),
                                                  butonReload()
                                                ],
                                              )
                                            : Column(
                                                mainAxisAlignment:
                                                    MainAxisAlignment.center,
                                                children: [
                                                  Image.asset(
                                                    "assets/icon/noPengiriman_icon.png",
                                                  ),
                                                  const Text(
                                                    'Tidak ada pesanan yang harus dikirim',
                                                    textAlign: TextAlign.center,
                                                    style: TextStyle(
                                                      height: 2,
                                                      fontFamily: 'Poppins',
                                                      color: Colors.grey,
                                                      fontSize: 14,
                                                    ),
                                                  ),
                                                ],
                                              )
                                    : Data_ada_page(context),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ]),
      ),
    );
  }

  InkWell butonReload() {
    return InkWell(
      onTap: () {
        GetData();
      },
      child: Container(
        decoration: BoxDecoration(
            color: Colors.grey.shade400,
            borderRadius: const BorderRadius.all(Radius.circular(10))),
        width: 150,
        margin: const EdgeInsets.symmetric(vertical: 10),
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.refresh_rounded,
              color: Colors.grey.shade100,
            ),
            Padding(
              padding: const EdgeInsets.only(left: 5),
              child: Text(
                'Muat ulang',
                style: TextStyle(
                    fontFamily: 'Poppins', color: Colors.grey.shade100),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Column Data_ada_page(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Expanded(
          child: Container(
            margin: const EdgeInsets.symmetric(
              vertical: 10,
              horizontal: 10,
            ),
            padding: const EdgeInsets.symmetric(
              horizontal: 20,
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
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
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
                            margin: const EdgeInsets.symmetric(vertical: 10),
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
                                    margin: const EdgeInsets.only(left: 10),
                                    child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          '${(index['nama_perusahaan'])}',
                                          style: const TextStyle(
                                            fontFamily: 'Poppins-bold',
                                            color: Colors.black,
                                            fontSize: 14,
                                          ),
                                        ),
                                        Row(
                                          children: [
                                            Expanded(
                                              child: Text(
                                                '${(index['alamat_perusahaan'])}',
                                                style: const TextStyle(
                                                  fontFamily: 'Poppins',
                                                  color: Colors.black,
                                                  fontSize: 10,
                                                ),
                                              ),
                                            ),
                                            InkWell(
                                              onTap: () {
                                                openMap(
                                                    '${(index['koordinat'])}');
                                              },
                                              child: Container(
                                                margin:
                                                    const EdgeInsets.symmetric(
                                                        horizontal: 10),
                                                decoration: BoxDecoration(
                                                  color: const Color.fromRGBO(
                                                      249, 1, 131, 1.0),
                                                  borderRadius:
                                                      BorderRadius.circular(50),
                                                ),
                                                child: Container(
                                                  margin:
                                                      const EdgeInsets.all(5),
                                                  width: 50,
                                                  height: 50,
                                                  child: Column(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .center,
                                                    children: [
                                                      const FaIcon(
                                                        FontAwesomeIcons
                                                            .mapLocation,
                                                        color: Colors.white,
                                                        size: 15,
                                                      ),
                                                      Container(
                                                        padding:
                                                            const EdgeInsets
                                                                .only(top: 3),
                                                        child: const Text(
                                                          'Map',
                                                          style: TextStyle(
                                                            fontFamily:
                                                                'Poppins',
                                                            color: Colors.white,
                                                            fontSize: 10,
                                                          ),
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                              ),
                                            )
                                          ],
                                        ),
                                        Column(
                                          children: [
                                            Row(
                                              children: [
                                                const Text(
                                                  'Jumlah pemesanan ',
                                                  style: TextStyle(
                                                    fontFamily: 'Poppins',
                                                    color: Colors.black,
                                                    fontSize: 10,
                                                  ),
                                                ),
                                                Text(
                                                  '${(index['jumlah_pesanan'].toString())} bar',
                                                  style: const TextStyle(
                                                    fontFamily: 'Poppins-bold',
                                                    color: Colors.black,
                                                    fontSize: 10,
                                                  ),
                                                ),
                                              ],
                                            ),
                                            Row(
                                              children: [
                                                const Text(
                                                  'Tanggal pemesanan ',
                                                  style: TextStyle(
                                                    fontFamily: 'Poppins',
                                                    color: Colors.black,
                                                    fontSize: 10,
                                                  ),
                                                ),
                                                Text(
                                                  '${(index['tanggal_pemesanaan'])}',
                                                  style: const TextStyle(
                                                    fontFamily: 'Poppins-bold',
                                                    color: Colors.black,
                                                    fontSize: 10,
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
                              ],
                            ),
                          ),
                        ),
                        Container(
                          margin: const EdgeInsets.symmetric(vertical: 10),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: [
                              Expanded(
                                flex: 1,
                                child: InkWell(
                                  onTap: () {
                                    Navigator.push(
                                      context,
                                      PageTransition(
                                        child: IsigasPage(
                                          id: index['id_pengiriman'],
                                        ),
                                        type: PageTransitionType.rightToLeft,
                                      ),
                                    );
                                  },
                                  child: Container(
                                    height: 40,
                                    decoration: BoxDecoration(
                                      color: const Color.fromRGBO(
                                          249, 1, 131, 1.0),
                                      borderRadius: BorderRadius.circular(10),
                                    ),
                                    child: Center(
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          Image.asset(
                                            "assets/icon/isiGas_icon.png",
                                          ),
                                          Container(
                                            padding: const EdgeInsets.symmetric(
                                                horizontal: 10),
                                            child: const Text(
                                              "Isi Gas",
                                              style: TextStyle(
                                                height: 2,
                                                fontFamily: 'Poppins',
                                                color: Colors.white,
                                                fontSize: 10,
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
                                    Navigator.push(
                                      context,
                                      PageTransition(
                                        child: PesananDiterimaPage(
                                          id: index['id_pengiriman'],
                                        ),
                                        type: PageTransitionType.rightToLeft,
                                      ),
                                    );
                                  },
                                  child: Container(
                                    height: 40,
                                    decoration: BoxDecoration(
                                      color: const Color.fromRGBO(
                                          249, 1, 131, 1.0),
                                      borderRadius: BorderRadius.circular(10),
                                    ),
                                    child: Center(
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          Image.asset(
                                            "assets/icon/pesananSelesai_icon.png",
                                          ),
                                          Container(
                                            padding: const EdgeInsets.symmetric(
                                                horizontal: 10),
                                            child: const Text(
                                              "Pesanan Diterima",
                                              style: TextStyle(
                                                height: 2,
                                                fontFamily: 'Poppins',
                                                color: Colors.white,
                                                fontSize: 10,
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
    );
  }
}
