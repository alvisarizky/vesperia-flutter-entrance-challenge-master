import 'package:image_picker/image_picker.dart';

class ImageUtil {
  Future<XFile?> pickImage(
    ImageSource source, {
    int imageQuality = 50,
  }) async {
    final imageFile = await ImagePicker().pickImage(
      source: source,
      imageQuality: imageQuality,
    );

    switch (imageFile) {
      case null:
        return null;
      default:
        return imageFile;
    }
  }
}
