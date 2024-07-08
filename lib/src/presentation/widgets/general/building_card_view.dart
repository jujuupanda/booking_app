import 'package:flutter/material.dart';
import 'package:gap/gap.dart';

import '../../utils/constant/constant.dart';

class BuildingCardView extends StatelessWidget {
  const BuildingCardView({
    super.key,
    required this.imagePath,
    required this.buildingName,
    required this.capacity,
    required this.status,
    required this.function
  });

  final String imagePath;
  final String buildingName;
  final String capacity;
  final String status;
  final VoidCallback function;

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
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Row(
          children: [
            Image.asset(
              height: 150,
              width: 150,
              imageNoConnection,
              scale: 1,
              fit: BoxFit.fill,
            ),
            const Gap(10),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    buildingName,
                    maxLines: 5,
                    overflow: TextOverflow.ellipsis,
                    style: const TextStyle(fontSize: 18),
                  ),
                  Text(
                    "Kapasitas: $capacity",
                  ),
                  Text(
                    "Status: $status",
                  ),
                  Align(
                    alignment: Alignment.bottomRight,
                    child: Container(
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(15),
                          color: Colors.blueAccent),
                      child: Material(
                        color: Colors.transparent,
                        child: InkWell(
                          onTap: function,
                          borderRadius: BorderRadius.circular(16),
                          child: const Padding(
                            padding: EdgeInsets.all(8.0),
                            child: Text(
                              "Selengkapnya",
                              style: TextStyle(fontSize: 14, color: Colors.white),
                            ),
                          ),
                        ),
                      ),
                    ),
                  )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
