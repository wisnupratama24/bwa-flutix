part of 'services.dart';

class AuthServices {
  FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
  Stream<User> get authStateChange => _firebaseAuth.idTokenChanges();

  Future<SignInSignUpResult> signUp(String email, String password, String name,
      String language, List<String> genre, int balance, String profile) async {
    try {
      UserCredential userCredential = await _firebaseAuth
          .createUserWithEmailAndPassword(email: email, password: password);

      UserModel newUser = userCredential.convertToUser(
          name: name, language: language, balance: balance, genre: genre);

      await UserService().createUser(newUser);
      return SignInSignUpResult(user: newUser, message: 'success');
    } catch (e) {
      return SignInSignUpResult(message: e.toString());
    }
  }

  Future<SignInSignUpResult> signIn(String email, String password) async {
    String msg = '';

    try {
      UserCredential userCredential = await _firebaseAuth
          .signInWithEmailAndPassword(email: email, password: password);
      UserModel user = await userCredential.fromFirestore();
      return SignInSignUpResult(user: user);
    } on PlatformException catch (e) {
      if (e.code == 'user-not-found') {
        msg = "Tidak dapat menemukan email ini.";
      } else if (e.code == 'wrong-password') {
        msg = "Email dan password tidak cocok.";
      }
      return SignInSignUpResult(user: null, message: msg);
    } catch (err) {
      if (err.code == 'user-not-found') {
        msg = "Tidak dapat menemukan email ini.";
      } else if (err.code == 'wrong-password') {
        msg = "Email dan password tidak cocok.";
      }
      return SignInSignUpResult(user: null, message: msg);
    }
  }

  Future<SignInSignUpResult> signOut() async {
    await _firebaseAuth.signOut();
    return SignInSignUpResult(message: 'Sign out success');
  }
}

class SignInSignUpResult {
  final UserModel user;
  final String message;

  SignInSignUpResult({this.user, this.message});
}
