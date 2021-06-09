part of 'shared.dart';

Future<File> getImage() async {
  File _image;
  final picker = ImagePicker();
  final pickedFile = await picker.getImage(source: ImageSource.gallery);

  if (pickedFile != null) {
    _image = File(pickedFile.path);
  } else {
    _image = null;
  }

  return _image;
}

Future<String> uploadImage(File image) async {
  String fileName = basename(image.path);

  Reference ref = FirebaseStorage.instance.ref().child(fileName);
  UploadTask task = ref.putFile(image);
  TaskSnapshot taskSnapshot = await task.whenComplete(() => null);

  return await taskSnapshot.ref.getDownloadURL();
}
