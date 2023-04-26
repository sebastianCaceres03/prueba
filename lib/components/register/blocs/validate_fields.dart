import 'dart:async';

class ValidatorsRegister {


  final validateEmail =
      StreamTransformer<String, String>.fromHandlers(handleData: (email, sink) {
    bool emailValid =
        RegExp(r"^([a-zA-Z0-9_\-\.]+)@([a-zA-Z0-9_\-\.]+)\.([a-zA-Z]{2,5})$")
            .hasMatch(email.trim());
    if (emailValid) {
      sink.add(email.trim());
    } else {
      sink.addError('correo invalido');
    }
  });


  final validatePassword = StreamTransformer<String, String>.fromHandlers(
      handleData: (password, sink) {
    if (password.length >= 10 && password.length <= 60) {
      sink.add(password);
    } else {
      sink.addError('La contraseña debe tener entre 10 y 60 caracteres');
    }
  });


  final validateName = StreamTransformer<String, String>.fromHandlers(
      handleData: (name, sink) {
    if (name.length >= 4 && name.length <= 50) {
      sink.add(name);
    } else {
      sink.addError('El nombre debe tener entre 4 y 50 caracteres');
    }
  });

}