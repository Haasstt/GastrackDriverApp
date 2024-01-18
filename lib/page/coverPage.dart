// ignore_for_file: file_names

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:gastrack_driver/controller/Authcontroller.dart';

class Coverpage extends StatefulWidget {
  const Coverpage({super.key});

  @override
  State<Coverpage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<Coverpage> {
  final LoginController _loginController = LoginController();
  bool _isPasswordVisible = true;

  void _togglePasswordVisibility() {
    setState(() {
      _isPasswordVisible = !_isPasswordVisible;
    });
  }

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
      statusBarColor: Colors.transparent,
      statusBarBrightness: Brightness.light,
    ));
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Stack(
        children: [
          SizedBox(
            width: double.maxFinite,
            height: double.infinity,
            child: Image.asset(
              "assets/bg/bg_cover.png",
              fit: BoxFit.cover,
            ),
          ),
          Positioned.fill(
            child: SizedBox(
              child: Container(
                color: const Color.fromARGB(147, 0, 0, 0),
              ),
            ),
          ),
          Positioned.fill(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Spacer(),
                  Padding(
                    padding: const EdgeInsets.symmetric(
                      vertical: 30,
                    ),
                    child: Image.asset(
                      "assets/icon/logo.png",
                      width: 30,
                    ),
                  ),
                  const Text(
                    "Menjadi",
                    style: TextStyle(
                        color: Colors.white,
                        fontFamily: 'Poppins-ExtraBold',
                        fontSize: 28,
                        fontWeight: FontWeight.bold),
                  ),
                  const Text(
                    "Pengemudi yang",
                    style: TextStyle(
                        color: Colors.white,
                        fontFamily: 'Poppins-ExtraBold',
                        fontSize: 28,
                        height: 1.2,
                        fontWeight: FontWeight.bold),
                  ),
                  const Row(
                    children: [
                      Text(
                        "Aman ",
                        style: TextStyle(
                            color: Color.fromRGBO(249, 1, 131, 1.0),
                            fontFamily: 'Poppins-ExtraBold',
                            fontSize: 28,
                            height: 1.2,
                            fontWeight: FontWeight.bold),
                      ),
                      Text(
                        "dan ",
                        style: TextStyle(
                            color: Colors.white,
                            fontFamily: 'Poppins-ExtraBold',
                            fontSize: 28,
                            height: 1.2,
                            fontWeight: FontWeight.bold),
                      ),
                      Text(
                        "Terpercaya",
                        style: TextStyle(
                            color: Color.fromRGBO(249, 1, 131, 1.0),
                            fontFamily: 'Poppins-ExtraBold',
                            fontSize: 28,
                            height: 1.2,
                            fontWeight: FontWeight.bold),
                      ),
                    ],
                  ),
                  const Spacer(),
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 30),
                    child: Container(
                      width: double.infinity,
                      height: 60,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(40),
                      ),
                      child: TextButton(
                        style: TextButton.styleFrom(
                          backgroundColor:
                              const Color.fromRGBO(249, 1, 131, 1.0),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(40),
                          ),
                        ),
                        onPressed: () {
                          _showPopupLogin(context);
                        },
                        child: const Padding(
                          padding: EdgeInsets.symmetric(horizontal: 60),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                "Masuk",
                                style: TextStyle(
                                  fontFamily: 'Poppins',
                                  fontSize: 15,
                                  color: Color.fromRGBO(255, 255, 255, 1),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  )
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  void _showPopupLogin(BuildContext context) async {
    showGeneralDialog(
        barrierDismissible: true,
        barrierLabel: 'Sign In',
        context: context,
        transitionDuration: const Duration(milliseconds: 400),
        transitionBuilder: (context, animation, secondaryAnimation, child) {
          Tween<Offset> tween;
          tween = Tween(begin: const Offset(0, 1), end: Offset.zero);
          return SlideTransition(
            position: tween.animate(
              CurvedAnimation(parent: animation, curve: Curves.easeInOut),
            ),
            child: child,
          );
        },
        pageBuilder: (context, _, __) {
          return StatefulBuilder(builder: (BuildContext context, setState) {
            return Scaffold(
              backgroundColor: Colors.transparent,
              body: Stack(
                children: [
                  Column(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Container(
                        decoration: const BoxDecoration(
                          color: Color.fromARGB(255, 246, 246, 246),
                          borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(30),
                            topRight: Radius.circular(30),
                          ),
                        ),
                        child: Column(
                          children: [
                            Padding(
                              padding: const EdgeInsets.symmetric(vertical: 20),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  const Padding(
                                    padding: EdgeInsets.only(left: 20),
                                    child: Icon(
                                      Icons.close_sharp,
                                      color: Color.fromARGB(255, 246, 246, 246),
                                    ),
                                  ),
                                  const Text(
                                    "Login",
                                    style: TextStyle(
                                        color: Color.fromRGBO(249, 1, 131, 1.0),
                                        fontFamily: 'Poppins-bold',
                                        fontSize: 22,
                                        fontWeight: FontWeight.bold),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.only(right: 10),
                                    child: IconButton(
                                      onPressed: () {
                                        Navigator.pop(context);
                                      },
                                      icon: const Icon(Icons.close_sharp),
                                    ),
                                  )
                                ],
                              ),
                            ),
                            Form(
                              child: Column(
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 15, vertical: 5),
                                    child: TextFormField(
                                      keyboardType: TextInputType.emailAddress,
                                      controller: _loginController.txtEmail,
                                      decoration: const InputDecoration(
                                        prefixIcon: Padding(
                                          padding: EdgeInsets.symmetric(
                                              horizontal: 20),
                                          child: Icon(Icons.email_outlined),
                                        ),
                                        border: OutlineInputBorder(
                                          borderRadius: BorderRadius.all(
                                              Radius.circular(10)),
                                        ),
                                        labelText: "Email",
                                        filled: true,
                                        fillColor: Colors.white,
                                      ),
                                      style: const TextStyle(
                                        fontFamily: 'Poppins',
                                      ),
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 15, vertical: 5),
                                    child: TextFormField(
                                      controller: _loginController.txtPass,
                                      obscureText: _isPasswordVisible,
                                      decoration: const InputDecoration(
                                        prefixIcon: Padding(
                                          padding: EdgeInsets.symmetric(
                                              horizontal: 20),
                                          child: Icon(Icons.lock_outline),
                                        ),
                                        border: OutlineInputBorder(
                                          borderRadius: BorderRadius.all(
                                              Radius.circular(10)),
                                        ),
                                        labelText: "Password",
                                        filled: true,
                                        fillColor: Colors.white,
                                      ),
                                      style: const TextStyle(
                                        fontFamily: 'Poppins',
                                      ),
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 15),
                                    child: Row(
                                      children: [
                                        IconButton(
                                          icon: Icon(
                                            _isPasswordVisible
                                                ? Icons.check_box_outline_blank
                                                : Icons.check_box_rounded,
                                            color: Colors.grey,
                                          ),
                                          onPressed: () {
                                            _togglePasswordVisibility();
                                            setState(() {});
                                          },
                                        ),
                                        const Text(
                                          "Tampilkan sandi",
                                          style: TextStyle(
                                              color: Color.fromRGBO(
                                                  47, 47, 47, 1.0),
                                              fontFamily: 'Poppins',
                                              fontSize: 14,
                                              fontWeight: FontWeight.normal),
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 15, vertical: 15),
                              child: SizedBox(
                                height: 60,
                                width: double.infinity,
                                child: ElevatedButton(
                                  style: TextButton.styleFrom(
                                    backgroundColor:
                                        const Color.fromRGBO(249, 1, 131, 1.0),
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(10),
                                    ),
                                  ),
                                  onPressed: () {
                                    FocusManager.instance.primaryFocus
                                        ?.unfocus();
                                    _loginController.auth(context);
                                  },
                                  child: const Text(
                                    "L O G I N",
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
                    ],
                  ),
                ],
              ),
            );
          });
        });
  }
}
