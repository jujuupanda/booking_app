import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';
import 'package:go_router/go_router.dart';
import 'package:reservation_app/src/presentation/widgets/general/header_detail_page.dart';

import '../../../data/bloc/building/building_bloc.dart';
import '../../../data/model/building_model.dart';

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
  late TextEditingController statusController;
  late BuildingBloc _buildingBloc;

  updateBuilding(
    String id,
    String name,
    String description,
    String facility,
    int capacity,
    String rule,
    String image,
  ) {
    _buildingBloc = context.read<BuildingBloc>();
    _buildingBloc.add(
      UpdateBuilding(
        id,
        name,
        description,
        facility,
        capacity,
        rule,
        image,
      ),
    );
  }

  _popWhenUpdate(
    String id,
    String name,
    String description,
    String facility,
    int capacity,
    String rule,
    String image,
  ) async {
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
                  'Simpan perubahan?',
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
                    updateBuilding(
                        id, name, description, facility, capacity, rule, image);
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

  _popWhenSuccessUpdate() async {
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
                  'Berhasil mengubah gedung',
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
                    context.pop();
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
    buildingNameController = TextEditingController(text: widget.building.name);
    descController = TextEditingController(text: widget.building.description);
    facilityController = TextEditingController(text: widget.building.facility);
    capacityController =
        TextEditingController(text: widget.building.capacity.toString());
    ruleController = TextEditingController(text: widget.building.rule);
    imageController = TextEditingController();
    statusController = TextEditingController();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<BuildingBloc, BuildingState>(
      listener: (context, state) {
        if (state is BuildingUpdateSuccess) {
          _popWhenSuccessUpdate();
        }
      },
      child: Scaffold(
        body: Column(
          children: [
            const HeaderDetailPage(pageName: "Edit Gedung"),
            Expanded(
              child: Stack(
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
                                    prefixIcon: Icon(Icons.image),
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
                                          if (_formKey.currentState!
                                              .validate()) {
                                            _popWhenUpdate(
                                              widget.building.id!,
                                              buildingNameController.text,
                                              descController.text,
                                              facilityController.text,
                                              int.parse(
                                                  capacityController.text),
                                              ruleController.text,
                                              imageController.text,
                                            );
                                          }
                                        },
                                        borderRadius: BorderRadius.circular(8),
                                        child: const Padding(
                                          padding: EdgeInsets.symmetric(
                                              horizontal: 16, vertical: 8),
                                          child: Text(
                                            "Simpan",
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
                            decoration:
                                const BoxDecoration(color: Color(0x80FFFFFF)),
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
            ),
          ],
        ),
      ),
    );
  }
}
