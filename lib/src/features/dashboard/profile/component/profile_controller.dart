import 'package:entrance_test/src/constants/color.dart';
import 'package:entrance_test/src/repositories/user_repository.dart';
import 'package:entrance_test/src/widgets/button_icon.dart';
import 'package:entrance_test/src/widgets/dialog_widget.dart';
import 'package:get/get.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../../../../app/routes/route_name.dart';
import '../../../../utils/networking_util.dart';
import '../../../../widgets/snackbar_widget.dart';

class ProfileController extends GetxController {
  final UserRepository _userRepository;

  final _name = "".obs;

  String get name => _name.value;

  final _phone = "".obs;

  String get phone => _phone.value;

  final _profilePictureUrl = "".obs;

  String get profilePictureUrl => _profilePictureUrl.value;

  RxBool isLoading = false.obs;

  ProfileController({
    required UserRepository userRepository,
  }) : _userRepository = userRepository;

  @override
  void onInit() {
    super.onInit();
    loadUserFromServer();
  }

  void loadUserFromServer() async {
    try {
      final response = await _userRepository.getUser();
      if (response.status == 0) {
        final localUser = response.data;

        _name.value = localUser.name;
        _phone.value = localUser.countryCode.isNotEmpty
            ? "+${localUser.countryCode}${localUser.phone}"
            : "";
        _profilePictureUrl.value = localUser.profilePicture ?? '';

        _name.refresh();
        _profilePictureUrl.refresh();
      } else {
        SnackbarWidget.showFailedSnackbar(response.message);
      }
    } catch (error) {
      SnackbarWidget.showFailedSnackbar(NetworkingUtil.errorMessage(error));
    }
  }

  onUpdateProfile({String? name, String? profilePictureUrl}) async {
    if (name != null) {
      _name.value = name;
      _name.refresh();
    }

    if (profilePictureUrl != null) {
      _profilePictureUrl.value = profilePictureUrl;
      _profilePictureUrl.refresh();
    }
  }

  onEditProfileClick() async {
    Get.toNamed(RouteName.editProfile);
  }

  /*
    This Function is used as challenge tester
    DO NOT modify this function
   */
  onTestUnauthenticatedClick() async {
    await _userRepository.testUnauthenticated();
  }

  onDownloadFileClick() async {
    await _userRepository.downloadFileFromUrl();
  }

  onOpenWebPageClick() async {
    await launchUrl(
      Uri.parse('https://www.youtube.com/watch?v=lpnKWK-KEYs'),
      mode: LaunchMode.inAppWebView,
    );
  }

  void doLogout() async {
    DialogWidget.showAlertDialog('Are you sure to logout?', actions: [
      ButtonIcon(
        onClick: () async {
          Get.back();
          await _userRepository.logout().then(
                (value) => value.fold((l) {
                  isLoading.value = !isLoading.value;
                  return SnackbarWidget.showFailedSnackbar(l);
                }, (r) async {
                  isLoading.value = !isLoading.value;
                  Get.offAllNamed(RouteName.login);
                }),
              );
        },
        textLabel: 'Yes',
        buttonColor: red600,
        textColor: white,
      ),
    ]);
  }
}
