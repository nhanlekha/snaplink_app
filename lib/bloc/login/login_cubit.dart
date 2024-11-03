import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:snaplink_app/domans/auth_repo/auth_repo.dart';

part 'login_state.dart';

class LoginCubit extends Cubit<LoginState> {
  final AuthRepo authRepo;

  LoginCubit({
    required this.authRepo,
  }) : super(LoginState());

  Future<void> login(String email, String pass) async {
    try {
      await authRepo.loginWithEmailAndPass(email: email, pass: pass);
    } catch (e) {}
  }
}
