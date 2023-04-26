import 'dart:convert';
import 'package:prueba/common/models/list_users_model.dart';
import 'package:prueba/common/models/user.dart';
import 'package:prueba/common/provider/user_provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

class UsersBloc {
  ListUsers? users = ListUsers(
    users: []
  );

  UserProvider userProvider = UserProvider();

  saveDataLocal() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString('users', jsonEncode(users?.toJson()));
  }

  loadDataUsers() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    String? usersString = prefs.getString('users');
    if (usersString == null || usersString == "null") return;
    final response = json.decode(usersString);
    users = ListUsers.fromJson(response);
  }

  addNewUser(User user){
    users?.users!.add(user);
    saveDataLocal();
  }

  updateUser(User? user){
    users?.users = userProvider.updateUser(user);
    saveDataLocal();
  }

  List<User>? getListUsers(){
    return users?.users;
  }

}

final UsersBloc usersBloc = UsersBloc();
