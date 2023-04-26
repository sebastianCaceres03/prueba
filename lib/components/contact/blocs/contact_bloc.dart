import 'package:prueba/common/models/contact.dart';
import 'package:prueba/components/contact/functions/contact_provider.dart';
import 'package:rxdart/rxdart.dart';

class ContactsBloc {
  List<Contacts>? contacts;
  BehaviorSubject<List<Contacts>?> contactsCollection =
      BehaviorSubject<List<Contacts>?>();
  Stream<List<Contacts>?> get contactsStream => contactsCollection.stream;

  final ContactProvider contactProvider = ContactProvider();

  loadListContactUser(String idUser) {
    contacts = contactProvider.listContactUser(idUser);
    contactsCollection.sink.add(contacts);
  }

  searchListContacts(String text, String idUser) {
    if (text.length <= 3) {
      loadListContactUser(idUser);
    } else {
      contacts = contactProvider.searchlistContactUser(idUser, text);
      contactsCollection.sink.add(contacts);
    }
  }
}
