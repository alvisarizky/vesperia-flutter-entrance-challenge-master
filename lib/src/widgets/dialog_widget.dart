import 'package:entrance_test/src/widgets/button_icon.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../constants/color.dart';

class DialogWidget {
  static void showInformationDialog(
    String message, {
    bool isDismissible = false,
    List<Widget>? actions,
  }) {
    Get.dialog(
        barrierDismissible: isDismissible,
        AlertDialog(
          title: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text('Information Dialog',
                  textAlign: TextAlign.start,
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.w600,
                  )),
              IconButton(
                onPressed: () {
                  Get.back();
                },
                icon: Icon(Icons.close_rounded),
              )
            ],
          ),
          backgroundColor: white,
          content: Text(message,
              textAlign: TextAlign.start,
              style: const TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w500,
              )),
          actions: actions,
        ));
  }

  static void showAlertDialog(
    String message, {
    bool isDismissible = false,
    List<Widget>? actions,
  }) {
    Get.dialog(
        barrierDismissible: isDismissible,
        AlertDialog(
          title: const Text('Alert Dialog',
              textAlign: TextAlign.start,
              style: TextStyle(
                fontSize: 18,
                color: red600,
                fontWeight: FontWeight.w600,
              )),
          backgroundColor: red50,
          content: Text(message,
              textAlign: TextAlign.start,
              style: const TextStyle(
                fontSize: 14,
                color: red600,
                fontWeight: FontWeight.w500,
              )),
          actions: [
            ButtonIcon(
              onClick: () {
                Get.back();
              },
              textLabel: 'No',
              buttonColor: Colors.transparent,
              borderColor: red600,
              textColor: red600,
            ),
            ...?actions,
          ],
        ));
  }
}
