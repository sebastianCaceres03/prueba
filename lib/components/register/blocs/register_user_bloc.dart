import 'package:prueba/common/provider/user_provider.dart';
import 'package:prueba/components/register/blocs/validate_fields.dart';
import 'package:prueba/components/register/functions/register_functions.dart';
import 'package:rxdart/rxdart.dart';

class RegisterBloc with ValidatorsRegister {

  final UserProvider userProvider = UserProvider();
  final RegisterFunctions registerFunctions = RegisterFunctions();

  String name = "";
  BehaviorSubject<String> nameCollection =BehaviorSubject<String>();
  Stream<String> get nameStream => nameCollection.stream.transform(validateName);

  String email = "";
  BehaviorSubject<String> emailCollection =BehaviorSubject<String>();
  Stream<String> get emailStream => emailCollection.stream.transform(validateEmail);
  
  String password = "";
  BehaviorSubject<String> passwordCollection =BehaviorSubject<String>();
  Stream<String> get passwordStream => passwordCollection.stream.transform(validatePassword);

  String confirmPassword = "";
  BehaviorSubject<String> confirmPasswordCollection =BehaviorSubject<String>();
  Stream<String> get confirmPasswordStream => confirmPasswordCollection.stream;

  chanceName(String value){
    name = value;
    nameCollection.sink.add(value);
  }

  chanceEmail(String value){
    email = value;
    emailCollection.sink.add(value);
  }

  chancePassword(String value){
    password = value;
    passwordCollection.sink.add(value);
  }

  chanceConfirmPassword(String value){
    confirmPassword = value;
    if(password == confirmPassword){
      confirmPasswordCollection.sink.add(value);
    }else{
      confirmPasswordCollection.addError('las contraseñas no coinciden');
    }
  }


  bool createUser(){
    if(userProvider.validateEmailExist(email)){
      registerFunctions.createUser(name, email, password);
      return true;
    }else{
      emailCollection.addError('el correo ya existe');
      return false;
    }
  }

  Stream<bool> get onSubmit =>
      Rx.combineLatest4(nameStream, emailStream, passwordStream,confirmPasswordStream, (dynamic a, dynamic b,dynamic c,dynamic d) {
        if (a == "" || b == "" || c == "" || d == "") {
          return false;
        }
        return true;
      });
  

}
