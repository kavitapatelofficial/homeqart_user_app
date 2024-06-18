import 'package:flutter/material.dart';

import '../../../text_theme.dart';
import '../../../theme.dart';

class DecorationTheme {
  static InputDecoration inputFieldDecoration(String hintText) {
    return InputDecoration(
      fillColor: AppColor.accentWhite,
      filled: true,
      border: InputBorder.none,
      hintText: hintText,
      hintStyle:
          Texttheme.titleRegular.copyWith(color: AppColor.accentDarkGrey),
      contentPadding: const EdgeInsets.only(left: 25.0),
    );
  }
}
