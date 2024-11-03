import 'package:equatable/equatable.dart';

class UserModel extends Equatable {
  final String id;
  final String? name;
  final String? email;
  final String? avatar;

  const UserModel({required this.id, this.name, this.email, this.avatar});

  static const empty = UserModel(id: "");

  bool get isEmpty => this == UserModel.empty;

  bool get isNotEmpty => this != UserModel.empty;

  @override
  // TODO: implement props
  List<Object?> get props => [id, name, email, avatar];

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'email': email,
      'avatar': avatar,
    };
  }
}
