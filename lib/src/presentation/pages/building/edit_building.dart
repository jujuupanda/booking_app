import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';
import 'package:reservation_app/src/presentation/widgets/general/widget_custom_subtitle.dart';
import 'package:reservation_app/src/presentation/widgets/general/pop_up.dart';
import 'package:reservation_app/src/presentation/widgets/general/widget_custom_text_form_field.dart';

import '../../../data/bloc/building/building_bloc.dart';
import '../../../data/model/building_model.dart';
import '../../widgets/general/button_positive.dart';
import '../../widgets/general/header_detail_page.dart';

class EditBuildingPage extends StatefulWidget {
  const EditBuildingPage({super.key, required this.building});

  final BuildingModel building;

  @override
  State<EditBuildingPage> createState() => _EditBuildingPageState();
}

class _EditBuildingPageState extends State<EditBuildingPage> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  late TextEditingController buildingNameController;
  late TextEditingController descController;
  late TextEditingController facilityController;
  late TextEditingController capacityController;
  late TextEditingController ruleController;
  late TextEditingController imageController;
  late BuildingBloc _buildingBloc;

  /// update gedung
  updateBuilding() {
    return () {
      _buildingBloc = context.read<BuildingBloc>();
      _buildingBloc.add(
        UpdateBuilding(
          widget.building.id!,
          buildingNameController.text,
          descController.text,
          facilityController.text,
          int.parse(capacityController.text),
          ruleController.text,
          imageController.text,
        ),
      );
    };
  }

  @override
  void initState() {
    buildingNameController = TextEditingController(text: widget.building.name);
    descController = TextEditingController(text: widget.building.description);
    facilityController = TextEditingController(text: widget.building.facility);
    capacityController =
        TextEditingController(text: widget.building.capacity.toString());
    ruleController = TextEditingController(text: widget.building.rule);
    imageController = TextEditingController(text: widget.building.image);
    super.initState();
  }

  @override
  void dispose() {
    buildingNameController.dispose();
    descController.dispose();
    facilityController.dispose();
    capacityController.dispose();
    ruleController.dispose();
    imageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<BuildingBloc, BuildingState>(
      listener: (context, state) {
        if (state is BuildingUpdateSuccess) {
          PopUp().whenSuccessDoSomething(
            context,
            "Perubahan berhasil",
            Icons.check_circle,
            true,
          );
        }
      },
      child: Scaffold(
        body: Stack(
          children: [
            Column(
              children: [
                const HeaderDetailPage(pageName: "Edit Gedung"),
                Expanded(
                  child: RefreshIndicator(
                    onRefresh: () async {
                      setState(() {
                        buildingNameController =
                            TextEditingController(text: widget.building.name);
                        descController = TextEditingController(
                            text: widget.building.description);
                        facilityController = TextEditingController(
                            text: widget.building.facility);
                        capacityController = TextEditingController(
                            text: widget.building.capacity.toString());
                        ruleController =
                            TextEditingController(text: widget.building.rule);
                        imageController =
                            TextEditingController(text: widget.building.image);
                      });
                    },
                    child: SingleChildScrollView(
                      physics: const AlwaysScrollableScrollPhysics(),
                      child: Padding(
                        padding: const EdgeInsets.symmetric(
                            vertical: 12, horizontal: 8),
                        child: Form(
                          key: _formKey,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const Gap(10),
                              const CustomSubtitleWidget(
                                subtitle: "Nama Gedung",
                              ),
                              CustomTextFormField(
                                fieldName: "Nama Gedung",
                                controller: buildingNameController,
                                prefixIcon: Icons.corporate_fare,
                              ),
                              const CustomSubtitleWidget(
                                subtitle: "Deskripsi",
                              ),
                              CustomTextFormField(
                                fieldName: "Deskripsi Gedung",
                                controller: descController,
                                prefixIcon: Icons.description,
                              ),
                              const CustomSubtitleWidget(
                                subtitle: "Fasilitas",
                              ),
                              CustomTextFormField(
                                fieldName: "Fasilitas Gedung",
                                controller: facilityController,
                                prefixIcon: Icons.badge,
                              ),
                              const CustomSubtitleWidget(
                                subtitle: "Kapasitas",
                              ),
                              CustomTextFormField(
                                fieldName: "Kapasitas Gedung",
                                controller: capacityController,
                                prefixIcon: Icons.groups,
                              ),
                              const CustomSubtitleWidget(
                                subtitle: "Peraturan",
                              ),
                              CustomTextFormField(
                                fieldName: "Peraturan Gedung",
                                controller: ruleController,
                                prefixIcon: Icons.rule,
                              ),
                              const CustomSubtitleWidget(
                                subtitle: "Gambar",
                              ),
                              CustomTextFormField(
                                fieldName: "Gambar",
                                controller: imageController,
                                prefixIcon: Icons.add_photo_alternate,
                              ),
                              const Gap(20),
                              Align(
                                alignment: Alignment.bottomRight,
                                child: ButtonPositive(
                                  name: "Simpan",
                                  function: () {
                                    if (_formKey.currentState!.validate()) {
                                      PopUp().whenDoSomething(
                                        context,
                                        "Simpan perubahan?",
                                        Icons.question_mark,
                                        updateBuilding(),
                                      );
                                    }
                                  },
                                ),
                              ),
                              const Gap(30),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
            Center(
              child: BlocBuilder<BuildingBloc, BuildingState>(
                builder: (context, state) {
                  if (state is BuildingLoading) {
                    return Container(
                      decoration: const BoxDecoration(
                        color: Color(0x80FFFFFF),
                      ),
                      child: const Center(
                        child: CircularProgressIndicator(),
                      ),
                    );
                  }
                  return const SizedBox();
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
