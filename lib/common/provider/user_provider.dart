import 'dart:convert';

import 'package:prueba/common/models/user.dart';
import 'package:prueba/common/services/list_users_bloc.dart';

class UserProvider {
  bool validateEmailExist(String email) {
    List<User>? users = usersBloc.getListUsers();
    if (users != null) {
      for (var i = 0; i < users.length; i++) {
        if (users[i].email == email) {
          return false;
        }
      }
    }
    return true;
  }

  String? loginUser(String email, String password) {
    List<User>? users = usersBloc.getListUsers();
    if (users != null) {
      for (var i = 0; i < users.length; i++) {
        if (users[i].email == email && users[i].password == password) {
          return jsonEncode(users[i].toJson());
        }
      }
    }
    return null;
  }

  User? loadUser(String id) {
    List<User>? users = usersBloc.getListUsers();
    if (users != null) {
      for (var i = 0; i < users.length; i++) {
        if (users[i].id == id) {
          return users[i];
        }
      }
    }
    return null;
  }

  List<User>? updateUser(User? user){
    List<User>? users = usersBloc.getListUsers();
    if (users != null) {
      for (var i = 0; i < users.length; i++) {
        if (users[i].id == user?.id) {
          return users;
        }
      }
    }
    return users;
  }
}
