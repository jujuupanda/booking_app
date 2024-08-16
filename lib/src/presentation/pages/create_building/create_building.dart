import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';
import 'package:go_router/go_router.dart';
import 'package:reservation_app/src/data/model/user_model.dart';
import 'package:reservation_app/src/presentation/utils/routes/route_name.dart';
import 'package:reservation_app/src/presentation/widgets/general/header_detail_page.dart';

import '../../../data/bloc/building/building_bloc.dart';
import '../../../data/bloc/user/user_bloc.dart';
import '../../widgets/general/edit_building_card_view.dart';

class CreateBuildingPage extends StatefulWidget {
  const CreateBuildingPage({super.key});

  @override
  State<CreateBuildingPage> createState() => _CreateBuildingPageState();
}

class _CreateBuildingPageState extends State<CreateBuildingPage>
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
  late UserBloc _userBloc;
  late UserModel user;
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

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
          user.agency!),
    );
  }

  _getBuilding() {
    _buildingBloc = context.read<BuildingBloc>();
    _buildingBloc.add(GetBuildingByAgency());
  }

  deleteBuilding(String id) {
    _buildingBloc = context.read<BuildingBloc>();
    _buildingBloc.add(DeleteBuilding(id));
  }

  _getUser() {
    _userBloc = context.read<UserBloc>();
    _userBloc.add(GetUser());
  }

  _popWhenAdd() async {
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

  _popWhenSuccessAdd() async {
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
                  'Berhasil menambah gedung',
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
                    buildingNameController.clear();
                    descController.clear();
                    facilityController.clear();
                    capacityController.clear();
                    ruleController.clear();
                    imageController.clear();
                    statusController.clear();
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

  _popWhenDelete(String id) async {
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

  _popWhenSuccessDelete() async {
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
                  'Berhasil menghapus gedung',
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
    _getUser();
    _tabController = TabController(length: 2, vsync: this);
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
    _tabController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return MultiBlocListener(
      listeners: [
        BlocListener<BuildingBloc, BuildingState>(
          listener: (context, state) {
            if (state is BuildingAddSuccess) {
              _popWhenSuccessAdd();
            } else if (state is BuildingDeleteSuccess) {
              _popWhenSuccessDelete();
            }
          },
        ),
        BlocListener<UserBloc, UserState>(
          listener: (context, state) {
            if (state is UserGetSuccess) {
              user = state.user;
            }
          },
        )
      ],
      child: Scaffold(
        body: Column(
          children: [
            const HeaderDetailPage(
              pageName: "Tambah Gedung",
            ),
            DefaultTabController(
              length: 2,
              child: TabBar(
                controller: _tabController,
                tabs: const [
                  Tab(text: 'Tambah'),
                  Tab(text: 'Edit/Hapus'),
                ],
              ),
            ),
            Expanded(
              child: TabBarView(
                controller: _tabController,
                children: [
                  ///first tab bar
                  Stack(
                    children: [
                      Expanded(
                        child: RefreshIndicator(
                          onRefresh: () async {},
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
                                    const Text("Nama Gedung"),
                                    TextFormField(
                                      controller: buildingNameController,
                                      validator: (value) {
                                        if (value == null || value.isEmpty) {
                                          return 'Nama gedung tidak boleh kosong!';
                                        } else {
                                          return null;
                                        }
                                      },
                                      decoration: const InputDecoration(
                                        border: OutlineInputBorder(),
                                        hintText: "Nama gedung",
                                        prefixIcon: Icon(Icons.corporate_fare),
                                      ),
                                    ),
                                    const Gap(10),
                                    const Text("Deskripsi"),
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
                                      decoration: const InputDecoration(
                                        border: OutlineInputBorder(),
                                        hintText: "Deskripsi gedung",
                                        prefixIcon: Icon(Icons.description),
                                      ),
                                    ),
                                    const Gap(10),
                                    const Text("Fasilitas"),
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
                                      decoration: const InputDecoration(
                                        border: OutlineInputBorder(),
                                        hintText: "Fasilitas gedung",
                                        prefixIcon: Icon(Icons.badge_rounded),
                                      ),
                                    ),
                                    const Gap(10),
                                    const Text("Kapasitas"),
                                    TextFormField(
                                      controller: capacityController,
                                      keyboardType: TextInputType.number,
                                      validator: (value) {
                                        if (value == null || value.isEmpty) {
                                          return 'Kapasitas tidak boleh kosong!';
                                        } else {
                                          return null;
                                        }
                                      },
                                      decoration: const InputDecoration(
                                        border: OutlineInputBorder(),
                                        hintText: "Total kapasitas",
                                        prefixIcon: Icon(Icons.groups),
                                      ),
                                    ),
                                    const Gap(10),
                                    const Text("Peraturan"),
                                    TextFormField(
                                      controller: ruleController,
                                      keyboardType: TextInputType.multiline,
                                      maxLines: null,
                                      validator: (value) {
                                        if (value == null || value.isEmpty) {
                                          return 'Kapasitas tidak boleh kosong!';
                                        } else {
                                          return null;
                                        }
                                      },
                                      decoration: const InputDecoration(
                                        border: OutlineInputBorder(),
                                        hintText: "Peraturan gedung",
                                        prefixIcon: Icon(Icons.rule),
                                      ),
                                    ),
                                    const Gap(10),
                                    const Text("Gambar"),
                                    TextFormField(
                                      readOnly: true,
                                      controller: imageController,
                                      decoration: const InputDecoration(
                                        border: OutlineInputBorder(),
                                        hintText: "Foto gedung",
                                        prefixIcon: Icon(Icons.image),
                                      ),
                                    ),
                                    const Gap(20),
                                    Align(
                                      alignment: Alignment.bottomRight,
                                      child: Container(
                                        decoration: BoxDecoration(
                                          color: Colors.blueAccent,
                                          borderRadius:
                                              BorderRadius.circular(8),
                                        ),
                                        child: Material(
                                          color: Colors.transparent,
                                          child: InkWell(
                                            onTap: () {
                                              if (_formKey.currentState!
                                                  .validate()) {
                                                _popWhenAdd();
                                              }
                                            },
                                            borderRadius:
                                                BorderRadius.circular(8),
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
                      ),
                      BlocBuilder<BuildingBloc, BuildingState>(
                        builder: (context, state) {
                          if (state is BuildingLoading) {
                            return Expanded(
                              child: Container(
                                decoration: const BoxDecoration(
                                    color: Color(0x80FFFFFF)),
                                child: const Center(
                                  child: CircularProgressIndicator(),
                                ),
                              ),
                            );
                          }
                          return const SizedBox();
                        },
                      ),
                    ],
                  ),

                  ///second tab bar
                  Stack(
                    children: [
                      Expanded(
                        child: RefreshIndicator(
                          onRefresh: () async {
                            _getBuilding();
                          },
                          child: SingleChildScrollView(
                            physics: const AlwaysScrollableScrollPhysics(),
                            child: Padding(
                              padding: const EdgeInsets.symmetric(
                                  vertical: 12, horizontal: 8),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  const Text(
                                    "Daftar Gedung",
                                    style: TextStyle(
                                      fontSize: 14,
                                      fontWeight: FontWeight.w500,
                                    ),
                                  ),
                                  const Gap(10),
                                  BlocBuilder<BuildingBloc, BuildingState>(
                                    builder: (context, state) {
                                      if (state is BuildingGetSuccess) {
                                        final buildings = state.buildings;
                                        return ListView.builder(
                                          itemCount: buildings.length,
                                          physics:
                                              const NeverScrollableScrollPhysics(),
                                          padding: const EdgeInsets.only(
                                            bottom: 80,
                                          ),
                                          shrinkWrap: true,
                                          itemBuilder: (context, index) {
                                            return Padding(
                                              padding:
                                                  const EdgeInsets.symmetric(
                                                      vertical: 4),
                                              child: EditBuildingCardView(
                                                name: buildings[index].name,
                                                functionEdit: () {
                                                  context.pushNamed(
                                                    Routes().editBuilding,
                                                    extra: buildings[index],
                                                  );
                                                },
                                                functionDelete: () {
                                                  _popWhenDelete(
                                                      buildings[index].id!);
                                                },
                                              ),
                                            );
                                          },
                                        );
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
                      ),
                      BlocBuilder<BuildingBloc, BuildingState>(
                        builder: (context, state) {
                          if (state is BuildingLoading) {
                            return Expanded(
                              child: Container(
                                decoration: const BoxDecoration(
                                    color: Color(0x80FFFFFF)),
                                child: const Center(
                                  child: CircularProgressIndicator(),
                                ),
                              ),
                            );
                          }
                          return const SizedBox();
                        },
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
