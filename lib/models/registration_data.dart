import 'dart:io';

class RegistrationData {
  String name;
  String language;
  String password;
  String email;
  List<String> genre;
  File profile;

  RegistrationData(
      {this.name = "",
      this.language = "English",
      this.password = "",
      this.email = "",
      this.genre = const [],
      this.profile});
  @override
  List<Object> get props => [name, genre, profile, language, email];
}
