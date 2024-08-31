import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class FieldEditableEditPage extends StatelessWidget {
  const FieldEditableEditPage({
    super.key,
    required this.fieldName,
    required this.controller,
    required this.prefixIcon,
  });

  final String fieldName;
  final TextEditingController controller;
  final IconData prefixIcon;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(
        top: 6,
        bottom: 12,
      ),
      child: TextFormField(
        controller: controller,
        readOnly: fieldName == "Username" || fieldName == "Instansi" ? true : false,
        obscureText: prefixIcon == Icons.lock ? true : false,
        validator: (value) {
          if (value == null || value.isEmpty) {
            return '$fieldName tidak boleh kosong!';
          } else {
            return null;
          }
        },
        decoration: InputDecoration(
          border: const OutlineInputBorder(),
          prefixIcon: Icon(prefixIcon),
          hintStyle: GoogleFonts.openSans(),
          hintText: fieldName,
        ),
      ),
    );
  }
}
