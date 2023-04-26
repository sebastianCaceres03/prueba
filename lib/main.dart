import 'package:flutter/material.dart';
import 'package:prueba/common/services/user_bloc.dart';
import 'package:prueba/components/home/screens/home_screen.dart';
import 'package:prueba/components/login/screens/login_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: 'Flutter Demo',
        theme: ThemeData(
          primarySwatch: Colors.blue,
          textSelectionTheme:
            const TextSelectionThemeData(cursorColor: Colors.white),
        ),
        home: FutureBuilder<bool>(
          future: userBloc.loadUserLogin(),
          builder: (context, snapshot) {
            if(!snapshot.hasData){
              return LoginScreen();
            }
            return validateLogin(snapshot.data ?? false);
          },
        ));
  }

  Widget validateLogin(bool validate) {
    if (validate) {
      return const HomeScreen();
    }
    return LoginScreen();
  }
}