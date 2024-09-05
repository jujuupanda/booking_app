import 'package:flutter/material.dart';
import 'package:gap/gap.dart';

import '../../../data/model/building_model.dart';
import '../../utils/constant/constant.dart';
import '../../widgets/general/header_detail_page.dart';
import '../../widgets/general/widget_title_subtitle.dart';

class DetailBuilding extends StatefulWidget {
  const DetailBuilding({super.key, required this.building});

  final BuildingModel building;

  @override
  State<DetailBuilding> createState() => _DetailBuildingState();
}

class _DetailBuildingState extends State<DetailBuilding> {
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
                          TitleSubtitleDetailPage(
                            title: widget.building.name!,
                            subtitle: widget.building.description!,
                            isTitle: true,
                          ),
                          TitleSubtitleDetailPage(
                            title: "Fasilitas",
                            subtitle: widget.building.facility!,
                          ),
                          TitleSubtitleDetailPage(
                            title: "Kapasitas",
                            subtitle:
                            "${widget.building.capacity!.toString()} Orang",
                          ),
                          TitleSubtitleDetailPage(
                            title: "Peraturan",
                            subtitle: widget.building.rule!,
                          ),
                          TitleSubtitleDetailPage(
                            title: "Status Gedung/Ruangan",
                            subtitle: widget.building.status!,
                          ),
                        ],
                      ),
                    ),
                    const Gap(60),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
