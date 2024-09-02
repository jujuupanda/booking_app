import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:reservation_app/src/presentation/widgets/general/pop_up.dart';
import 'package:reservation_app/src/presentation/utils/routes/route_name.dart';
import 'package:reservation_app/src/presentation/widgets/general/header_detail_page.dart';

import '../../../data/bloc/building/building_bloc.dart';
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
  }

  /// mendapatkan info gedung
  _getBuilding() {
    _buildingBloc = context.read<BuildingBloc>();
    _buildingBloc.add(GetBuildingByAgency());
  }

  /// menghapus gedung
  deleteBuilding(String id) {
    _buildingBloc = context.read<BuildingBloc>();
    _buildingBloc.add(DeleteBuilding(id));
  }

  _popWhenAddBuilding() async {
    return showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          content: const SizedBox(
            height: 130,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Expanded(
                  child: Icon(
                    Icons.check_circle,
                    size: 60,
                    color: Colors.blueAccent,
                  ),
                ),
                Gap(10),
                Text(
                  'Tambahkan gedung?',
                  style: TextStyle(fontSize: 14),
                  textAlign: TextAlign.center,
                )
              ],
            ),
          ),
          actions: <Widget>[
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                InkWell(
                  onTap: () {
                    Navigator.of(context).pop();
                  },
                  borderRadius: BorderRadius.circular(10),
                  child: Container(
                    height: 40,
                    width: 100,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      border: Border.all(
                        width: 1,
                        color: Colors.blueAccent,
                      ),
                    ),
                    child: const Center(
                      child: Text(
                        'Tidak',
                        style: TextStyle(
                          color: Colors.blueAccent,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                  ),
                ),
                InkWell(
                  onTap: () {
                    addBuilding();
                    Navigator.of(context).pop();
                  },
                  borderRadius: BorderRadius.circular(10),
                  child: Container(
                    height: 40,
                    width: 100,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        color: Colors.blueAccent),
                    child: const Center(
                      child: Text(
                        'Ya',
                        style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ],
        );
      },
    );
  }

  _popWhenDeleteBuilding(String id) async {
    return showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          content: const SizedBox(
            height: 130,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Expanded(
                  child: Icon(
                    Icons.cancel,
                    size: 60,
                    color: Colors.blueAccent,
                  ),
                ),
                Gap(10),
                Text(
                  'Hapus gedung?',
                  style: TextStyle(fontSize: 14),
                  textAlign: TextAlign.center,
                )
              ],
            ),
          ),
          actions: <Widget>[
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                InkWell(
                  onTap: () {
                    Navigator.of(context).pop();
                  },
                  borderRadius: BorderRadius.circular(10),
                  child: Container(
                    height: 40,
                    width: 100,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      border: Border.all(
                        width: 1,
                        color: Colors.blueAccent,
                      ),
                    ),
                    child: const Center(
                      child: Text(
                        'Tidak',
                        style: TextStyle(
                          color: Colors.blueAccent,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                  ),
                ),
                InkWell(
                  onTap: () {
                    deleteBuilding(id);
                    Navigator.of(context).pop();
                  },
                  borderRadius: BorderRadius.circular(10),
                  child: Container(
                    height: 40,
                    width: 100,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        color: Colors.blueAccent),
                    child: const Center(
                      child: Text(
                        'Ya',
                        style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ],
        );
      },
    );
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
              context, "Berhasil menambah gedung", Icons.check_circle);
        } else if (state is BuildingDeleteSuccess) {
          PopUp().whenSuccessDoSomething(
              context, "Berhasil menghapus gedung", Icons.check_circle);
        }
      },
      child: DefaultTabController(
        length: 2,
        child: Scaffold(
          body: Column(
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
        ),
      ),
    );
  }


  Stack addBuildingContent() {
    return Stack(
      children: [
        RefreshIndicator(
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
                    Text(
                      "Nama Gedung",
                      style: GoogleFonts.openSans(
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    TextFormField(
                      controller: buildingNameController,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Nama gedung tidak boleh kosong!';
                        } else {
                          return null;
                        }
                      },
                      decoration: InputDecoration(
                        border: const OutlineInputBorder(),
                        hintText: "Nama gedung",
                        hintStyle: GoogleFonts.openSans(fontSize: 14),
                        prefixIcon: const Icon(Icons.corporate_fare),
                      ),
                    ),
                    const Gap(10),
                    Text(
                      "Deskripsi",
                      style: GoogleFonts.openSans(
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    TextFormField(
                      controller: descController,
                      keyboardType: TextInputType.multiline,
                      maxLines: null,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Deskripsi tidak boleh kosong!';
                        } else {
                          return null;
                        }
                      },
                      decoration: InputDecoration(
                        border: const OutlineInputBorder(),
                        hintText: "Deskripsi gedung",
                        hintStyle: GoogleFonts.openSans(fontSize: 14),
                        prefixIcon: const Icon(Icons.description),
                      ),
                    ),
                    const Gap(10),
                    Text(
                      "Fasilitas",
                      style: GoogleFonts.openSans(
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    TextFormField(
                      controller: facilityController,
                      keyboardType: TextInputType.multiline,
                      maxLines: null,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Fasilitas tidak boleh kosong!';
                        } else {
                          return null;
                        }
                      },
                      decoration: InputDecoration(
                        border: const OutlineInputBorder(),
                        hintText: "Fasilitas gedung",
                        hintStyle: GoogleFonts.openSans(fontSize: 14),
                        prefixIcon: const Icon(Icons.badge_rounded),
                      ),
                    ),
                    const Gap(10),
                    Text(
                      "Kapasitas",
                      style: GoogleFonts.openSans(
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    TextFormField(
                      controller: capacityController,
                      keyboardType: TextInputType.number,
                      inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Kapasitas tidak boleh kosong!';
                        } else {
                          return null;
                        }
                      },
                      decoration: InputDecoration(
                        border: const OutlineInputBorder(),
                        hintText: "Total kapasitas",
                        hintStyle: GoogleFonts.openSans(fontSize: 14),
                        prefixIcon: const Icon(Icons.groups),
                      ),
                    ),
                    const Gap(10),
                    Text(
                      "Peraturan",
                      style: GoogleFonts.openSans(
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    TextFormField(
                      controller: ruleController,
                      keyboardType: TextInputType.multiline,
                      maxLines: null,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Peraturan tidak boleh kosong!';
                        } else {
                          return null;
                        }
                      },
                      decoration: InputDecoration(
                        border: const OutlineInputBorder(),
                        hintText: "Peraturan gedung",
                        hintStyle: GoogleFonts.openSans(fontSize: 14),
                        prefixIcon: const Icon(Icons.rule),
                      ),
                    ),
                    const Gap(10),
                    Text(
                      "Gambar",
                      style: GoogleFonts.openSans(
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    TextFormField(
                      readOnly: true,
                      controller: imageController,
                      decoration: InputDecoration(
                        border: const OutlineInputBorder(),
                        hintText: "Foto gedung",
                        hintStyle: GoogleFonts.openSans(fontSize: 14),
                        prefixIcon: const Icon(Icons.image),
                      ),
                    ),
                    const Gap(20),
                    Align(
                      alignment: Alignment.bottomRight,
                      child: Container(
                        decoration: BoxDecoration(
                          color: Colors.blueAccent,
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: Material(
                          color: Colors.transparent,
                          child: InkWell(
                            onTap: () {
                              if (_formKey.currentState!.validate()) {
                                _popWhenAddBuilding();
                              }
                            },
                            borderRadius: BorderRadius.circular(8),
                            child: const Padding(
                              padding: EdgeInsets.symmetric(
                                  horizontal: 16, vertical: 8),
                              child: Text(
                                "Tambah Gedung",
                                style: TextStyle(
                                    fontWeight: FontWeight.w500,
                                    color: Colors.white),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                    const Gap(30),
                  ],
                ),
              ),
            ),
          ),
        ),
        BlocBuilder<BuildingBloc, BuildingState>(
          builder: (context, state) {
            if (state is BuildingLoading) {
              return Container(
                decoration: const BoxDecoration(color: Color(0x80FFFFFF)),
                child: const Center(
                  child: CircularProgressIndicator(),
                ),
              );
            }
            return const SizedBox();
          },
        ),
      ],
    );
  }

  Stack manageBuildingContent() {
    return Stack(
      children: [
        RefreshIndicator(
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
                                    padding:
                                    const EdgeInsets.symmetric(vertical: 4),
                                    child: EditBuildingCardView(
                                      building: buildings[index],
                                      functionEdit: () {
                                        context.pushNamed(
                                          Routes().editBuilding,
                                          extra: buildings[index],
                                        );
                                      },
                                      functionDelete: () {
                                        _popWhenDeleteBuilding(
                                            buildings[index].id!);
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
                        return const Center(
                          child: CircularProgressIndicator(),
                        );
                      }
                    },
                  ),
                ],
              ),
            ),
          ),
        ),
        BlocBuilder<BuildingBloc, BuildingState>(
          builder: (context, state) {
            if (state is BuildingLoading) {
              return Container(
                decoration: const BoxDecoration(color: Color(0x80FFFFFF)),
                child: const Center(
                  child: CircularProgressIndicator(),
                ),
              );
            }
            return const SizedBox();
          },
        ),
      ],
    );
  }
}
