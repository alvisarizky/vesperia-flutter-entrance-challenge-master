import 'package:carousel_slider/carousel_slider.dart';
import 'package:entrance_test/src/constants/color.dart';
import 'package:entrance_test/src/features/boarding/component/boarding_controller.dart';
import 'package:entrance_test/src/widgets/button_icon.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class BoardingPage extends GetView<BoardingController> {
  const BoardingPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: white,
      body: SafeArea(
        child: Column(
          children: [
            Obx(() => CarouselSlider(
                carouselController: controller.carouselController,
                items: List.generate(
                    controller.carouselItems.length,
                    (index) => Stack(
                          children: [
                            AspectRatio(
                              aspectRatio: 1 / 1,
                              child: Image.asset(
                                controller.carouselItems[
                                    controller.currentIndex.value]['image']!,
                                fit: BoxFit.fitWidth,
                              ),
                            ),
                            AspectRatio(
                              aspectRatio: 1 / 1,
                              child: Container(
                                width: double.infinity,
                                height: double.infinity,
                                decoration: BoxDecoration(
                                  gradient: LinearGradient(
                                    begin: Alignment.topCenter,
                                    end: Alignment.bottomCenter,
                                    colors: [
                                      red50.withOpacity(0.1),
                                      white,
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          ],
                        )),
                options: CarouselOptions(
                  aspectRatio: 1 / 1,
                  viewportFraction: 1,
                  enableInfiniteScroll: false,
                  scrollPhysics: const NeverScrollableScrollPhysics(),
                  onPageChanged: (index, reason) {
                    controller.changePageIndex(index);
                  },
                ))),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.all(24.0),
                child: Obx(() => Column(children: [
                      const SizedBox(height: 24),
                      Text(
                        controller.carouselItems[controller.currentIndex.value]
                            ['title']!,
                        style: const TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.w700,
                          color: gray900,
                        ),
                      ),
                      const SizedBox(height: 8),
                      Text(
                        controller.carouselItems[controller.currentIndex.value]
                            ['subtitle']!,
                        style: const TextStyle(
                          fontSize: 16,
                          color: gray900,
                        ),
                        textAlign: TextAlign.center,
                      ),
                      const SizedBox(height: 32),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: List.generate(
                          4,
                          (index) => Container(
                            width: 8,
                            height: 8,
                            margin:
                                EdgeInsets.only(right: index + 1 != 4 ? 8 : 0),
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              color: controller.currentIndex.value == index
                                  ? primary
                                  : gray500,
                            ),
                          ),
                        ),
                      ),
                      const Spacer(),
                      controller.currentIndex.value + 1 == 4
                          ? SizedBox(
                              width: double.infinity,
                              height: 52,
                              child: ButtonIcon(
                                onClick: () {
                                  controller.navigateToLogin();
                                },
                                textLabel: 'Finish',
                                buttonColor: primary,
                                textColor: white,
                              ),
                            )
                          : Row(
                              children: [
                                Expanded(
                                  child: SizedBox(
                                    height: 52,
                                    child: ButtonIcon(
                                      onClick: () {
                                        controller.navigateToLogin();
                                      },
                                      textLabel: 'SKIP',
                                      textColor: primary,
                                    ),
                                  ),
                                ),
                                const SizedBox(width: 16),
                                Expanded(
                                  child: SizedBox(
                                    height: 52,
                                    child: ButtonIcon(
                                      onClick: () {
                                        controller.carouselController
                                            .nextPage();
                                      },
                                      textLabel: 'NEXT',
                                      buttonColor: primary,
                                      textColor: white,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                    ])),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
