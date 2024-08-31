import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:reservation_app/src/presentation/widgets/general/pop_up.dart';

import '../../../data/bloc/register/register_bloc.dart';
import '../../../data/model/user_model.dart';
import '../../widgets/general/header_detail_page.dart';

class AddUserPage extends StatefulWidget {
  const AddUserPage({
    super.key,
    required this.userModel,
  });

  final UserModel userModel;

  @override
  State<AddUserPage> createState() => _AddUserPageState();
}

class _AddUserPageState extends State<AddUserPage> {
  late TextEditingController agencyController;
  late TextEditingController usernameController;
  late TextEditingController passwordController;
  late TextEditingController fullNameController;
  late TextEditingController roleController;
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  late RegisterBloc _registerBloc;

  /// fungsi menambahkan user
  _register(
    String role,
  ) {
    _registerBloc = context.read<RegisterBloc>();
    _registerBloc.add(
      Register(
        widget.userModel.agency!,
        usernameController.text,
        passwordController.text,
        fullNameController.text,
        role,
      ),
    );
  }

  _popWhenAddUser(String role) async {
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
                    _register(role);
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
    agencyController = TextEditingController();
    usernameController = TextEditingController();
    passwordController = TextEditingController();
    fullNameController = TextEditingController();
    roleController = TextEditingController();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<RegisterBloc, RegisterState>(
      listener: (context, state) {
        if (state is RegisterSuccess) {
          usernameController.clear();
          passwordController.clear();
          fullNameController.clear();
          roleController.clear();
          PopUp().whenSuccessDoSomething(
              context, "User berhasil ditambahkan", Icons.check_circle);
        }
      },
      child: Scaffold(
        body: Column(
          children: [
            const HeaderDetailPage(
              pageName: "Tambah User",
            ),
            Expanded(
              child: Stack(
                children: [
                  RefreshIndicator(
                    onRefresh: () async {
                      usernameController.clear();
                      passwordController.clear();
                      fullNameController.clear();
                      roleController.clear();
                    },
                    child: SingleChildScrollView(
                      physics: const AlwaysScrollableScrollPhysics(),
                      child: Padding(
                        padding: const EdgeInsets.symmetric(
                            vertical: 12, horizontal: 8),
                        child: Form(
                          key: _formKey,
                          child: Builder(
                            builder: (context) {
                              if (widget.userModel.role == "0") {
                                return superAdminContent();
                              } else {
                                agencyController = TextEditingController(
                                  text: widget.userModel.agency,
                                );
                                return adminContent();
                              }
                            },
                          ),
                        ),
                      ),
                    ),
                  ),
                  BlocBuilder<RegisterBloc, RegisterState>(
                    builder: (context, state) {
                      if (state is RegisterLoadingState) {
                        return Container(
                          decoration:
                              const BoxDecoration(color: Color(0x80FFFFFF)),
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

  Column superAdminContent() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Gap(10),
        const Text("Nama Lengkap"),
        TextFormField(
          controller: fullNameController,
          validator: (value) {
            if (value == null || value.isEmpty) {
              return 'Nama tidak boleh kosong!';
            } else {
              return null;
            }
          },
          decoration: InputDecoration(
            border: const OutlineInputBorder(),
            hintStyle: GoogleFonts.openSans(),
            hintText: "Nama lengkap",
            prefixIcon: const Icon(Icons.contact_mail),
          ),
        ),
        const Gap(10),
        const Text("Username"),
        TextFormField(
          controller: usernameController,
          validator: (value) {
            if (value == null || value.isEmpty) {
              return 'Username tidak boleh kosong!';
            } else {
              return null;
            }
          },
          decoration: InputDecoration(
            border: const OutlineInputBorder(),
            hintStyle: GoogleFonts.openSans(),
            hintText: "Username",
            prefixIcon: const Icon(Icons.person),
          ),
        ),
        const Gap(10),
        const Text("Password"),
        TextFormField(
          controller: passwordController,
          obscureText: true,
          validator: (value) {
            if (value == null || value.isEmpty) {
              return 'Password tidak boleh kosong!';
            } else {
              return null;
            }
          },
          decoration: InputDecoration(
            border: const OutlineInputBorder(),
            hintStyle: GoogleFonts.openSans(),
            hintText: "Password",
            prefixIcon: const Icon(Icons.lock),
          ),
        ),
        const Gap(10),
        const Text("Instansi"),
        TextFormField(
          controller: agencyController,
          validator: (value) {
            if (value == null || value.isEmpty) {
              return 'Instansi tidak boleh kosong!';
            } else {
              return null;
            }
          },
          decoration: InputDecoration(
            border: const OutlineInputBorder(),
            hintStyle: GoogleFonts.openSans(),
            hintText: "Instansi",
            prefixIcon: const Icon(Icons.corporate_fare),
          ),
        ),
        const Gap(20),
        BlocBuilder<RegisterBloc, RegisterState>(
          builder: (context, state) {
            if (state is RegisterFailed) {
              return Center(
                child: Text(
                  state.error,
                  style: GoogleFonts.openSans(
                    color: Colors.redAccent,
                  ),
                ),
              );
            } else {
              return const SizedBox();
            }
          },
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
                    if (widget.userModel.role == "0") {
                      _popWhenAddUser("1");
                    } else {
                      _popWhenAddUser("2");
                    }
                  }
                },
                borderRadius: BorderRadius.circular(8),
                child: const Padding(
                  padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                  child: Text(
                    "Tambah User",
                    style: TextStyle(
                      fontWeight: FontWeight.w500,
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
            ),
          ),
        ),
        const Gap(30),
      ],
    );
  }

  Column adminContent() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Gap(10),
        const Text("Nama Lengkap"),
        TextFormField(
          controller: fullNameController,
          validator: (value) {
            if (value == null || value.isEmpty) {
              return 'Nama tidak boleh kosong!';
            } else {
              return null;
            }
          },
          decoration: InputDecoration(
            border: const OutlineInputBorder(),
            hintStyle: GoogleFonts.openSans(),
            hintText: "Nama lengkap",
            prefixIcon: const Icon(Icons.contact_mail),
          ),
        ),
        const Gap(10),
        const Text("Username"),
        TextFormField(
          controller: usernameController,
          validator: (value) {
            if (value == null || value.isEmpty) {
              return 'Username tidak boleh kosong!';
            } else {
              return null;
            }
          },
          decoration: InputDecoration(
            border: const OutlineInputBorder(),
            hintStyle: GoogleFonts.openSans(),
            hintText: "Username",
            prefixIcon: const Icon(Icons.person),
          ),
        ),
        const Gap(10),
        const Text("Password"),
        TextFormField(
          controller: passwordController,
          obscureText: true,
          validator: (value) {
            if (value == null || value.isEmpty) {
              return 'Password tidak boleh kosong!';
            } else {
              return null;
            }
          },
          decoration: InputDecoration(
            border: const OutlineInputBorder(),
            hintStyle: GoogleFonts.openSans(),
            hintText: "Password",
            prefixIcon: const Icon(Icons.lock),
          ),
        ),
        const Gap(10),
        const Text("Instansi"),
        TextFormField(
          controller: agencyController,
          readOnly: true,
          validator: (value) {
            if (value == null || value.isEmpty) {
              return 'Instansi tidak boleh kosong!';
            } else {
              return null;
            }
          },
          decoration: InputDecoration(
            border: const OutlineInputBorder(),
            hintStyle: GoogleFonts.openSans(),
            hintText: "Instansi",
            prefixIcon: const Icon(Icons.corporate_fare),
          ),
        ),
        const Gap(20),
        BlocBuilder<RegisterBloc, RegisterState>(
          builder: (context, state) {
            if (state is RegisterFailed) {
              return Center(
                child: Text(
                  state.error,
                  style: GoogleFonts.openSans(
                    color: Colors.redAccent,
                  ),
                ),
              );
            } else {
              return const SizedBox();
            }
          },
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
                    if (widget.userModel.role == "0") {
                      _popWhenAddUser("1");
                    } else {
                      _popWhenAddUser("2");
                    }
                  }
                },
                borderRadius: BorderRadius.circular(8),
                child: const Padding(
                  padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                  child: Text(
                    "Tambah User",
                    style: TextStyle(
                      fontWeight: FontWeight.w500,
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
            ),
          ),
        ),
        const Gap(30),
      ],
    );
  }
}
