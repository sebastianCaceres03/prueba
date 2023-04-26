import 'package:flutter/material.dart';
import 'package:prueba/common/services/redirect_services.dart';
import 'package:prueba/common/services/toast_service.dart';
import 'package:prueba/common/styles/text_field_style.dart';
import 'package:prueba/common/widgets/button_widget.dart';
import 'package:prueba/components/home/screens/home_screen.dart';
import 'package:prueba/components/login/blocs/login_user_bloc.dart';
import 'package:prueba/components/register/screens/register_screen.dart';

class LoginScreen extends StatelessWidget {
  LoginScreen({super.key});

  final LoginBloc loginBloc = LoginBloc();

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
                "Iniciar Sesión",
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
                    Icons.person_rounded,
                    size: 100.0,
                    color: Colors.white,
                  ),
                  const SizedBox(
                    height: 40.0,
                  ),
                  StreamBuilder<String>(
                      stream: loginBloc.emailStream,
                      builder: (context, snapshot) {
                        return TextFormField(
                          style: TextFieldStyle.textStyle(),
                          onChanged: (value) {
                            loginBloc.chanceEmail(value);
                          },
                          maxLines: 1,
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
                      stream: loginBloc.passwordStream,
                      builder: (context, snapshot) {
                        return TextFormField(
                          style: TextFieldStyle.textStyle(),
                          onChanged: (value) {
                            loginBloc.chancePassword(value);
                          },
                          decoration:
                              TextFieldStyle.general(labelText: "Contraseña"),
                          obscureText: true,
                        );
                      }),
                  const SizedBox(
                    height: 40.0,
                  ),
                  StreamBuilder<bool>(
                      stream: loginBloc.onSubmit,
                      builder: (context, snapshot) {
                        bool validate = snapshot.data ?? false;
                        return CustomButton.button(
                            title: const Text("Ingresar"),
                            onPressed: () {
                              bool response = loginBloc.loginUser();
                              if(response){
                                ToastsMessage().toastsVerification(context, 'ingreso correcto');
                                RedirectService.replaceAllPages(context, const HomeScreen());
                              }else{
                                ToastsMessage().toastsError(context, 'usuario o contraseña erroneas');
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
                  RedirectService.replaceAllPages(context, RegisterScreen());
                },
                child: const Text(
                  "Registro",
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
