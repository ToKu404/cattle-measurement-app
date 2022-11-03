import 'package:cattle_app/core/constants/color_const.dart';
import 'package:flutter/material.dart';

class InputField extends StatelessWidget {
  final TextEditingController controller;
  final String hint;

  const InputField({Key? key, required this.controller, required this.hint})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      onChanged: (value) {},
      controller: controller,
      keyboardType: TextInputType.number,
      style: const TextStyle(
        fontSize: 14,
        color: Colors.black,
      ),
      cursorColor: Palette.primary,
      decoration: InputDecoration(
        filled: true,
        hintText: hint,
        enabledBorder: OutlineInputBorder(
          borderSide: const BorderSide(color: Palette.gray4, width: 1.0),
          borderRadius: BorderRadius.circular(10.0),
        ),
        focusedBorder: OutlineInputBorder(
          borderSide: const BorderSide(color: Palette.primary, width: 1.0),
          borderRadius: BorderRadius.circular(10.0),
        ),
      ),
    );
  }
}
