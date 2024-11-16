import 'package:firebase_auth/firebase_auth.dart';

class FirebaseAuthService {
  Future<void> loginWithEmailAndPass(
      {required String email, required String pass}) async {
    try {
      await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: email,
        password: pass,
      );
    } catch (e) {}
  }

  Future<UserCredential?> registerWithEmailAndPass({
    required String email,
    required String pass,
  }) async {
    try {
      // Đăng ký người dùng mới
      UserCredential userCredential =
          await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: email,
        password: pass,
      );

      if (userCredential.user != null) {
        return userCredential;
      }
    } catch (e) {
      // Xử lý lỗi (có thể ném lại hoặc log lỗi)
      print('Registration error: $e');
    }
    return null;
  }

  Stream<User?> get user {
    return FirebaseAuth.instance
        .authStateChanges()
        .map((firebaseUser) => firebaseUser);
  }
}
