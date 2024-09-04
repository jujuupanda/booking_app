import 'dart:typed_data';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:reservation_app/src/presentation/widgets/general/widget_custom_loading.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../data/bloc/logout/logout_bloc.dart';
import '../../../data/bloc/register/register_bloc.dart';
import '../../../data/bloc/user/user_bloc.dart';
import '../../utils/constant/constant.dart';
import '../../utils/general/image_picker.dart';
import '../../utils/routes/route_name.dart';
import '../../widgets/general/custom_fab.dart';
import '../../widgets/general/header_pages.dart';
import '../../widgets/general/pop_up.dart';
import '../../widgets/general/widget_custom_text_form_field.dart';
import 'widget_profile_text_field.dart';
import '../../widgets/general/widget_custom_subtitle.dart';
import 'widget_user_card_view.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage>
    with TickerProviderStateMixin {
  late LogoutBloc logoutBloc;
  late RegisterBloc registerBloc;
  late UserBloc userBloc;
  late TextEditingController idController;
  late TextEditingController agencyController;
  late TextEditingController usernameController;
  late TextEditingController fullNameController;
  late TextEditingController phoneController;
  late TextEditingController emailController;
  late TextEditingController passwordController;
  late TextEditingController imageController;
  late TextEditingController temporaryController;
  late String roleUser;
  late TabController tabController;
  int selectedIndex = 0;
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  Uint8List? imagePicked;

  /// fungsi untuk logout pop Up
  logout() {
    return () {
      logoutBloc = context.read<LogoutBloc>();
      logoutBloc.add(OnLogout());
    };
  }

  /// fungsi untuk mendapatkan info list user
  getAllUserByAgency() {
    registerBloc = context.read<RegisterBloc>();
    registerBloc.add(GetAllUser());
  }

  /// fungsi untuk mendapatkan info user
  getSingleUser() {
    userBloc = context.read<UserBloc>();
    userBloc.add(GetUser());
  }

  /// edit single user (logged in)
  editSingleUser() {
    userBloc = context.read<UserBloc>();
    userBloc.add(
      EditSingleUser(
        idController.text,
        agencyController.text,
        usernameController.text,
        passwordController.text,
        fullNameController.text,
        emailController.text,
        phoneController.text,
      ),
    );
  }

  /// fungsi menghapus user (pop up)
  deleteUserPopUp(String id) {
    return () {
      registerBloc = context.read<RegisterBloc>();
      registerBloc.add(DeleteUser(id));
    };
  }

  /// mendapatkan role pengguna
  getRole() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    roleUser = prefs.getString("role")!;
    setState(() {
      roleUser = roleUser;
    });
  }

  /// select image
  selectImage() async {
    Uint8List img = await StoreData().pickImage(ImageSource.gallery);
    final urlImage = await StoreData().uploadImageToStorage(
        "profile_picture",
        "${usernameController.text}${DateFormat('yyyyMMddHHmmss').format(DateTime.now())}",
        img);
    setState(() {
      imagePicked = img;
    });
    uploadImage(urlImage);
  }

  /// upload image
  uploadImage(String urlImage) {
    userBloc = context.read<UserBloc>();
    userBloc.add(
      EditProfilePicture(
        idController.text,
        urlImage,
      ),
    );
  }

  /// popup ketika mengedit 1 field (logged in user)
  /// TODO dibuat menjadi custom widget
  popUpEditField(
    String fieldName,
    TextEditingController controller,
    IconData prefixIcon,
  ) {
    temporaryController.text = controller.text;
    return showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) {
        return AlertDialog(
          insetPadding: const EdgeInsets.all(10),
          title: Center(
            child: Text(
              "Edit $fieldName",
              style: GoogleFonts.openSans(),
            ),
          ),
          content: SizedBox(
            width: double.maxFinite,
            child: Form(
              key: _formKey,
              child: CustomTextFormField(
                fieldName: fieldName,
                controller: temporaryController,
                prefixIcon: prefixIcon,
              ),
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
                        'Batal',
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
                    if (_formKey.currentState!.validate()) {
                      controller.text = temporaryController.text;
                      editSingleUser();
                      Navigator.of(context).pop();
                    }
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
                        'Simpan',
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
    getRole();
    getSingleUser();
    getAllUserByAgency();
    roleUser = "";
    tabController = TabController(
      length: 2,
      vsync: this,
    );
    idController = TextEditingController();
    agencyController = TextEditingController();
    usernameController = TextEditingController();
    fullNameController = TextEditingController();
    emailController = TextEditingController();
    phoneController = TextEditingController();
    passwordController = TextEditingController();
    imageController = TextEditingController();
    temporaryController = TextEditingController();
    super.initState();
  }

  @override
  void dispose() {
    idController.dispose();
    agencyController.dispose();
    usernameController.dispose();
    fullNameController.dispose();
    phoneController.dispose();
    emailController.dispose();
    passwordController.dispose();
    imageController.dispose();
    tabController.dispose();
    temporaryController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return MultiBlocListener(
      listeners: [
        BlocListener<LogoutBloc, LogoutState>(
          listener: (context, state) {
            if (state is LogoutSuccess) {
              context.goNamed(Routes().login);
            }
          },
        ),
        BlocListener<UserBloc, UserState>(
          listener: (context, state) {
            if (state is UserGetSuccess) {
              final user = state.user;
              idController = TextEditingController(text: user.id);
              agencyController = TextEditingController(text: user.agency);
              usernameController = TextEditingController(text: user.username);
              fullNameController = TextEditingController(text: user.fullName);
              emailController = TextEditingController(text: user.email);
              phoneController = TextEditingController(text: user.phone);
              passwordController = TextEditingController(text: user.password);
              imageController = TextEditingController(text: user.image);
            }

            /// ini popup ketika sukses mengupdate profile pada halaman profile
            // else if (state is EditSingleUserSuccess) {
            //   PopUp().whenSuccessDoSomething(
            //     context,
            //     "Edit berhasil",
            //     Icons.check_circle,
            //   );
            // }
          },
        ),
        BlocListener<RegisterBloc, RegisterState>(
          listener: (context, state) {
            if (state is DeleteSuccess) {
              PopUp().whenSuccessDoSomething(
                context,
                "User berhasil dihapus",
                Icons.check_circle,
              );
            }
          },
        )
      ],
      child: Scaffold(
        floatingActionButton: selectedIndex == 1
            ? BlocBuilder<UserBloc, UserState>(
                builder: (context, state) {
                  if (state is UserGetSuccess) {
                    return CustomFAB(
                      function: () {
                        context.pushNamed(
                          Routes().addUser,
                          extra: state.user,
                        );
                      },
                    );
                  } else {
                    return const SizedBox();
                  }
                },
              )
            : null,
        body: Stack(
          children: [
            Column(
              children: [
                const HeaderPage(
                  name: "Profil Saya",
                ),
                const Gap(10),
                Expanded(
                  child: contentByRole(),
                ),
              ],
            ),
            Center(
              child: BlocBuilder<LogoutBloc, LogoutState>(
                builder: (context, state) {
                  if (state is LogoutLoading) {
                    return const CustomLoading();
                  }
                  return const SizedBox();
                },
              ),
            ),
            Center(
              child: BlocBuilder<UserBloc, UserState>(
                builder: (context, state) {
                  if (state is UserLoading) {
                    return const CustomLoading();
                  }
                  return const SizedBox();
                },
              ),
            ),
            Center(
              child: BlocBuilder<RegisterBloc, RegisterState>(
                builder: (context, state) {
                  if (state is RegisterLoading) {
                    return const CustomLoading();
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

  contentByRole() {
    if (roleUser == "2") {
      return userContent();
    } else {
      return adminUI();
    }
  }

  Column adminUI() {
    return Column(
      children: [
        TabBar(
          controller: tabController,
          onTap: (index) {
            setState(() {
              selectedIndex = index;
            });
          },
          labelStyle: GoogleFonts.openSans(
            fontWeight: FontWeight.bold,
          ),
          unselectedLabelColor: Colors.black,
          labelColor: Colors.white,
          indicatorColor: Colors.transparent,
          dividerColor: Colors.transparent,
          splashFactory: NoSplash.splashFactory,
          tabs: [
            Tab(
              child: Container(
                width: double.maxFinite,
                height: 40,
                decoration: selectedIndex == 0
                    ? BoxDecoration(
                        color: Colors.blueAccent.shade400,
                        borderRadius: BorderRadius.circular(10),
                      )
                    : BoxDecoration(
                        color: Colors.grey.shade400,
                        borderRadius: BorderRadius.circular(10),
                      ),
                child: const Center(
                  child: Text("Admin"),
                ),
              ),
            ),
            Tab(
              child: Container(
                width: double.maxFinite,
                height: 40,
                decoration: selectedIndex == 1
                    ? BoxDecoration(
                        color: Colors.blueAccent.shade400,
                        borderRadius: BorderRadius.circular(10),
                      )
                    : BoxDecoration(
                        color: Colors.grey.shade400,
                        borderRadius: BorderRadius.circular(10),
                      ),
                child: const Center(
                  child: Text("User"),
                ),
              ),
            ),
          ],
        ),
        Expanded(
          child: TabBarView(
            physics: const NeverScrollableScrollPhysics(),
            controller: tabController,
            children: [
              /// first tab bar view
              userContent(),

              /// second tab bar view
              adminContent(),
            ],
          ),
        ),
      ],
    );
  }

  RefreshIndicator userContent() {
    return RefreshIndicator(
      onRefresh: () async {
        getSingleUser();
      },
      child: SingleChildScrollView(
        physics: const AlwaysScrollableScrollPhysics(),
        child: BlocBuilder<UserBloc, UserState>(
          builder: (context, state) {
            if (state is UserGetSuccess) {
              return Column(
                children: [
                  const Gap(30),
                  Stack(
                    children: [
                      Builder(
                        builder: (context) {
                          if (imagePicked != null) {
                            return ClipOval(
                              child: SizedBox(
                                height: 150,
                                width: 150,
                                child: Image(
                                  image: MemoryImage(imagePicked!),
                                ),
                              ),
                            );
                          } else {
                            if (imageController.text == "") {
                              return ClipOval(
                                child: CachedNetworkImage(
                                  height: 150,
                                  width: 150,
                                  imageUrl: defaultProfilePicture,
                                  placeholder: (context, url) {
                                    return const Center(
                                      child: CircularProgressIndicator(),
                                    );
                                  },
                                  errorWidget: (context, url, error) {
                                    return const ClipOval(
                                      child: SizedBox(
                                        height: 150,
                                        width: 150,
                                        child: Image(
                                          image: NetworkImage(
                                              defaultProfilePicture),
                                        ),
                                      ),
                                    );
                                  },
                                ),
                              );
                            } else {
                              return ClipOval(
                                child: CachedNetworkImage(
                                  height: 150,
                                  width: 150,
                                  imageUrl: imageController.text,
                                  placeholder: (context, url) {
                                    return const Center(
                                      child: CircularProgressIndicator(),
                                    );
                                  },
                                  errorWidget: (context, url, error) {
                                    return const ClipOval(
                                      child: SizedBox(
                                        height: 150,
                                        width: 150,
                                        child: Image(
                                          image: NetworkImage(
                                              defaultProfilePicture),
                                        ),
                                      ),
                                    );
                                  },
                                ),
                              );
                            }
                          }
                        },
                      ),
                      Positioned(
                        bottom: 0,
                        right: 0,
                        child: Container(
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            border: Border.all(
                              width: 0.5,
                              color: Colors.white,
                            ),
                            color: Colors.grey.shade300,
                          ),
                          child: Material(
                            color: Colors.transparent,
                            child: InkWell(
                              onTap: () {
                                selectImage();
                              },
                              customBorder: const CircleBorder(),
                              child: const Padding(
                                padding: EdgeInsets.all(8.0),
                                child: Icon(
                                  Icons.camera_alt,
                                ),
                              ),
                            ),
                          ),
                        ),
                      )
                    ],
                  ),
                  const Gap(20),
                  Padding(
                    padding: const EdgeInsets.all(12),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const CustomSubtitleWidget(subtitle: "Username"),
                        CustomProfileTextFormField(
                          fieldName: "Username",
                          controller: usernameController,
                          prefixIcon: Icons.person,
                        ),
                        const CustomSubtitleWidget(subtitle: "Instansi"),
                        CustomProfileTextFormField(
                          fieldName: "Instansi",
                          controller: agencyController,
                          prefixIcon: Icons.corporate_fare,
                        ),
                        const CustomSubtitleWidget(subtitle: "Nama Lengkap"),
                        CustomProfileTextFormField(
                          fieldName: "Nama Lengkap",
                          controller: fullNameController,
                          prefixIcon: Icons.contact_mail,
                          function: () {
                            popUpEditField(
                              "Nama Lengkap",
                              fullNameController,
                              Icons.contact_mail,
                            );
                          },
                        ),
                        const CustomSubtitleWidget(subtitle: "E-Mail"),
                        CustomProfileTextFormField(
                          fieldName: "E-Mail",
                          controller: emailController,
                          prefixIcon: Icons.email,
                          function: () {
                            popUpEditField(
                              "E-Mail",
                              emailController,
                              Icons.email,
                            );
                          },
                        ),
                        const CustomSubtitleWidget(subtitle: "Nomor Telepon"),
                        CustomProfileTextFormField(
                          fieldName: "Nomor Telepon",
                          controller: phoneController,
                          prefixIcon: Icons.phone_android,
                          function: () {
                            popUpEditField(
                              "Nomor Telepon",
                              phoneController,
                              Icons.phone_android,
                            );
                          },
                        ),
                        const CustomSubtitleWidget(subtitle: "Password"),
                        CustomProfileTextFormField(
                          fieldName: "Password",
                          controller: passwordController,
                          prefixIcon: Icons.lock,
                          function: () {
                            popUpEditField(
                              "Password",
                              passwordController,
                              Icons.lock,
                            );
                          },
                        ),
                        const Gap(30),
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(24),
                    child: Container(
                      height: 50,
                      width: double.infinity,
                      decoration: BoxDecoration(
                        border: Border.all(
                          width: 1,
                          color: Colors.blueAccent,
                        ),
                        borderRadius: BorderRadius.circular(15),
                      ),
                      child: Material(
                        color: Colors.transparent,
                        child: InkWell(
                          onTap: () {
                            PopUp().whenDoSomething(
                              context,
                              "Yakin ingin keluar?",
                              Icons.logout,
                              logout(),
                            );
                          },
                          borderRadius: BorderRadius.circular(15),
                          splashColor: Colors.blue,
                          child: Center(
                              child: Text(
                            "Keluar",
                            style: GoogleFonts.openSans(
                              color: Colors.blueAccent,
                              fontWeight: FontWeight.bold,
                              fontSize: 18,
                            ),
                          )),
                        ),
                      ),
                    ),
                  ),
                  const Gap(40),
                ],
              );
            } else {
              return const SizedBox();
            }
          },
        ),
      ),
    );
  }

  RefreshIndicator adminContent() {
    return RefreshIndicator(
      onRefresh: () async {
        getAllUserByAgency();
      },
      child: SingleChildScrollView(
        physics: const AlwaysScrollableScrollPhysics(),
        child: BlocBuilder<RegisterBloc, RegisterState>(
          builder: (context, state) {
            if (state is GetAllUserSuccess) {
              final user = state.listUser;
              if (user.isNotEmpty) {
                return Column(
                  children: [
                    const Gap(10),
                    Text(
                      "Daftar User",
                      style: GoogleFonts.openSans(
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    ListView.builder(
                      padding: const EdgeInsets.only(
                        bottom: 80,
                        top: 10,
                      ),
                      itemCount: user.length,
                      physics: const NeverScrollableScrollPhysics(),
                      shrinkWrap: true,
                      itemBuilder: (context, index) {
                        return Padding(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 8,
                            vertical: 4,
                          ),
                          child: UserCardView(
                            user: user[index],
                            editFunction: () {
                              context.pushNamed(
                                Routes().editUser,
                                extra: user[index],
                              );
                            },
                            deleteFunction: () {
                              PopUp().whenDoSomething(
                                context,
                                "Yakin ingin menghapus ${user[index].fullName!}",
                                Icons.delete_forever,
                                deleteUserPopUp(user[index].id!),
                              );
                            },
                            detailFunction: () {},
                          ),
                        );
                      },
                    ),
                  ],
                );
              } else {
                return Column(
                  children: [
                    const Gap(30),
                    Center(
                      child: Text(
                        "Data user kosong",
                        style: GoogleFonts.openSans(fontSize: 16),
                        textAlign: TextAlign.center,
                      ),
                    ),
                  ],
                );
              }
            } else {
              return const SizedBox();
            }
          },
        ),
      ),
    );
  }
}

/// TODO zoom in profile picture
