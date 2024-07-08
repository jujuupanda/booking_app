
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:go_router/go_router.dart';

import '../../utils/routes/route_name.dart';
import '../../widgets/general/header_pages.dart';
import '../../widgets/general/room_card_view.dart';

class BuildingPage extends StatelessWidget {
  const BuildingPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          const HeaderPage(name: "Gedung",),
          const Gap(20),
          Expanded(
            child: ListView.builder(
              padding: EdgeInsets.zero,
              itemCount: 5,
              itemBuilder: (context, index) {
                return InkWell(
                  onTap: () {
                    context.pushNamed(Routes().detailBuilding);
                  },
                  child: const Padding(
                    padding: EdgeInsets.all(8.0),
                    child: RoomCardView(),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}

/// tambahkan detial info gedung ketika diklik
