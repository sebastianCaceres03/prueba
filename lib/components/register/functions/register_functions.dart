import 'package:prueba/common/models/user.dart';
import 'package:prueba/common/services/list_users_bloc.dart';
import 'package:uuid/uuid.dart';

class RegisterFunctions {
  bool createUser(String name, String email, String password) {
    var uuid = const Uuid();
    try {
      User user =User(id: uuid.v1(), email: email, name: name, password: password);
      usersBloc.addNewUser(user);
      return true;
    } catch (e) {
      return false;
    }
  }
}
