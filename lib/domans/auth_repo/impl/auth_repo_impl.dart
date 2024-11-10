import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:snaplink_app/domans/auth_repo/auth_repo.dart';
import 'package:snaplink_app/domans/data_source/impl/firebase_auth_service.dart';
import 'package:snaplink_app/ultils/enums/auth_status.dart';

import '../../../model/user_model.dart';

class AuthRepoImpl implements AuthRepo {
  final FirebaseAuthService firebaseAuthService;
  final _statusController = StreamController<AuthStatus>();
  final _userController = StreamController<UserModel>();

  AuthRepoImpl({required this.firebaseAuthService}) {
    firebaseAuthService.user.listen((firebaseUser) {
      final isLoggedIn = firebaseUser != null;
      final user = isLoggedIn ? firebaseUser.toUserModel : UserModel.empty;
      _userController.sink.add(user);

      if (isLoggedIn) {
        _statusController.sink.add(AuthStatus.authenticated);
      } else {
        _statusController.sink.add(AuthStatus.unauthenticated);
      }
    });
  }

  @override
  // TODO: implement status
  Stream<AuthStatus> get status async* {
    yield AuthStatus.unknown;
    yield* _statusController.stream;
    // Khi _statusController bắn ra tính hiệu gì thì status có tính hiệu như vậy !
    // Nhân hiểu không ?
    // Nhân không
  }

  @override
  // TODO: implement user
  Stream<UserModel> get user async* {
    yield* _userController.stream;
  }

  @override
  Future<void> loginWithEmailAndPass({
    required String email,
    required String pass,
  }) async {
    // TODO: implement loginWithEmailAndPass
    try {
      await firebaseAuthService.loginWithEmailAndPass(email: email, pass: pass);
    } catch (e) {
      print(e);
    }
  }

  @override
  Future<void> registerWithEmailAndPass({required UserModel userModel}) async {
    // TODO: implement registerWithEmailAndPass
    try {
      UserCredential? userCredential =
          await firebaseAuthService.registerWithEmailAndPass(
              email: userModel.email.toString(),
              pass: userModel.pass.toString());

      if (userCredential != null) {
        userModel.id = userCredential.user!.uid;
        await FirebaseFirestore.instance
            .collection("users")
            .doc(userCredential.user?.uid)
            .set(userModel.toMap());
      }
    } catch (e) {
      print(e);
    }
  }
}

extension UserFirebaseAuthExtension on User {
  UserModel get toUserModel {
    return UserModel(
      id: uid,
      email: email,
      name: displayName,
    );
  }
}
