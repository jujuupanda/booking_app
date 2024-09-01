import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class ButtonAcceptDecline extends StatelessWidget {
  const ButtonAcceptDecline({
    super.key,
    required this.name,
    required this.function,
  });

  final String name;
  final VoidCallback function;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 90,
      decoration: name == "Terima"
          ? BoxDecoration(
              borderRadius: BorderRadius.circular(8),
              color: Colors.blueAccent,
              border: Border.all(
                width: 1,
                color: Colors.white,
              ),
            )
          : BoxDecoration(
              borderRadius: BorderRadius.circular(8),
              color: Colors.redAccent,
              border: Border.all(
                width: 1,
                color: Colors.white,
              ),
            ),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          borderRadius: BorderRadius.circular(8),
          onTap: function,
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 4),
            child: Center(
              child: Text(
                name,
                style: GoogleFonts.openSans(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
