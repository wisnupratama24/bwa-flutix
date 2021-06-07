import 'dart:io';

import 'package:bwa_flutix/shared/shared.dart';
import 'package:image_picker/image_picker.dart';

Future<File> getImage() async {
  File _image;
  final picker = ImagePicker();
  final pickedFile = await picker.getImage(source: ImageSource.gallery);

  if (pickedFile != null) {
    _image = File(pickedFile.path);
  } else {
    _image = File(defaultUserPict);
  }

  return _image;
}
