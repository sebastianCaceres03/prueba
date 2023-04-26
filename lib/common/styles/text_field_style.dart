import 'package:flutter/material.dart';

class TextFieldStyle {
  static InputDecoration general({String labelText = ""}) {
    return InputDecoration(
      contentPadding: const EdgeInsets.symmetric(horizontal: 15),
      fillColor: Colors.transparent,
      focusColor: Colors.white,
      hoverColor: Colors.white,
      focusedBorder: const UnderlineInputBorder(
        borderSide: BorderSide(color: Colors.white),
      ),
      filled: true,
      counterText: "",
      labelText: labelText,
      labelStyle: const TextStyle(
        color: Colors.white,
        fontWeight: FontWeight.w700,
        fontSize: 16,
      ),
      enabledBorder: const UnderlineInputBorder(
        borderSide: BorderSide(color: Colors.white),
      ),
      errorBorder: const UnderlineInputBorder(
        borderSide: BorderSide(color: Colors.red),
      ),
    );
  }

  static textStyle({Color colorText = Colors.white, double fontSize = 16.0}) {
    return TextStyle(
      color: colorText,
      fontWeight: FontWeight.w500,
      fontSize: fontSize,
    );
  }

  static InputDecoration withIcon({
    String labelText = "",
    Widget? icon,
    Widget? leftIcon,
    Color colorInput = Colors.indigo,
  }) {
    return InputDecoration(
      contentPadding: const EdgeInsets.symmetric(horizontal: 15),
      filled: true,
      counterText: "",
      fillColor: Colors.transparent,
      focusColor: colorInput,
      hoverColor: colorInput,
      suffixIcon: icon,
      prefixIcon: leftIcon,
      labelText: labelText,
      labelStyle: TextStyle(
        color: colorInput,
        fontWeight: FontWeight.w700,
        fontSize: 16,
      ),
      enabledBorder: UnderlineInputBorder(
        borderSide: BorderSide(color: colorInput),
      ),
      focusedBorder: UnderlineInputBorder(
        borderSide: BorderSide(color: colorInput),
      ),
    );
  }
}