part of 'services.dart';

class UserService {
  CollectionReference _db = FirebaseFirestore.instance.collection("users");

  Future<UserModel> getUser(String id) async {
    DocumentSnapshot snapshot = await _db.doc(id).get();

    return UserModel(
        id: id,
        email: snapshot.get('email'),
        balance: snapshot.get('balance'),
        genre: snapshot.get('genre'),
        name: snapshot.get('name'),
        language: snapshot.get('language'));
  }

  // create user
  Future<UserModel> createUser(UserModel userModel) {
    return _db.doc(userModel.id).set(userModel.toMap());
  }
}
