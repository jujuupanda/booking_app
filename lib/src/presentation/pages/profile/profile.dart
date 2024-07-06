import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:go_router/go_router.dart';

import '../../utils/routes/route_name.dart';
import '../../widgets/general/header_pages.dart';

class ProfilePage extends StatelessWidget {
  const ProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          children: [
            const HeaderPage(),
            Expanded(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text(
                    "Nama: Ekskul A",
                    style: TextStyle(fontSize: 30),
                  ),
                  const Gap(30),
                  ElevatedButton(
                      onPressed: () {
                        context.goNamed(Routes().login);
                      },
                      child: const Text("Keluar")),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
