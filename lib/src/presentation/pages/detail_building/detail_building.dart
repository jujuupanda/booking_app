import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:go_router/go_router.dart';
import 'package:reservation_app/src/data/model/building_model.dart';
import 'package:reservation_app/src/presentation/utils/general/parsing.dart';
import 'package:reservation_app/src/presentation/widgets/general/header_detail_page.dart';

import '../../utils/constant/constant.dart';
import '../../widgets/general/header_pages.dart';

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
          const HeaderDetailPage(pageName: "Detail Gedung"),
          Expanded(
            child: RefreshIndicator(
              onRefresh: () async {},
              child: SingleChildScrollView(
                physics: const AlwaysScrollableScrollPhysics(),
                child: Column(
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
                            style: const TextStyle(
                              fontWeight: FontWeight.w500,
                              fontSize: 16,
                            ),
                          ),
                          Text(
                            widget.building.description!,
                            style: const TextStyle(
                              fontSize: 12,
                            ),
                          ),
                          const Gap(10),
                          const Text(
                            "Fasilitas",
                            style: TextStyle(
                              fontWeight: FontWeight.w500,
                              fontSize: 16,
                            ),
                          ),
                          Text(
                            widget.building.facility!,
                            style: const TextStyle(
                              fontSize: 12,
                            ),
                          ),
                          const Gap(10),
                          const Text(
                            "Kapasitas",
                            style: TextStyle(
                              fontWeight: FontWeight.w500,
                              fontSize: 16,
                            ),
                          ),
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              const Icon(Icons.groups),
                              const Gap(8),
                              Text(
                                "${widget.building.capacity!.toString()} Orang",
                                style: const TextStyle(
                                  fontSize: 12,
                                ),
                              ),
                            ],
                          ),
                          const Gap(10),
                          const Text(
                            "Peraturan",
                            style: TextStyle(
                              fontWeight: FontWeight.w500,
                              fontSize: 16,
                            ),
                          ),
                          Text(
                            widget.building.rule!,
                            style: const TextStyle(
                              fontSize: 12,
                            ),
                          ),
                          const Gap(10),
                          const Text(
                            "Status Gedung/Ruangan",
                            style: TextStyle(
                              fontWeight: FontWeight.w500,
                              fontSize: 16,
                            ),
                          ),
                          Column(
                            children: [
                              Row(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  const Icon(Icons.check_box_rounded),
                                  const Gap(8),
                                  Text(
                                    widget.building.status!,
                                    style: const TextStyle(
                                      fontSize: 12,
                                    ),
                                  ),
                                ],
                              ),
                              (widget.building.usedUntil != "") ?
                              Row(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  const Icon(Icons.info),
                                  const Gap(8),
                                  Text(
                                    "Digunakan sampai ${ParsingDate().convertDate(widget.building.usedUntil!)}",
                                    style: const TextStyle(
                                      fontSize: 12,
                                    ),
                                  ),
                                ],
                              ) : const SizedBox(),
                            ],
                          )
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
