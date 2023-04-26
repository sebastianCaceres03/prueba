import 'package:prueba/components/login/functions/login_functions.dart';
import 'package:prueba/components/register/blocs/validate_fields.dart';
import 'package:rxdart/rxdart.dart';

class LoginBloc with ValidatorsRegister {
  
  final LoginFunctions loginFunctions = LoginFunctions();

  String email = "";
  BehaviorSubject<String> emailCollection = BehaviorSubject<String>();
  Stream<String> get emailStream =>
      emailCollection.stream.transform(validateEmail);

  String password = "";
  BehaviorSubject<String> passwordCollection = BehaviorSubject<String>();
  Stream<String> get passwordStream => passwordCollection.stream;

  chanceEmail(String value) {
    email = value;
    emailCollection.sink.add(value);
  }

  chancePassword(String value) {
    password = value;
    passwordCollection.sink.add(value);
  }

  bool loginUser() {
    if(loginFunctions.loginUser(email, password)){
      return true;
    }
    return false;
  }

  Stream<bool> get onSubmit =>
      Rx.combineLatest2(emailStream, passwordStream, (dynamic a, dynamic b) {
        if (a == "" || b == "") {
          return false;
        }
        return true;
      });
}
