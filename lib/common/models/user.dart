import 'package:prueba/common/models/contact.dart';

class User {
  String? id;
  String? name;
  String? email;
  String? password;
  String? photo;
  List<Contacts>? contacts;

  User({
    this.id,
    this.name,
    this.email,
    this.password,
    this.photo,
    this.contacts,
  });

  User copyWith({
    String? id,
    String? name,
    String? email,
    String? password,
    String? photo,
    List<Contacts>? contacts,
  }) {
    return User(
      id: id ?? this.id,
      name: name ?? this.name,
      email: email ?? this.email,
      password: password ?? this.password,
      photo: photo ?? this.photo,
      contacts: contacts ?? this.contacts,
    );
  }

  User.fromJson(Map<String, dynamic> json)
    : id = json['id'] as String?,
      name = json['name'] as String?,
      email = json['email'] as String?,
      password = json['password'] as String?,
      photo = json['photo'] as String?,
      contacts = json['contacts'] == null ? [] : (json['contacts'] as List?)?.map((dynamic e) => Contacts.fromJson(e as Map<String,dynamic>)).toList();

  Map<String, dynamic> toJson() => {
    'id' : id,
    'name' : name,
    'email' : email,
    'password' : password,
    'photo' : photo,
    'contacts' : contacts?.map((e) => e.toJson()).toList()
  };
}