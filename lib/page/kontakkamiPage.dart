// ignore_for_file: depend_on_referenced_packages, file_names, non_constant_identifier_names, avoid_print, deprecated_member_use
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:gastrack_driver/animation/BounceAnimation.dart';
import 'package:gastrack_driver/animation/animations.dart';
import 'package:url_launcher/url_launcher.dart';

class KontakKamiPage extends StatefulWidget {
  const KontakKamiPage({super.key});

  @override
  State<KontakKamiPage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<KontakKamiPage> {
  String phoneNumber = "6281949684140";
  String instagramUsername = "haasstt_";
  String emailAddress = "nurafiifalmasazhr@gmail.com";
  String subject = "Hallo Admin Gastrack!!!";

  Future<void> openWhatsApp() async {
    final url = "https://wa.me/$phoneNumber";
    try {
      await launch(url);
    } catch (e) {
      // URL tidak dapat diakses, mungkin WhatsApp tidak terinstal
      print("Could not launch $url");
    }
  }

  Future<void> openInstagram() async {
    final url = "https://www.instagram.com/direct/t/102046197858140";
    try {
      await launch(url);
    } catch (e) {
      // URL cannot be launched, Instagram might not be installed
      print("Could not launch $url");
    }
  }

  Future<void> sendEmail() async {
    final url = Uri.encodeFull('mailto:$emailAddress?subject=$subject');

    try {
      await launch(url);
    } catch (e) {
      // URL cannot be launched, handle the error
      print("Could not launch email");
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
            padding: const EdgeInsets.only(
                top: 120, left: 10, right: 10, bottom: 10),
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 10),
              width: double.infinity,
              height: MediaQuery.of(context).size.height,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  FadeAnimation(
                    0.5,
                    Image.asset(
                      "assets/icon/img_home.png",
                    ),
                  ),
                  FadeAnimation(
                    0.6,
                    Column(
                      children: [
                        const Text(
                          'Hubungi Kami',
                          style: TextStyle(
                            fontWeight: FontWeight.normal,
                            fontSize: 20,
                            fontFamily: 'Poppins-bold',
                            color: Color.fromRGBO(249, 1, 131, 1.0),
                          ),
                        ),
                        Container(
                          margin: const EdgeInsets.symmetric(vertical: 15),
                          child: const Text(
                            'Anda dapat menghubungi kami kapan pun dan dimana pun melalui',
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              fontWeight: FontWeight.normal,
                              fontSize: 12,
                              fontFamily: 'Poppins',
                              color: Colors.black,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Column(
                    children: [
                      BounceAnimation(
                        0.6,
                        InkWell(
                          onTap: () async {
                            openWhatsApp();
                          },
                          child: Container(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 20, vertical: 10),
                            width: double.infinity,
                            decoration: BoxDecoration(
                                borderRadius:
                                    const BorderRadius.all(Radius.circular(10)),
                                border: Border.all(
                                    width: 1, color: Colors.black87)),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                const Row(
                                  children: [
                                    FaIcon(FontAwesomeIcons.whatsapp,
                                        size: 50, color: Colors.black),
                                    SizedBox(
                                      width: 10,
                                    ),
                                    Text(
                                      'WhatsApp',
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
                      BounceAnimation(
                        0.7,
                        InkWell(
                          onTap: () {
                            openInstagram();
                          },
                          child: Container(
                            margin: const EdgeInsets.symmetric(vertical: 20),
                            padding: const EdgeInsets.symmetric(
                                horizontal: 20, vertical: 10),
                            width: double.infinity,
                            decoration: BoxDecoration(
                                borderRadius:
                                    const BorderRadius.all(Radius.circular(10)),
                                border: Border.all(
                                    width: 1, color: Colors.black87)),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                const Row(
                                  children: [
                                    FaIcon(FontAwesomeIcons.instagram,
                                        size: 50, color: Colors.black),
                                    SizedBox(
                                      width: 10,
                                    ),
                                    Text(
                                      'Instagram',
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
                      BounceAnimation(
                        0.8,
                        InkWell(
                          onTap: () {
                            sendEmail();
                          },
                          child: Container(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 20, vertical: 10),
                            width: double.infinity,
                            decoration: BoxDecoration(
                                borderRadius:
                                    const BorderRadius.all(Radius.circular(10)),
                                border: Border.all(
                                    width: 1, color: Colors.black87)),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                const Row(
                                  children: [
                                    Icon(Icons.email_outlined,
                                        size: 50, color: Colors.black),
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
                    "Kontak Kami",
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
