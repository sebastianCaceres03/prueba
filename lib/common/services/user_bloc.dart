import 'dart:io';

import 'package:image_picker/image_picker.dart';
import 'package:path_provider/path_provider.dart';
import 'package:prueba/common/models/contact.dart';
import 'package:prueba/common/models/user.dart';
import 'package:prueba/common/provider/user_provider.dart';
import 'package:prueba/common/services/list_users_bloc.dart';
import 'package:rxdart/rxdart.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:uuid/uuid.dart';

class UserBloc {
  User? user;
  BehaviorSubject<User?> userCollection = BehaviorSubject<User?>();
  Stream<User?> get userStream => userCollection.stream;

  final UserProvider userProvider = UserProvider();


  loginUser(User? userData) async{
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString('idUser', userData?.id ?? "");
    user = userData;
    userCollection.sink.add(user);
  }

  closeSeccion() async{
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.remove('idUser');
  }

  updateImage(XFile? photo) async{
    var uuid = const Uuid();
    Directory tempDir = await getTemporaryDirectory();
    File? image = File(photo!.path);
    String url = '${tempDir.path}/image${uuid.v1()}.png';
    image = await image.copy(url);
    user?.photo = url;
    userCollection.sink.add(user);
    usersBloc.updateUser(user);
  }

  addContact(Contacts contacts){
    user?.contacts?.add(contacts);
    usersBloc.updateUser(user);
    usersBloc.updateUser(user);
  }

  Future<bool> loadUserLogin() async{
    await usersBloc.loadDataUsers();
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    String? id = prefs.getString('idUser');
    if(id != null && id != ""){
      User? user = userProvider.loadUser(id);
      loginUser(user);
      return true;
    }else{
      return false;
    }
  }
}

final UserBloc userBloc = UserBloc();
