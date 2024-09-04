import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../data/bloc/building/building_bloc.dart';
import '../../utils/routes/route_name.dart';
import '../../widgets/general/button_positive.dart';
import '../../widgets/general/header_detail_page.dart';
import '../../widgets/general/pop_up.dart';
import '../../widgets/general/widget_custom_text_form_field.dart';
import '../../widgets/general/widget_custom_subtitle.dart';
import 'widget_edit_building_card_view.dart';

class AddBuildingPage extends StatefulWidget {
  const AddBuildingPage({super.key});

  @override
  State<AddBuildingPage> createState() => _AddBuildingPageState();
}

class _AddBuildingPageState extends State<AddBuildingPage>
    with TickerProviderStateMixin {
  late TextEditingController buildingNameController;
  late TextEditingController descController;
  late TextEditingController facilityController;
  late TextEditingController capacityController;
  late TextEditingController ruleController;
  late TextEditingController imageController;
  late TextEditingController statusController;
  late TabController _tabController;
  late BuildingBloc _buildingBloc;
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  /// menambahkan gedung
  addBuilding() {
    return () {
      _buildingBloc = context.read<BuildingBloc>();
      _buildingBloc.add(
        AddBuilding(
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

  /// mendapatkan info gedung
  _getBuilding() {
    _buildingBloc = context.read<BuildingBloc>();
    _buildingBloc.add(GetBuildingByAgency());
  }

  /// menghapus gedung
  deleteBuilding(String id) {
    return () {
      _buildingBloc = context.read<BuildingBloc>();
      _buildingBloc.add(DeleteBuilding(id));
    };
  }

  @override
  void initState() {
    buildingNameController = TextEditingController();
    descController = TextEditingController();
    facilityController = TextEditingController();
    capacityController = TextEditingController();
    ruleController = TextEditingController();
    imageController = TextEditingController();
    statusController = TextEditingController();
    _tabController = TabController(length: 2, vsync: this);
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
    _tabController.dispose();
    buildingNameController.dispose();
    descController.dispose();
    facilityController.dispose();
    capacityController.dispose();
    ruleController.dispose();
    imageController.dispose();
    statusController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<BuildingBloc, BuildingState>(
      listener: (context, state) {
        if (state is BuildingAddSuccess) {
          PopUp().whenSuccessDoSomething(
            context,
            "Berhasil menambah gedung",
            Icons.check_circle,
            true,
          );
        } else if (state is BuildingDeleteSuccess) {
          PopUp().whenSuccessDoSomething(
            context,
            "Berhasil menghapus gedung",
            Icons.check_circle,
            true,
          );
          context.pop();
        }
      },
      child: DefaultTabController(
        length: 2,
        child: Scaffold(
          body: Stack(
            children: [
              Column(
                children: [
                  const HeaderDetailPage(
                    pageName: "Tambah Gedung",
                  ),
                  TabBar(
                    controller: _tabController,
                    indicatorSize: TabBarIndicatorSize.tab,
                    labelStyle: GoogleFonts.openSans(
                      fontWeight: FontWeight.bold,
                    ),
                    tabs: const [
                      Tab(text: 'Tambah'),
                      Tab(text: 'Edit/Hapus'),
                    ],
                  ),
                  Expanded(
                    child: TabBarView(
                      controller: _tabController,
                      children: [
                        ///first tab bar
                        addBuildingContent(),

                        ///second tab bar
                        manageBuildingContent(),
                      ],
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
      ),
    );
  }

  RefreshIndicator addBuildingContent() {
    return RefreshIndicator(
      onRefresh: () async {},
      child: SingleChildScrollView(
        physics: const AlwaysScrollableScrollPhysics(),
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 8),
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Gap(10),
                const CustomSubtitleWidget(subtitle: "Nama Gedung"),
                CustomTextFormField(
                  fieldName: "Nama Gedung",
                  controller: buildingNameController,
                  prefixIcon: Icons.corporate_fare,
                ),
                const CustomSubtitleWidget(subtitle: "Deskripsi"),
                CustomTextFormField(
                  fieldName: "Deskripsi Gedung",
                  controller: descController,
                  prefixIcon: Icons.description,
                ),
                const CustomSubtitleWidget(subtitle: "Fasilitas"),
                CustomTextFormField(
                  fieldName: "Fasilitas Gedung",
                  controller: facilityController,
                  prefixIcon: Icons.badge,
                ),
                const CustomSubtitleWidget(subtitle: "Kapasitas"),
                CustomTextFormField(
                  fieldName: "Kapasitas Gedung",
                  controller: capacityController,
                  prefixIcon: Icons.groups,
                ),
                const CustomSubtitleWidget(subtitle: "Peraturan"),
                CustomTextFormField(
                  fieldName: "Peraturan Gedung",
                  controller: ruleController,
                  prefixIcon: Icons.rule,
                ),
                const CustomSubtitleWidget(subtitle: "Gambar"),
                CustomTextFormField(
                  fieldName: "Gambar",
                  controller: imageController,
                  prefixIcon: Icons.image,
                ),
                const Gap(20),
                Align(
                  alignment: Alignment.bottomRight,
                  child: ButtonPositive(
                    name: "Tambah",
                    function: () {
                      if (_formKey.currentState!.validate()) {
                        PopUp().whenDoSomething(
                          context,
                          "Tambah gedung?",
                          Icons.corporate_fare,
                          addBuilding(),
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
    );
  }

  RefreshIndicator manageBuildingContent() {
    return RefreshIndicator(
      onRefresh: () async {
        _getBuilding();
      },
      child: SingleChildScrollView(
        physics: const AlwaysScrollableScrollPhysics(),
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 8),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              BlocBuilder<BuildingBloc, BuildingState>(
                builder: (context, state) {
                  if (state is BuildingGetSuccess) {
                    final buildings = state.buildings;
                    if (buildings.isNotEmpty) {
                      return Column(
                        children: [
                          Text(
                            "Daftar Gedung",
                            style: GoogleFonts.openSans(
                              fontSize: 14,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                          const Gap(10),
                          ListView.builder(
                            itemCount: buildings.length,
                            physics: const NeverScrollableScrollPhysics(),
                            padding: const EdgeInsets.only(
                              bottom: 80,
                            ),
                            shrinkWrap: true,
                            itemBuilder: (context, index) {
                              return Padding(
                                padding: const EdgeInsets.symmetric(
                                  vertical: 4,
                                ),
                                child: EditBuildingCardView(
                                  building: buildings[index],
                                  functionEdit: () {
                                    context.pushNamed(
                                      Routes().editBuilding,
                                      extra: buildings[index],
                                    );
                                  },
                                  functionDelete: () {
                                    PopUp().whenDoSomething(
                                      context,
                                      "Ingin menghapus ${buildings[index].name}?",
                                      Icons.delete_forever,
                                      deleteBuilding(buildings[index].id!),
                                    );
                                  },
                                ),
                              );
                            },
                          ),
                        ],
                      );
                    } else {
                      return Container(
                        decoration:
                            const BoxDecoration(color: Color(0x80FFFFFF)),
                        child: Center(
                          child: Text(
                            "Tidak ada data gedung",
                            style: GoogleFonts.openSans(
                              fontSize: 12,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ),
                      );
                    }
                  } else {
                    return const SizedBox();
                  }
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
