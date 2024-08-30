import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:reservation_app/src/presentation/utils/routes/route_name.dart';
import 'package:reservation_app/src/presentation/pages/extracurricular/edit_extracurricular_card_view.dart';

import '../../../data/bloc/extracurricular/extracurricular_bloc.dart';
import '../../../data/model/user_model.dart';
import '../../widgets/general/pop_up.dart';
import '../../widgets/general/header_detail_page.dart';

class AddSchedulePage extends StatefulWidget {
  const AddSchedulePage({super.key});

  @override
  State<AddSchedulePage> createState() => _AddSchedulePageState();
}

class _AddSchedulePageState extends State<AddSchedulePage>
    with TickerProviderStateMixin {
  late TextEditingController excurNameController;
  late TextEditingController descController;
  late TextEditingController scheduleController;
  late TextEditingController imageController;
  late TabController _tabController;
  late ExtracurricularBloc _excurBloc;
  late UserModel user;
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  _addExcur() {
    _excurBloc = context.read<ExtracurricularBloc>();
    _excurBloc.add(
      AddExtracurricular(
        excurNameController.text,
        descController.text,
        scheduleController.text,
        imageController.text,
      ),
    );
  }

  _deleteExcur(String id) {
    _excurBloc = context.read<ExtracurricularBloc>();
    _excurBloc.add(DeleteExtracurricular(id));
  }

  _getExschool() {
    _excurBloc = context.read<ExtracurricularBloc>();
    _excurBloc.add(GetExtracurricular());
  }

  _popWhenAddExcur() async {
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
                  'Tambahkan ekstrakurikuler?',
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
                    _addExcur();
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

  _popWhenDeleteExcur(String id) async {
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
                  'Hapus ekskul?',
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
                    _deleteExcur(id);
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
    excurNameController = TextEditingController();
    descController = TextEditingController();
    scheduleController = TextEditingController();
    imageController = TextEditingController(text: "some");
    _tabController = TabController(length: 2, vsync: this);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<ExtracurricularBloc, ExtracurricularState>(
      listener: (context, state) {
        if (state is ExtracurricularAddSuccess) {
          excurNameController.clear();
          descController.clear();
          scheduleController.clear();
          imageController.clear();
          PopUp().whenSuccessDoSomething(
              context, "Berhasil menambah gedung", Icons.check_circle);
        } else if (state is ExtracurricularDeleteSuccess) {
          PopUp().whenSuccessDoSomething(
              context, "Berhasil menghapus ekskul", Icons.check_circle);
        }
      },
      child: DefaultTabController(
        length: 2,
        child: Scaffold(
          body: Column(
            children: [
              const HeaderDetailPage(
                pageName: "Tambah Kegiatan Ekstrakurikuler",
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
                    addExcurContent(),

                    ///second tab bar
                    manageExcurContent(),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Stack manageExcurContent() {
    return Stack(
      children: [
        RefreshIndicator(
          onRefresh: () async {
            _getExschool();
          },
          child: SingleChildScrollView(
            physics: const AlwaysScrollableScrollPhysics(),
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 8),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  BlocBuilder<ExtracurricularBloc, ExtracurricularState>(
                    builder: (context, state) {
                      if (state is ExtracurricularGetSuccess) {
                        final excur = state.extracurriculars;
                        if (excur.isNotEmpty) {
                          return Column(
                            children: [
                              Text(
                                "Jadwal Ekstrakurikuler",
                                style: GoogleFonts.openSans(
                                  fontSize: 14,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                              const Gap(10),
                              ListView.builder(
                                itemCount: excur.length,
                                physics: const NeverScrollableScrollPhysics(),
                                padding: const EdgeInsets.only(
                                  bottom: 80,
                                ),
                                shrinkWrap: true,
                                itemBuilder: (context, index) {
                                  return Padding(
                                    padding:
                                        const EdgeInsets.symmetric(vertical: 4),
                                    child: EditExtracurricularCardView(
                                      excur: excur[index],
                                      functionEdit: () {
                                        context.pushNamed(
                                          Routes().editExtracurricular,
                                          extra: excur[index],
                                        );
                                      },
                                      functionDelete: () {
                                        _popWhenDeleteExcur(
                                          excur[index].id!,
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
                                "Tidak ada data jadwal ekstrakurikuler",
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
        BlocBuilder<ExtracurricularBloc, ExtracurricularState>(
          builder: (context, state) {
            if (state is ExtracurricularLoading) {
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

  Stack addExcurContent() {
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
                    const Text("Nama Ekstrakurikuler"),
                    TextFormField(
                      controller: excurNameController,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Nama kegiatan tidak boleh kosong!';
                        } else {
                          return null;
                        }
                      },
                      decoration: const InputDecoration(
                        border: OutlineInputBorder(),
                        hintText: "Nama kegiatan ekstrakurikuler",
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
                        hintText: "Deskripsi kegiatan",
                        prefixIcon: Icon(Icons.description),
                      ),
                    ),
                    const Gap(10),
                    const Text("Jadwal Kegiatan"),
                    TextFormField(
                      controller: scheduleController,
                      keyboardType: TextInputType.multiline,
                      maxLines: null,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Jadwal kegiatan tidak boleh kosong!';
                        } else {
                          return null;
                        }
                      },
                      decoration: const InputDecoration(
                        border: OutlineInputBorder(),
                        hintText: "Jadwal kegiatan ekstrakurikuler",
                        prefixIcon: Icon(Icons.badge_rounded),
                      ),
                    ),
                    const Gap(10),
                    const Text("Gambar"),
                    TextFormField(
                      readOnly: true,
                      controller: imageController,
                      decoration: const InputDecoration(
                        border: OutlineInputBorder(),
                        hintText: "Foto ekstrakurikuler",
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
                              if (_formKey.currentState!.validate()) {
                                _popWhenAddExcur();
                              }
                            },
                            borderRadius: BorderRadius.circular(8),
                            child: const Padding(
                              padding: EdgeInsets.symmetric(
                                  horizontal: 16, vertical: 8),
                              child: Text(
                                "Tambah Kegiatan",
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
        BlocBuilder<ExtracurricularBloc, ExtracurricularState>(
          builder: (context, state) {
            if (state is ExtracurricularLoading) {
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
