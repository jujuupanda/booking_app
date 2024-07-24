import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:go_router/go_router.dart';
import 'package:reservation_app/src/data/model/building_model.dart';

import '../../utils/constant/constant.dart';
import '../../widgets/general/header_pages.dart';

class DetailBuilding extends StatelessWidget {
  const DetailBuilding({super.key, required this.building});

  final BuildingModel building;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          InkWell(
            onTap: () {
              context.pop();
            },
            child: const HeaderPage(
              name: "Detail Gedung",
            ),
          ),
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
                            building.name!,
                            style: const TextStyle(
                              fontWeight: FontWeight.w500,
                              fontSize: 16,
                            ),
                          ),
                          Text(
                            building.description!,
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
                            building.facility!,
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
                                "${building.capacity!.toString()} Orang",
                                style: const TextStyle(
                                  fontSize: 12,
                                ),
                              ),
                            ],
                          ),
                          const Gap(10),
                          const Text(
                            "Ketentuan Berlaku",
                            style: TextStyle(
                              fontWeight: FontWeight.w500,
                              fontSize: 16,
                            ),
                          ),
                          Text(
                            building.rule!,
                            style: const TextStyle(
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
