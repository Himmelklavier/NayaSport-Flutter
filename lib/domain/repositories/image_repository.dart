import 'dart:io';
import 'package:image_picker/image_picker.dart';
import 'package:prueba/domain/entities/image.dart';

abstract class ImageRepository {
  Future pick({onPick, MyImage? source}) async {
    final ImagePicker picker = ImagePicker();
    final image = await picker.pickImage(source: ImageSource.gallery);
    if (image != null) {
      onPick(File(image.path));
    } else {
      onPick(null);
    }
  }
}
