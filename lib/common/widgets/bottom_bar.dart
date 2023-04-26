import 'package:flutter/material.dart';
import 'package:page_transition/page_transition.dart';
import 'package:prueba/common/services/redirect_services.dart';
import 'package:prueba/components/contact/screens/contacts_screen.dart';
import 'package:prueba/components/home/screens/home_screen.dart';


class BottomBar extends StatelessWidget {
  final int selectedIndex;
  const BottomBar({super.key, required this.selectedIndex});

  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      backgroundColor: Colors.lightBlueAccent,
      items: const <BottomNavigationBarItem>[
        BottomNavigationBarItem(
          icon: Icon(Icons.person),
          label: 'Inicio',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.contacts_sharp),
          label: 'Contactos',
        ),
      ],
      currentIndex: selectedIndex,
      selectedItemColor: Colors.white,
      onTap: (value) {
        if (value == 0) {
          RedirectService.goToWithTransition(
              context, const HomeScreen(), PageTransitionType.fade);
        } else {
          RedirectService.goToWithTransition(
              context, ContactsScreen(), PageTransitionType.fade);
        }
      },
    );
  }
}