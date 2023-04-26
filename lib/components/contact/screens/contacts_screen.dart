import 'package:flutter/material.dart';
import 'package:prueba/common/models/contact.dart';
import 'package:prueba/common/services/redirect_services.dart';
import 'package:prueba/common/services/user_bloc.dart';
import 'package:prueba/common/styles/text_field_style.dart';
import 'package:prueba/common/widgets/bottom_bar.dart';
import 'package:prueba/components/contact/blocs/contact_bloc.dart';
import 'package:prueba/components/contact/screens/create_contact_screen.dart';

class ContactsScreen extends StatelessWidget {
  ContactsScreen({super.key}) {
    contactsBloc.loadListContactUser(userBloc.user?.id ?? "");
  }

  final ContactsBloc contactsBloc = ContactsBloc();

  @override
  Widget build(BuildContext context) {
    final controller = TextEditingController();
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
          "Mis contactos",
          textAlign: TextAlign.center,
          style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.w700,
            fontSize: 18.0,
          ),
        ),
      ),
      body: StreamBuilder<List<Contacts>?>(
          stream: contactsBloc.contactsStream,
          builder: (context, snapshot) {
            if (!snapshot.hasData || snapshot.data!.isEmpty) {
              return Container();
            }
            return Container(
              margin:
                  const EdgeInsets.symmetric(horizontal: 20.0, vertical: 16.0),
              child: Column(
                children: [
                  TextFormField(
                    controller: controller,
                    onChanged: (value) {
                      contactsBloc.searchListContacts(value, userBloc.user?.id ?? "");
                    },
                    cursorColor: Colors.indigo,
                    style: TextFieldStyle.textStyle(colorText: Colors.indigo),
                    decoration: TextFieldStyle.withIcon(
                      labelText: "Buscar",
                      leftIcon: const Padding(
                        padding:
                            EdgeInsets.only(top: 8.0, bottom: 8.0, right: 10.0),
                        child: Icon(
                          Icons.search,
                          color: Colors.indigo,
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 20.0,
                  ),
                  Expanded(
                    child: ListView.separated(
                      itemCount: snapshot.data!.length,
                      itemBuilder: (context, index) {
                        return _contact(
                            context,
                            snapshot.data![index].name ?? "",
                            snapshot.data![index].dni ?? "");
                      },
                      separatorBuilder: (context, index) {
                        return const SizedBox(
                          height: 8.0,
                        );
                      },
                    ),
                  )
                ],
              ),
            );
          }),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          RedirectService.goTo(
              context,
              CreateContact(
                contactsBloc: contactsBloc,
              ));
        },
        backgroundColor: Colors.indigo,
        child: const Icon(
          Icons.person_add_alt_rounded,
          size: 30.0,
        ),
      ),
      bottomNavigationBar: const BottomBar(selectedIndex: 1),
    );
  }

  _contact(BuildContext context, String name, String document) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        const Icon(
          Icons.contact_phone_rounded,
          size: 30.0,
          color: Colors.lightBlue,
        ),
        const SizedBox(
          width: 8.0,
        ),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(name),
            const SizedBox(
              height: 2.0,
            ),
            Text(document),
          ],
        ),
      ],
    );
  }
}
