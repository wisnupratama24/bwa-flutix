import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';

class UserModel extends Equatable {
  final String id;
  final String name;
  final String language;
  final List genre;
  final String profile;
  final int balance;
  final String email;

  UserModel(
      {@required this.name,
      this.id,
      this.email,
      this.genre,
      this.profile,
      @required this.language,
      this.balance});

  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
        id: json['id'],
        name: json['name'],
        email: json['email'],
        language: json['language'],
        genre: json['genre'],
        profile: json['profile'],
        balance: json['balance']);
  }

  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'genre': genre,
      'profile': profile,
      'language': language,
      'email': email,
      'balance': balance,
    };
  }

  UserModel copyWith({String name, String profile, String balance}) =>
      UserModel(
          name: this.name ?? name,
          language: language,
          genre: genre,
          email: email,
          profile: this.profile ?? profile,
          balance: this.balance);

  @override
  String toString() {
    return "$id - $name - $email";
  }

  @override
  List<Object> get props =>
      [id, name, genre, profile, language, balance, email];
}
