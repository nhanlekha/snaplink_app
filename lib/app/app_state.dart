import 'package:equatable/equatable.dart';
import 'package:snaplink_app/model/user_model.dart'; // Import UserModel
import 'package:snaplink_app/ultils/enums/auth_status.dart';

class AppState extends Equatable {
  final AuthStatus authStatus;
  final UserModel? user;

  const AppState({
    this.authStatus = AuthStatus.unknown,
    this.user,
  });

  AppState copyWith({
    AuthStatus? authStatus,
    UserModel? user,
  }) {
    return AppState(
      authStatus: authStatus ?? this.authStatus,
      user: user ?? this.user,
    );
  }

  @override
  List<Object?> get props => [
        authStatus,
        user,
      ];
}
