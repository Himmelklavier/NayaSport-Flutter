import 'dart:io';

import 'package:image_picker/image_picker.dart';

class MyImage {
  ImageSource source;

  MyImage({required this.source});

  Future pick({onPick}) async {
    final ImagePicker picker = ImagePicker();
    final image = await picker.pickImage(source: source);

    if (image != null) {
      // ignore: avoid_print
      print("ya hay imagen");
      onPick(File(image.path));
    } else {
      onPick(null);
    }
  }
}
