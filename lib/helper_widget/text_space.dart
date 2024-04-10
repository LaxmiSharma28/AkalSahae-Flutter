
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class SpaceAfterThreeAndFourDigitsFormatter extends TextInputFormatter {
  @override
  TextEditingValue formatEditUpdate(
      TextEditingValue oldValue, TextEditingValue newValue) {
    final newText = newValue.text.replaceAll(RegExp(r'\s'), ''); // Remove existing spaces
    final length = newText.length;

    String formatted = '';
    for (int i = 0; i < length; i++) {
      if (i == 3 || i == 7 ) {
        formatted += ' ';
      }
      formatted += newText[i];
    }

    return newValue.copyWith(
      text: formatted,
      selection: TextSelection.collapsed(offset: formatted.length),
    );
  }
}



