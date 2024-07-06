import 'package:flutter/material.dart';

import '../../widgets/general/header_pages.dart';
import '../../widgets/general/room_card_view.dart';

class HistoryPage extends StatelessWidget {
  const HistoryPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          children: [
            const HeaderPage(),
            const Text("Riwayat Reservasi"),
            Expanded(
              child: ListView.builder(
                padding: EdgeInsets.zero,
                itemCount: 6,
                itemBuilder: (context, index) {
                  return const RoomCardView();
                },
              ),
            )
          ],
        ),
      ),
    );
  }
}
