import 'package:equatable/equatable.dart';

class UserModel extends Equatable {
  String id;
  String? name;
  String? email;
  String? avatar;
  String? pass;

  UserModel({required this.id, this.name, this.email, this.avatar, this.pass});

  static final empty = UserModel(id: "");

  bool get isEmpty => this == UserModel.empty;

  bool get isNotEmpty => this != UserModel.empty;

  // Custom getters and setters
  String get getId => id;

  set setId(String value) => id = value;

  String? get getName => name;

  set setName(String? value) => name = value;

  String? get getEmail => email;

  set setEmail(String? value) => email = value;

  String? get getAvatar => avatar;

  set setAvatar(String? value) => avatar = value;

  String? get getPass => pass;

  set setPass(String? value) => pass = value;

  @override
  List<Object?> get props => [id, name, email, avatar, pass];

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'email': email,
      'avatar': avatar,
      'pass': pass,
    };
  }
}
