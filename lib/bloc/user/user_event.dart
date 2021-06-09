part of 'user_bloc.dart';

abstract class UserEvent extends Equatable {
  const UserEvent();

  @override
  List<Object> get props => [];
}

class LoadUser extends UserEvent {
  final String id;

  LoadUser(this.id);

  @override
  List<Object> get props => [id];
}

class SignOut extends UserEvent {}

class UpdateData extends UserEvent {
  final String profile;
  final String name;

  UpdateData({this.profile, this.name});
}
