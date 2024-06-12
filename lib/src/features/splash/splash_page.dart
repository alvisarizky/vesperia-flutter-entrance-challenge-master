import 'package:entrance_test/src/constants/color.dart';
import 'package:entrance_test/src/constants/image.dart';
import 'package:entrance_test/src/features/splash/component/splash_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SplashPage extends GetView<SplashController> {
  const SplashPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: double.infinity,
        height: double.infinity,
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              gray500,
              gray100,
              red50,
              red600,
            ],
          ),
        ),
        child: Stack(
          children: [
            Center(
              child: Image.asset(
                appLogoImage,
                width: MediaQuery.of(context).size.width * .405,
                height: MediaQuery.of(context).size.width * .405,
              ),
            ),
            Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  const Text(
                    'Ver: 18.1.20',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w500,
                      color: white,
                    ),
                  ),
                  SizedBox(height: MediaQuery.of(context).size.width * .088),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
