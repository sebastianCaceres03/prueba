import 'dart:async';

class ValidatorsCreateContacts {
  final validateName =
      StreamTransformer<String, String>.fromHandlers(handleData: (name, sink) {
    if (name.length >= 2 && name.length <= 50) {
      sink.add(name);
    } else {
      sink.addError('El nombre debe tener entre 2 y 50 caracteres');
    }
  });

  final validateDocument = StreamTransformer<String, String>.fromHandlers(
      handleData: (document, sink) {
    bool documentValid = RegExp(r"^[0-9]*$").hasMatch(document.trim());
    if (documentValid) {
      if (document.length >= 6 && document.length <= 10) {
        sink.add(document);
      } else {
        sink.addError('El documento debe tener entre 6 y 10 caracteres');
      }
    }else{
      sink.addError('El documento debe tener solo numeros');
    }
  });
}
