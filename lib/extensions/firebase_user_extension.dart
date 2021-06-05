import 'package:bwa_flutix/models/user_model.dart';
import 'package:bwa_flutix/services/services.dart';
import 'package:firebase_auth/firebase_auth.dart';

extension FirebaseUserExtension on UserCredential {
  UserModel convertToUser(
          {String name = 'no name',
          String language,
          int balance,
          List<String> genre}) =>
      UserModel(
          id: this.user.uid,
          name: name,
          email: this.user.email,
          language: language,
          balance: balance,
          genre: genre);

  Future<UserModel> fromFirestore() async =>
      await UserService().getUser(this.user.uid);
}
