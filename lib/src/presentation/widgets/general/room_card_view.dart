import 'package:flutter/material.dart';
import 'package:gap/gap.dart';

import '../../utils/constant/constant.dart';

class RoomCardView extends StatelessWidget {
  const RoomCardView({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        border: Border.all(
          width: 1.5,
          color: Colors.grey,
        ),
        borderRadius: BorderRadius.circular(15),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Image.asset(
            height: 150,
            width: 150,
            imageNoConnection,
            scale: 1,
            fit: BoxFit.fill,
          ),
          const Gap(10),
          const Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Ruang 1 Gedung 1 Sekolah 1",
                  maxLines: 5,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(fontSize: 22),
                ),
                Text(
                  "Kapasitas: 100 Orang",
                ),
                Text(
                  "Status: Tersedia",
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
