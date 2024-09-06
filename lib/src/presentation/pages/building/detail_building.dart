import 'package:cached_network_image/cached_network_image.dart';
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
                    Builder(
                      builder: (context) {
                        if (widget.building.image! == "") {
                          return const Image(
                            height: 250,
                            width: double.infinity,
                            fit: BoxFit.cover,
                            image: AssetImage(assetsDefaultBuildingImage),
                          );
                        } else {
                          return CachedNetworkImage(
                            height: 250,
                            width: double.infinity,
                            imageUrl: widget.building.image!,
                            placeholder: (context, url) {
                              return const Center(
                                child: CircularProgressIndicator(),
                              );
                            },
                            errorWidget: (context, url, error) {
                              return const Image(
                                height: 250,
                                width: double.infinity,
                                fit: BoxFit.cover,
                                image: AssetImage(assetsDefaultBuildingImage),
                              );
                            },
                          );
                        }
                      },
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
