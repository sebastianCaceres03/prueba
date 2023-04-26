import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:prueba/common/services/redirect_services.dart';

class ModalPhoto {
  modal(BuildContext context, {required Function(XFile? photo) changeImage}) {
    final ImagePicker picker = ImagePicker();
    return showModalBottomSheet(
      shape: const OutlineInputBorder(
        borderSide: BorderSide(
          color: Colors.white,
        ),
        borderRadius: BorderRadius.only(
          topRight: Radius.circular(20.0),
          topLeft: Radius.circular(20.0),
        ),
      ),
      context: context,
      builder: (context) {
        return Container(
          decoration: const BoxDecoration(
              borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(16.0),
                  topRight: Radius.circular(16.0)),
              color: Colors.white),
          height: 190.0,
          child: Column(
            children: [
              ListTile(
                contentPadding: const EdgeInsets.symmetric(
                    horizontal: 30.0, vertical: 20.0),
                leading: const Icon(
                  Icons.camera_alt,
                  size: 30.0,
                  color: Colors.lightBlue,
                ),
                title: const Text("Camara"),
                onTap: () async {
                  final XFile? photo =
                      await picker.pickImage(source: ImageSource.camera);
                  if (photo != null) {
                    changeImage(photo);
                  }
                  RedirectService.pop(context);
                },
              ),
              ListTile(
                contentPadding: const EdgeInsets.only(
                    left: 30.0, right: 30.0, bottom: 20.0),
                leading: const Icon(
                  Icons.photo_library_outlined,
                  size: 30.0,
                  color: Colors.indigo,
                ),
                title: const Text("Galeria"),
                onTap: () async {
                  final XFile? photo =
                      await picker.pickImage(source: ImageSource.gallery);
                  if (photo != null) {
                    changeImage(photo);
                  }
                   RedirectService.pop(context);
                },
              ),
            ],
          ),
        );
      },
    );
  }
}
