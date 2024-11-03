import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../domans/auth_repo/auth_repo.dart';

part 'register_state.dart';

class RegisterCubit extends Cubit<RegisterState> {
  final AuthRepo authRepo;

  RegisterCubit({required this.authRepo}) : super(RegisterState());

  Future<void> register(String email, String pass, String name) async {
    try {
      await authRepo.registerWithEmailAndPass(
        name: name,
        email: email,
        pass: pass,
      );
    } catch (e) {}
  }
}
