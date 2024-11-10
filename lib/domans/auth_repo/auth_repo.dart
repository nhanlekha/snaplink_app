import '../../model/user_model.dart';
import '../../ultils/enums/auth_status.dart';

abstract class AuthRepo {
  Stream<AuthStatus> get status;

  Stream<UserModel> get user;

  Future<void> loginWithEmailAndPass({
    required String email,
    required String pass,
  });

  Future<void> registerWithEmailAndPass({
    required UserModel userModel,
  });
}
