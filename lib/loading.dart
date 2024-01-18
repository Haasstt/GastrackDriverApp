// ignore_for_file: deprecated_member_use

import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

customLoading(BuildContext context) {
  showDialog(
    barrierDismissible: false,
    context: context,
    builder: (context) => WillPopScope(
      onWillPop: () async {
        return false;
      },
      child: Dialog(
        backgroundColor: Colors.transparent,
        elevation: 0,
        insetPadding: const EdgeInsets.all(10),
        child: Stack(
          alignment: Alignment.center,
          children: <Widget>[
            Center(
              child: SizedBox(
                height: MediaQuery.of(context).size.width - 100,
                width: MediaQuery.of(context).size.width - 100,
                child: Lottie.asset('assets/js/custom_loading.json',
                    fit: BoxFit.cover),
              ),
            ),
          ],
        ),
      ),
    ),
  );
}
