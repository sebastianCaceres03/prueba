import 'package:prueba/common/models/contact.dart';
import 'package:prueba/common/models/user.dart';
import 'package:prueba/common/services/list_users_bloc.dart';
import 'package:prueba/common/services/user_bloc.dart';
import 'package:uuid/uuid.dart';

class ContactProvider {
  List<Contacts>? listContactUser(String id) {
    List<User>? users = usersBloc.getListUsers();
    if (users != null) {
      for (var i = 0; i < users.length; i++) {
        if (users[i].id == id) {
          return users[i].contacts ?? [];
        }
      }
    }
    return [];
  }

  List<Contacts>? searchlistContactUser(String id,String text) {
    List<Contacts>? contacts = listContactUser(userBloc.user?.id ?? "");
    List<Contacts>? aux = [];
    for (var i = 0; i < contacts!.length; i++) {
      if(contacts[i].dni!.contains(text) || contacts[i].name!.contains(text)){
        aux.add(contacts[i]);
      }
    }
    return aux;
  }

  Contacts? createContact(String name, String document) {
    if (!validateDniContacts(document)) {
      try {
        var uuid = const Uuid();
        Contacts contacts = Contacts(dni: document, name: name, id: uuid.v1());
        return contacts;
      } catch (e) {
        return null;
      }
    }
    return null;
  }

  bool validateDniContacts(String dni) {
    List<Contacts>? contacts = listContactUser(userBloc.user?.id ?? "");
    for (var i = 0; i < contacts!.length; i++) {
      if (dni == contacts[i].dni) {
        return true;
      }
    }
    return false;
  }
}
