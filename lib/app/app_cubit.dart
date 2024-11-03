import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:snaplink_app/domans/auth_repo/auth_repo.dart';

import 'app_state.dart';

class AppCubit extends Cubit<AppState> {
  final AuthRepo authRepo;

  AppCubit({required this.authRepo}) : super(const AppState()) {
    authRepo.status.listen((authStatus) {
      emit(state.copyWith(authStatus: authStatus));
    });

    authRepo.user.listen((user) {
      emit(state.copyWith(user: user));
    });
  }
}
