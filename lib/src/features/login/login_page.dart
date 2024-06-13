import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';

import '../../constants/color.dart';
import '../../constants/icon.dart';
import '../../widgets/button_icon.dart';
import 'component/login_controller.dart';

class LoginPage extends GetView<LoginController> {
  final _formKey = GlobalKey<FormState>();

  LoginPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
      child: Scaffold(
        backgroundColor: white,
        appBar: AppBar(
          title: const Text(
            "Sign In",
            style: TextStyle(
              fontSize: 16,
              color: gray900,
              fontWeight: FontWeight.w600,
            ),
          ),
          elevation: 0,
        ),
        body: SingleChildScrollView(
          padding: const EdgeInsets.only(
            left: 24,
            right: 24,
          ),
          child: Form(
            key: _formKey,
            child: Column(
              children: [
                const SizedBox(height: 16),
                const SizedBox(
                  width: double.infinity,
                  child: Text(
                    "Hi, Welcome Back",
                    style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
                const SizedBox(
                  height: 4,
                ),
                const SizedBox(
                  width: double.infinity,
                  child: Text(
                    'Sign in to your account.',
                    style: TextStyle(
                      fontSize: 16,
                      color: gray500,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
                const SizedBox(height: 32),
                Column(
                  children: [
                    Row(
                      children: [
                        Expanded(
                          child: RichText(
                            text: const TextSpan(
                              style: TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.w600,
                              ),
                              children: [
                                TextSpan(
                                  text: 'Phone Number',
                                  style: TextStyle(color: gray900),
                                ),
                                TextSpan(
                                  text: ' *',
                                  style: TextStyle(color: red500),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 8),
                    TextFormField(
                      keyboardType: TextInputType.phone,
                      textAlign: TextAlign.start,
                      style: const TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w600,
                          color: gray900),
                      cursorColor: primary,
                      validator: (value) {
                        if (value!.isEmpty) {
                          return 'Phone number can\'t be empty';
                        }

                        if (value.length < 8 || value.length > 16) {
                          return 'Phone number length less than 8 or more than 16';
                        }

                        return null;
                      },
                      inputFormatters: [
                        FilteringTextInputFormatter.deny(RegExp(r'^0+')),
                        FilteringTextInputFormatter(
                          RegExp("[0-9]"),
                          allow: true,
                        )
                      ],
                      decoration: InputDecoration(
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(8.0),
                          borderSide:
                              const BorderSide(color: gray200, width: 1.5),
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(8.0),
                          borderSide:
                              const BorderSide(color: gray200, width: 1.5),
                        ),
                        fillColor: white,
                        filled: true,
                        hintText: 'Phone Number',
                        prefixIcon: GestureDetector(
                          onTap: () => controller.selectCountryCode(context),
                          child: Padding(
                            padding:
                                const EdgeInsets.symmetric(horizontal: 14.0),
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                const SizedBox(width: 6),
                                Obx(() => Text(
                                      '+${controller.selectedCounty.value.phoneCode}',
                                      style: const TextStyle(
                                          fontSize: 14,
                                          fontWeight: FontWeight.w600,
                                          color: gray900),
                                    )),
                                const SizedBox(width: 12),
                                const SizedBox(
                                  width: 1.5,
                                  height: 48,
                                  child: DecoratedBox(
                                    decoration: BoxDecoration(color: gray100),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                      controller: controller.etPhone,
                    ),
                  ],
                ),
                const SizedBox(height: 24),
                Column(
                  children: [
                    Row(
                      children: [
                        Expanded(
                          child: RichText(
                            text: const TextSpan(
                              style: TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.w600,
                              ),
                              children: [
                                TextSpan(
                                  text: 'Password',
                                  style: TextStyle(color: gray900),
                                ),
                                TextSpan(
                                  text: ' *',
                                  style: TextStyle(color: red500),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 8),
                    Obx(() => TextFormField(
                          keyboardType: TextInputType.visiblePassword,
                          textAlign: TextAlign.start,
                          style: const TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.w600,
                              color: gray900),
                          obscureText: controller.isObscure.value,
                          cursorColor: primary,
                          validator: (value) {
                            if (value!.isEmpty) {
                              return 'Password can\'t be empty';
                            }

                            if (value.length < 8) {
                              return 'Password length less than 8';
                            }

                            return null;
                          },
                          decoration: InputDecoration(
                            contentPadding: const EdgeInsets.only(
                              left: 12,
                              right: -14,
                              top: 20,
                              bottom: 20,
                            ),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(8.0),
                              borderSide:
                                  const BorderSide(color: gray200, width: 1.5),
                            ),
                            enabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(8.0),
                              borderSide:
                                  const BorderSide(color: gray200, width: 1.5),
                            ),
                            fillColor: white,
                            filled: true,
                            hintText: 'Password',
                            prefixIcon: const Padding(
                              padding: EdgeInsets.all(14.0),
                              child: ImageIcon(
                                AssetImage(ic_password),
                              ), // icon is 48px widget.
                            ),
                            suffixIcon: GestureDetector(
                              onTap: () {
                                controller.toggleObscure();
                              },
                              child: const Padding(
                                padding: EdgeInsets.all(14.0),
                                child: ImageIcon(
                                  AssetImage(ic_eye),
                                ), // icon is 48px widget.
                              ),
                            ),
                          ),
                          controller: controller.etPassword,
                        )),
                  ],
                ),
                const SizedBox(height: 24),
                Obx(() => loginButton()),
                const SizedBox(height: 16),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget loginButton() => IgnorePointer(
        ignoring: controller.isLoading.value,
        child: SizedBox(
            height: 52,
            width: double.infinity,
            child: SizedBox(
              height: 52,
              width: double.infinity,
              child: ButtonIcon(
                buttonColor: controller.isLoading.value ? gray500 : primary,
                textColor: controller.isLoading.value ? gray600 : white,
                textLabel: "Sign In",
                onClick: () {
                  if (_formKey.currentState!.validate()) {
                    controller.doLogin();
                  }
                },
              ),
            )),
      );
}
