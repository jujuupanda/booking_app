import 'package:flutter/material.dart';

class FieldEditable extends StatelessWidget {
  const FieldEditable({
    super.key,
    required this.controller,
    required this.function,
    required this.prefixIcon,
    required this.suffixIcon,
  });

  final TextEditingController controller;
  final VoidCallback function;
  final IconData prefixIcon;
  final IconData suffixIcon;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(
        top: 6,
        bottom: 12,
      ),
      child: TextFormField(
        controller: controller,
        readOnly: true,
        obscureText: prefixIcon == Icons.lock ? true : false,
        decoration: InputDecoration(
          border: const OutlineInputBorder(),
          prefixIcon: Icon(prefixIcon),
          suffixIcon: InkWell(
            onTap: function,
            customBorder: const CircleBorder(),
            child: Icon(suffixIcon),
          ),
        ),
      ),
    );
  }
}
