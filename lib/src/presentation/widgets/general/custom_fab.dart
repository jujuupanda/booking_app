import 'package:flutter/material.dart';

class CustomFAB extends StatelessWidget {
  const CustomFAB({
    super.key,
    required this.function,
  });

  final VoidCallback function;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(90),
          border: Border.all(
            width: 1,
            color: Colors.blueAccent.shade400,
          )),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          borderRadius: BorderRadius.circular(90),
          splashColor: Colors.blueAccent,
          onTap: function,
          child: const Padding(
            padding: EdgeInsets.all(2),
            child: Icon(
              Icons.add,
              size: 36,
              color: Colors.blueAccent,
            ),
          ),
        ),
      ),
    );
  }
}
