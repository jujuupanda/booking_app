import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../data/model/building_model.dart';
import '../../utils/constant/constant.dart';

class BuildingCardView extends StatelessWidget {
  const BuildingCardView({
    super.key,
    required this.building,
    required this.detailFunction,
    required this.editFunction,
    required this.deleteFunction,
    required this.role,
  });

  final BuildingModel building;
  final VoidCallback detailFunction;
  final VoidCallback editFunction;
  final VoidCallback deleteFunction;
  final String role;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: role == "1"? 140 : 110,
      decoration: BoxDecoration(
        border: Border.all(
          width: 1.5,
          color: Colors.grey,
        ),
        borderRadius: BorderRadius.circular(10),
      ),
      child: Column(
        children: [
          Expanded(
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(10),
                      child: Image.asset(
                        imageNoConnection,
                        scale: 1,
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                ),
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          building.name!,
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                          style: GoogleFonts.openSans(
                            fontWeight: FontWeight.bold,
                            fontSize: 14,
                          ),
                        ),
                        Text(
                          "Kapasitas: ${building.capacity}",
                          style: GoogleFonts.openSans(
                            fontWeight: FontWeight.w600,
                            fontSize: 12,
                          ),
                        ),
                        Expanded(
                          child: Text(
                            "Status: ${building.status}",
                            style: GoogleFonts.openSans(
                              fontWeight: FontWeight.w600,
                              fontSize: 12,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                SizedBox(
                  height: double.maxFinite,
                  child: Material(
                    color: Colors.transparent,
                    child: InkWell(
                      onTap: detailFunction,
                      borderRadius: const BorderRadius.only(
                        topRight: Radius.circular(10),
                        bottomRight: Radius.circular(10),
                      ),
                      child: const Padding(
                        padding: EdgeInsets.all(4),
                        child: Icon(
                          Icons.arrow_forward_ios_rounded,
                          size: 24,
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
          adminBehavior(role),
        ],
      ),
    );
  }

  adminBehavior(String role) {
    if (role == "1") {
      return Column(
        children: [
          const Divider(
            thickness: 0.5,
            height: 1,
          ),
          Padding(
            padding: const EdgeInsets.all(4),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Material(
                    color: Colors.transparent,
                    child: InkWell(
                      onTap: editFunction,
                      borderRadius: BorderRadius.circular(10),
                      child: const Padding(
                        padding: EdgeInsets.all(4),
                        child: Icon(
                          Icons.edit,
                          size: 24,
                        ),
                      ),
                    ),
                  ),
                ),
                const Gap(8),
                Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Material(
                    color: Colors.transparent,
                    child: InkWell(
                      onTap: deleteFunction,
                      borderRadius: BorderRadius.circular(10),
                      child: const Padding(
                        padding: EdgeInsets.all(4),
                        child: Icon(
                          Icons.delete,
                          size: 24,
                        ),
                      ),
                    ),
                  ),
                )
              ],
            ),
          ),
        ],
      );
    } else {
      return const SizedBox();
    }
  }
}
