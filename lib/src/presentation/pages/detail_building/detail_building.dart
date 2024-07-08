import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:go_router/go_router.dart';

import '../../utils/constant/constant.dart';
import '../../widgets/general/header_pages.dart';

class DetailBuilding extends StatelessWidget {
  const DetailBuilding({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          InkWell(
              onTap: () {
                context.pop();
              },
              child: const HeaderPage(name: "Detail Gedung",)),
          Expanded(
            child: Column(
              children: [
                const Gap(15),
                Image.asset(
                  imageNoConnection,
                  height: 250,
                  width: 350,
                  fit: BoxFit.fill,
                ),
                const Gap(15),
                const Text("Detail Building ada disini"),
              ],
            ),
          )
        ],
      ),
    );
  }
}
