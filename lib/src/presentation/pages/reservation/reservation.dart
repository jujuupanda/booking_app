import 'package:flutter/material.dart';

import '../../widgets/general/header_pages.dart';

class ReservationPage extends StatelessWidget {
  const ReservationPage({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(
        child: Column(
          children: [
            HeaderPage(),
            Text("Search Bar"),
            Text("List Gedung"),
          ],
        ),
      ),
    );
  }
}
