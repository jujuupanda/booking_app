import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:reservation_app/src/data/model/building_model.dart';

import '../../utils/constant/constant.dart';

class BuildingCardView extends StatelessWidget {
  const BuildingCardView({
    super.key,
    required this.building,
    required this.function,
  });

  final BuildingModel building;
  final VoidCallback function;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        border: Border.all(
          width: 1.5,
          color: Colors.grey,
        ),
        borderRadius: BorderRadius.circular(10),
      ),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              height: 120,
              width: 100,
              child: ClipRRect(
                borderRadius: BorderRadius.circular(10),
                child: Image.asset(
                  imageNoConnection,
                  scale: 1,
                  fit: BoxFit.cover,
                ),
              ),
            ),
            const Gap(10),
            Expanded(
              child: SizedBox(
                height: 120,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      building.name!,
                      maxLines: 5,
                      overflow: TextOverflow.ellipsis,
                      style: const TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    Text(
                      "Kapasitas: ${building.capacity}",
                      style: const TextStyle(fontSize: 12),
                    ),
                    Expanded(
                      child: Text(
                        "Status: ${building.status}",
                        style: const TextStyle(fontSize: 12),
                      ),
                    ),
                    const Spacer(),
                    Align(
                      alignment: Alignment.bottomRight,
                      child: Container(
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            color: Colors.blueAccent),
                        child: Material(
                          color: Colors.transparent,
                          child: InkWell(
                            onTap: function,
                            borderRadius: BorderRadius.circular(10),
                            child:  Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Text(
                                "Selengkapnya",
                                style: GoogleFonts.openSans(
                                    fontSize: 12, color: Colors.white),
                              ),
                            ),
                          ),
                        ),
                      ),
                    )
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
