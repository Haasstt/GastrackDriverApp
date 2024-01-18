// ignore_for_file: depend_on_referenced_packages, file_names, non_constant_identifier_names

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

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
      {"label": "3", "value": "3"},
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

  @override
  void initState() {
    super.initState();
    txtSaldo.text = "Rp";
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
                SizedBox(
                  width: MediaQuery.of(context).size.width,
                  child: Text(
                    txtSaldo.text,
                    style: TextStyle(
                      fontFamily: 'Poppins-bold',
                      color:
                          txtSaldo.text != "Rp" ? Colors.black : Colors.black38,
                      fontSize: 25,
                    ),
                  ),
                ),
              ],
            ),
          ),
          SizedBox(
            height: MediaQuery.of(context).size.height,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Container(
                  height: MediaQuery.of(context).size.height * 0.40,
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
                  child: Expanded(
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
                                    onTap: () {},
                                    child: Container(
                                      padding: const EdgeInsets.all(10),
                                      margin: const EdgeInsets.symmetric(
                                          horizontal: 5, vertical: 5),
                                      height: 60,
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
                )
              ],
            ),
          )
        ],
      ),
    );
  }
}
