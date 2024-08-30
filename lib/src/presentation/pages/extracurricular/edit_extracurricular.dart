import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';
import 'package:go_router/go_router.dart';

import '../../../data/bloc/extracurricular/extracurricular_bloc.dart';
import '../../../data/model/extracurricular_model.dart';
import '../../widgets/general/header_detail_page.dart';

class EditExtracurricularPage extends StatefulWidget {
  const EditExtracurricularPage({super.key, required this.exschool});

  final ExtracurricularModel exschool;

  @override
  State<EditExtracurricularPage> createState() => _EditExtracurricularPageState();
}

class _EditExtracurricularPageState extends State<EditExtracurricularPage> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  late TextEditingController exschoolNameController;
  late TextEditingController descController;
  late TextEditingController scheduleController;
  late TextEditingController imageController;
  late ExtracurricularBloc _exschoolBloc;

  _updateExschool(
    String name,
    String description,
    String schedule,
    String image,
  ) {
    _exschoolBloc = context.read<ExtracurricularBloc>();
    _exschoolBloc.add(
      UpdateExtracurricular(
        widget.exschool.id!,
        name,
        description,
        schedule,
        image,
      ),
    );
  }

  _popWhenUpdate(
    String name,
    String description,
    String schedule,
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
                    _updateExschool(name, description, schedule, image);
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
                  'Berhasil mengubah ekskul',
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
    exschoolNameController = TextEditingController(text: widget.exschool.name);
    descController = TextEditingController(text: widget.exschool.description);
    scheduleController = TextEditingController(text: widget.exschool.schedule);
    imageController = TextEditingController(text: widget.exschool.image);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<ExtracurricularBloc, ExtracurricularState>(
      listener: (context, state) {
        if (state is ExtracurricularUpdateSuccess) {
          _popWhenSuccessUpdate();
        }
      },
      child: Scaffold(
        body: Column(
          children: [
            const HeaderDetailPage(pageName: "Edit Ekstrakurikuler"),
            Expanded(
              child: Stack(
                children: [
                  RefreshIndicator(
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
                              const Text("Nama Ekstrakurikuler"),
                              TextFormField(
                                controller: exschoolNameController,
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
                                          _popWhenUpdate(
                                            exschoolNameController.text,
                                            descController.text,
                                            scheduleController.text,
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
                  BlocBuilder<ExtracurricularBloc, ExtracurricularState>(
                    builder: (context, state) {
                      if (state is ExtracurricularLoading) {
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
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
