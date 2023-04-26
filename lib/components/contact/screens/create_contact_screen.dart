import 'package:flutter/material.dart';
import 'package:prueba/common/services/redirect_services.dart';
import 'package:prueba/common/services/toast_service.dart';
import 'package:prueba/common/services/user_bloc.dart';
import 'package:prueba/common/styles/text_field_style.dart';
import 'package:prueba/common/widgets/button_widget.dart';
import 'package:prueba/components/contact/blocs/contact_bloc.dart';
import 'package:prueba/components/contact/blocs/create_contact.dart';

class CreateContact extends StatelessWidget {

  final ContactsBloc contactsBloc;

  CreateContact({super.key, required this.contactsBloc});

  final CreateContactBloc createContactBloc = CreateContactBloc();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.lightBlue,
        leading: InkWell(
          onTap: () {
            RedirectService.pop(context);
          },
          child: const Icon(
            Icons.arrow_back,
            color: Colors.white,
          ),
        ),
        title: const Text(
          "Agregar contacto",
          textAlign: TextAlign.center,
          style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.w700,
            fontSize: 18.0,
          ),
        ),
      ),
      body: Container(
        margin: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 16.0),
        child: Form(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const SizedBox(
                height: 40.0,
              ),
              StreamBuilder<String>(
                  stream: createContactBloc.nameStream,
                  builder: (context, snapshot) {
                    return TextFormField(
                      style:
                          TextFieldStyle.textStyle(colorText: Colors.lightBlue),
                      onChanged: (value) {
                        createContactBloc.chanceName(value);
                      },
                      maxLines: 1,
                      decoration: TextFieldStyle.withIcon(
                        labelText: "Nombre",
                        leftIcon: const Padding(
                          padding: EdgeInsets.only(
                              top: 8.0, bottom: 8.0, right: 10.0),
                          child: Icon(
                            Icons.person,
                            color: Colors.indigo,
                          ),
                        ),
                      ).copyWith(errorText: snapshot.error as String?),
                      cursorColor: Colors.indigo,
                    );
                  }),
              const SizedBox(
                height: 20.0,
              ),
              StreamBuilder<String>(
                  stream: createContactBloc.documentStream,
                  builder: (context, snapshot) {
                    return TextFormField(
                      keyboardType: TextInputType.number,
                      style:
                          TextFieldStyle.textStyle(colorText: Colors.lightBlue),
                      onChanged: (value) {
                        createContactBloc.chancedocument(value);
                      },
                      cursorColor: Colors.indigo,
                      decoration: TextFieldStyle.withIcon(
                        labelText: "Documento",
                        leftIcon: const Padding(
                          padding: EdgeInsets.only(
                              top: 8.0, bottom: 8.0, right: 10.0),
                          child: Icon(
                            Icons.numbers_sharp,
                            color: Colors.indigo,
                          ),
                        ),
                      ).copyWith(errorText: snapshot.error as String?),
                    );
                  }),
              const SizedBox(
                height: 40.0,
              ),
              StreamBuilder<bool>(
                  stream: createContactBloc.onSubmit,
                  builder: (context, snapshot) {
                    bool validate = snapshot.data ?? false;
                    return CustomButton.button(
                      title: const Text("Guardar"),
                      enable: validate,
                      onPressed: () {
                        bool result = createContactBloc.createContact();
                        if(result){
                          contactsBloc.loadListContactUser(userBloc.user?.id ?? "");
                          ToastsMessage().toastsVerification(context, 'contacto creado');
                          RedirectService.pop(context);
                        }
                      },
                    );
                  }),
            ],
          ),
        ),
      ),
    );
  }
}
