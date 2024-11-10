import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../domans/auth_repo/auth_repo.dart';
import '../../model/user_model.dart';

part 'register_state.dart';

class RegisterCubit extends Cubit<RegisterState> {
  final AuthRepo authRepo;

  RegisterCubit({required this.authRepo}) : super(RegisterState());

  Future<void> register(UserModel userModel) async {
    try {
      await authRepo.registerWithEmailAndPass(userModel: userModel);
    } catch (e) {}
  }
}
