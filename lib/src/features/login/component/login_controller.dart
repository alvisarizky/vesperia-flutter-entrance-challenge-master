import 'package:country_picker/country_picker.dart';
import 'package:entrance_test/src/constants/local_data_key.dart';
import 'package:entrance_test/src/repositories/user_repository.dart';
import 'package:entrance_test/src/utils/networking_util.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

import '../../../../app/routes/route_name.dart';
import '../../../widgets/snackbar_widget.dart';

class LoginController extends GetxController {
  final UserRepository _userRepository;

  LoginController({
    required UserRepository userRepository,
  }) : _userRepository = userRepository;

  final etPhone = TextEditingController();
  final etPassword = TextEditingController();
  var selectedCounty = Country(
    phoneCode: '62',
    countryCode: 'ID',
    e164Sc: 0,
    geographic: true,
    level: 1,
    name: 'Indonesia',
    example: 'Indonesia',
    displayName: 'Indonesia',
    displayNameNoCountryCode: 'ID',
    e164Key: '',
  ).obs;

  RxBool isLoading = false.obs;
  RxBool isObscure = true.obs;

  void selectCountryCode(BuildContext context) {
    showCountryPicker(
      context: context,
      countryListTheme: CountryListThemeData(
        bottomSheetHeight: MediaQuery.of(context).size.height * 0.6,
      ),
      onSelect: (value) {
        selectedCounty = value.obs;
      },
    );
  }

  void doLogin() async {
    isLoading.value = !isLoading.value;
    await _userRepository
        .login(
          phoneNumber: etPhone.text,
          password: etPassword.text,
          countryCode: selectedCounty.value.phoneCode,
        )
        .then(
          (value) => value.fold((l) {
            print("LEFT : $l");
            isLoading.value = !isLoading.value;
            return SnackbarWidget.showFailedSnackbar(l);
          }, (r) async {
            isLoading.value = !isLoading.value;
            await GetStorage().write(LocalDataKey.token, r);
            Get.offAllNamed(RouteName.dashboard);
          }),
        );
  }

  void doLogout() async {
    isLoading.value = !isLoading.value;

    final result = await _userRepository.logout();

    result.fold(
      (dioError) {
        SnackbarWidget.showFailedSnackbar(
          NetworkingUtil.errorMessage(dioError),
        );
        isLoading.value = !isLoading.value;
        return;
      },
      (_) {
        isLoading.value = !isLoading.value;
        Get.offAllNamed(RouteName.login);
      },
    );
  }

  void toggleObscure() {
    isObscure.value = !isObscure.value;
  }
}
