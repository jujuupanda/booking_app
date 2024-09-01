import 'package:flutter/material.dart';

class FieldNonEditable extends StatelessWidget {
  const FieldNonEditable({
    super.key,
    required this.usernameController,
    required this.prefixIcon,
  });

  final TextEditingController usernameController;
  final IconData prefixIcon;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(
        top: 6,
        bottom: 12,
      ),
      child: TextFormField(
        controller: usernameController,
        readOnly: true,
        decoration: InputDecoration(
          border: const OutlineInputBorder(),
          prefixIcon: Icon(prefixIcon),
        ),
      ),
    );
  }
}