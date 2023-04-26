import 'dart:io';

import 'package:flutter/material.dart';
import 'package:prueba/common/models/user.dart';
import 'package:prueba/common/services/redirect_services.dart';
import 'package:prueba/common/services/user_bloc.dart';
import 'package:prueba/common/widgets/bottom_bar.dart';
import 'package:prueba/common/widgets/modal_photo.dart';
import 'package:prueba/components/login/screens/login_screen.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.lightBlue,
        leading: const SizedBox.shrink(),
        title: StreamBuilder<User?>(
          stream: userBloc.userStream,
          builder: (context, snapshot) {
            return Text(
              !snapshot.hasData ? "" : snapshot.data?.name ?? "",
              textAlign: TextAlign.center,
              style:const  TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.w700,
                fontSize: 18.0,
              ),
            );
          }
        ),
        actions: [
          InkWell(
            onTap: () {
              userBloc.closeSeccion();
              RedirectService.replaceAllPages(context, LoginScreen());
            },
            child: const Padding(
              padding: EdgeInsets.only(right: 20.0),
              child: Icon(
                Icons.login_outlined,
                size: 30.0,
                color: Colors.white,
              ),
            ),
          )
        ],
      ),
      body: StreamBuilder<User?>(
          stream: userBloc.userStream,
          builder: (context, snapshot) {
            if (!snapshot.hasData) {
              return Container();
            }
            return Container(
              margin:
                  const EdgeInsets.symmetric(horizontal: 20.0, vertical: 18.0),
              child: Column(
                children: [
                  Center(
                    child: Stack(
                      children: [
                        ClipRRect(
                          borderRadius: BorderRadius.circular(50.0),
                          child: imageUser(snapshot.data?.photo ?? ""),
                          //Image.network(""),
                        ),
                        Positioned(
                          top: 70.0,
                          right: 0,
                          child: InkWell(
                            onTap: () {
                              ModalPhoto().modal(context,
                                  changeImage: userBloc.updateImage);
                            },
                            child: Container(
                              width: 30.0,
                              height: 30.0,
                              decoration: BoxDecoration(
                                color: Colors.indigo,
                                borderRadius: BorderRadius.circular(50.0),
                              ),
                              child: const Icon(
                                Icons.camera_alt,
                                size: 20.0,
                                color: Colors.white,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            );
          }),
      bottomNavigationBar: const BottomBar(selectedIndex: 0),
    );
  }

  Widget imageUser(String url) {
    if (url == "") {
      return const Icon(
        Icons.person,
        size: 100.0,
        color: Colors.lightBlue,
      );
    } else {
      File image = File(url);
      return Image.file(image,width: 100,height: 100,fit: BoxFit.cover,);
    }
  }
}
