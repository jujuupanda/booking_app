import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:reservation_app/src/data/model/building_model.dart';
import 'package:reservation_app/src/presentation/widgets/general/header_detail_page.dart';

import '../../utils/constant/constant.dart';

class DetailBuilding extends StatefulWidget {
  const DetailBuilding({super.key, required this.building});

  final BuildingModel building;

  @override
  State<DetailBuilding> createState() => _DetailBuildingState();
}

class _DetailBuildingState extends State<DetailBuilding> {
  late TextEditingController facilityController;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          HeaderDetailPage(
            pageName: widget.building.name!,
          ),
          Expanded(
            child: RefreshIndicator(
              onRefresh: () async {},
              child: SingleChildScrollView(
                physics: const AlwaysScrollableScrollPhysics(),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Gap(15),
                    SizedBox(
                      height: 250,
                      width: double.infinity,
                      child: Image.asset(
                        imageNoConnection,
                        fit: BoxFit.cover,
                      ),
                    ),
                    const Gap(15),
                    Padding(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 12,
                        vertical: 8,
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            widget.building.name!,
                            style: GoogleFonts.openSans(
                              fontWeight: FontWeight.w600,
                              fontSize: 14,
                            ),
                          ),
                          Text(
                            widget.building.description!,
                            style: GoogleFonts.openSans(
                              fontWeight: FontWeight.w500,
                              fontSize: 12,
                            ),
                          ),
                          const Gap(10),
                          Text(
                            "Fasilitas",
                            style: GoogleFonts.openSans(
                              fontWeight: FontWeight.w600,
                              fontSize: 14,
                            ),
                          ),
                          Text(
                            widget.building.facility!,
                            style: GoogleFonts.openSans(
                              fontWeight: FontWeight.w500,
                              fontSize: 12,
                            ),
                          ),
                          const Gap(10),
                          Text(
                            "Kapasitas",
                            style: GoogleFonts.openSans(
                              fontWeight: FontWeight.w600,
                              fontSize: 14,
                            ),
                          ),
                          Text(
                            "${widget.building.capacity!.toString()} Orang",
                            style: GoogleFonts.openSans(
                              fontWeight: FontWeight.w500,
                              fontSize: 12,
                            ),
                          ),
                          const Gap(10),
                          Text(
                            "Peraturan",
                            style: GoogleFonts.openSans(
                              fontWeight: FontWeight.w600,
                              fontSize: 14,
                            ),
                          ),
                          Text(
                            widget.building.rule!,
                            style: GoogleFonts.openSans(
                              fontWeight: FontWeight.w500,
                              fontSize: 12,
                            ),
                          ),
                          const Gap(10),
                          Text(
                            "Status Gedung/Ruangan",
                            style: GoogleFonts.openSans(
                              fontWeight: FontWeight.w600,
                              fontSize: 14,
                            ),
                          ),
                          Text(
                            widget.building.status!,
                            style: GoogleFonts.openSans(
                              fontWeight: FontWeight.w500,
                              fontSize: 12,
                            ),
                          ),
                        ],
                      ),
                    ),
                    const Gap(60),
                  ],
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}
