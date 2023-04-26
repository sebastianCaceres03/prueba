import 'package:flutter/material.dart';
import 'package:prueba/common/services/redirect_services.dart';
import 'package:prueba/common/services/toast_service.dart';
import 'package:prueba/common/styles/text_field_style.dart';
import 'package:prueba/common/widgets/button_widget.dart';
import 'package:prueba/components/login/screens/login_screen.dart';
import 'package:prueba/components/register/blocs/register_user_bloc.dart';

class RegisterScreen extends StatelessWidget {
  RegisterScreen({super.key});

  final RegisterBloc registerBloc = RegisterBloc();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
            gradient: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomRight,
          colors: [Colors.indigo, Colors.lightBlue, Colors.white10],
        )),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const Padding(
              padding: EdgeInsets.only(top: 60.0, left: 8.0, right: 8.0),
              child: Text(
                "Registro",
                style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.w700,
                  fontSize: 18.0,
                ),
              ),
            ),
            Container(
              margin: const EdgeInsets.only(top: 60.0, left: 32.0, right: 32.0),
              child: Form(
                  child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  const Icon(
                    Icons.person_pin,
                    size: 100.0,
                    color: Colors.white,
                  ),
                  const SizedBox(
                    height: 40.0,
                  ),
                  StreamBuilder<String>(
                      stream: registerBloc.nameStream,
                      builder: (context, snapshot) {
                        return TextFormField(
                          style: TextFieldStyle.textStyle(),
                          onChanged: (value) {
                            registerBloc.chanceName(value);
                          },
                          decoration: TextFieldStyle.general(
                                  labelText: "Nombre")
                              .copyWith(errorText: snapshot.error as String?),
                        );
                      }),
                  const SizedBox(
                    height: 20.0,
                  ),
                  StreamBuilder<String>(
                      stream: registerBloc.emailStream,
                      builder: (context, snapshot) {
                        return TextFormField(
                          style: TextFieldStyle.textStyle(),
                          onChanged: (value) {
                            registerBloc.chanceEmail(value);
                          },
                          decoration: TextFieldStyle.general(
                                  labelText: "Correo")
                              .copyWith(errorText: snapshot.error as String?),
                          keyboardType: TextInputType.emailAddress,
                        );
                      }),
                  const SizedBox(
                    height: 20.0,
                  ),
                  StreamBuilder<String>(
                      stream: registerBloc.passwordStream,
                      builder: (context, snapshot) {
                        return TextFormField(
                          style: TextFieldStyle.textStyle(),
                          onChanged: (value) {
                            registerBloc.chancePassword(value);
                          },
                          decoration: TextFieldStyle.general(
                                  labelText: "Contraseña")
                              .copyWith(errorText: snapshot.error as String?),
                          obscureText: true,
                        );
                      }),
                  const SizedBox(
                    height: 20.0,
                  ),
                  StreamBuilder<String>(
                      stream: registerBloc.confirmPasswordStream,
                      builder: (context, snapshot) {
                        return TextFormField(
                          style: TextFieldStyle.textStyle(),
                          onChanged: (value) {
                            registerBloc.chanceConfirmPassword(value);
                          },
                          decoration: TextFieldStyle.general(
                                  labelText: "Confirmar Contraseña")
                              .copyWith(errorText: snapshot.error as String?),
                          obscureText: true,
                        );
                      }),
                  const SizedBox(
                    height: 40.0,
                  ),
                  StreamBuilder<bool>(
                      stream: registerBloc.onSubmit,
                      builder: (context, snapshot) {
                        bool validate = snapshot.data ?? false;
                        return CustomButton.button(
                            title: const Text("Regístrate"),
                            onPressed: () {
                              bool response = registerBloc.createUser();
                              if (response) {
                                RedirectService.replaceAllPages(context, LoginScreen());
                                ToastsMessage().toastsVerification(context, 'registro exitoso');
                              }
                            },
                            enable: validate);
                      }),
                ],
              )),
            ),
            const SizedBox(
              height: 30.0,
            ),
            TextButton(
                onPressed: () {
                  RedirectService.replaceAllPages(context, LoginScreen());
                },
                child: const Text(
                  "Iniciar sesión",
                  style: TextStyle(
                    decoration: TextDecoration.underline,
                    color: Colors.indigo,
                    fontWeight: FontWeight.w700,
                    fontSize: 14,
                  ),
                )),
          ],
        ),
      ),
    );
  }
}
