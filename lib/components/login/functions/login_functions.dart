import 'dart:convert';

import 'package:prueba/common/models/user.dart';
import 'package:prueba/common/provider/user_provider.dart';
import 'package:prueba/common/services/user_bloc.dart';

class LoginFunctions{

  UserProvider userProvider = UserProvider();

  bool loginUser(String email,String password){
    final String? response = userProvider.loginUser(email, password);
    if(response != null){
      User userResponse = User.fromJson(jsonDecode(response));
      userBloc.loginUser(userResponse);
      return true;
    }
    else{
      return false;
    }
  }
}