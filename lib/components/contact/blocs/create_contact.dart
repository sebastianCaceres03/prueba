import 'package:prueba/common/models/contact.dart';
import 'package:prueba/common/services/user_bloc.dart';
import 'package:prueba/components/contact/blocs/validate_create_contacts.dart';
import 'package:prueba/components/contact/functions/contact_provider.dart';
import 'package:rxdart/rxdart.dart';

class CreateContactBloc with ValidatorsCreateContacts {

  final ContactProvider contactProvider = ContactProvider();

  String name = "";
  BehaviorSubject<String> nameCollection = BehaviorSubject<String>();
  Stream<String> get nameStream =>nameCollection.stream.transform(validateName);

  String document = "";
  BehaviorSubject<String> documentCollection = BehaviorSubject<String>();
  Stream<String> get documentStream => documentCollection.stream.transform(validateDocument);

  chanceName(String value) {
    name = value;
    nameCollection.sink.add(value);
  }

  chancedocument(String value) {
    document = value;
    documentCollection.sink.add(value);
  }

  bool createContact(){
    Contacts? result = contactProvider.createContact(name, document);
    if(result != null){
      userBloc.addContact(result);
      return true;
    }else{
      documentCollection.addError("doc ya existe");
      return false;
    }
  }

  Stream<bool> get onSubmit =>
      Rx.combineLatest2(nameStream, documentStream, (dynamic a, dynamic b) {
        if (a == "" || b == "") {
          return false;
        }
        return true;
      });
}
