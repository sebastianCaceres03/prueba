import 'package:prueba/common/models/user.dart';

class ListUsers {
  List<User>? users;

  ListUsers({
    this.users,
  });

  ListUsers copyWith({
    List<User>? users,
  }) {
    return ListUsers(
      users: users ?? this.users,
    );
  }

  ListUsers.fromJson(Map<String, dynamic> json)
    : users = (json['Users'] as List?)?.map((dynamic e) => User.fromJson(e as Map<String,dynamic>)).toList() ?? [];

  Map<String, dynamic> toJson() => {
    'Users' : users?.map((e) => e.toJson()).toList()
  };
}