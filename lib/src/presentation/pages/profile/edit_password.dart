import 'package:flutter/material.dart';
import 'package:gap/gap.dart';

import '../../../data/bloc/user/user_bloc.dart';
import '../../../data/model/user_model.dart';
import '../../widgets/general/button_positive.dart';
import '../../widgets/general/header_detail_page.dart';
import '../../widgets/general/widget_custom_subtitle.dart';
import '../../widgets/general/widget_custom_text_form_field.dart';

class EditPasswordPage extends StatefulWidget {
  const EditPasswordPage({
    super.key,
    required this.userModel,
  });

  final UserModel userModel;

  @override
  State<EditPasswordPage> createState() => _EditPasswordPageState();
}

class _EditPasswordPageState extends State<EditPasswordPage> {
  late TextEditingController oldPasswordController;
  late TextEditingController new1PasswordController;
  late TextEditingController new2PasswordController;
  late UserBloc userBloc;

  @override
  void initState() {
    oldPasswordController = TextEditingController();
    new1PasswordController = TextEditingController();
    new2PasswordController = TextEditingController();
    super.initState();
  }

  @override
  void dispose() {
    oldPasswordController.dispose();
    new1PasswordController.dispose();
    new2PasswordController.dispose();
    super.dispose();
  }

  editPassword(){
    return(){};
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Column(
            children: [
              const HeaderDetailPage(pageName: "Edit Password"),
              RefreshIndicator(
                onRefresh: () async {},
                child: SingleChildScrollView(
                  physics: const AlwaysScrollableScrollPhysics(),
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Gap(20),
                        const CustomSubtitleWidget(subtitle: "Password Lama"),
                        CustomTextFormField(
                          fieldName: "Password Lama",
                          controller: oldPasswordController,
                          prefixIcon: Icons.lock,
                        ),
                        const CustomSubtitleWidget(subtitle: "Password Baru"),
                        CustomTextFormField(
                          fieldName: "Password Baru",
                          controller: new1PasswordController,
                          prefixIcon: Icons.lock,
                        ),
                        const CustomSubtitleWidget(
                            subtitle: "Konfirmasi Password Baru"),
                        CustomTextFormField(
                          fieldName: "Konfirmasi Password Baru",
                          controller: new2PasswordController,
                          prefixIcon: Icons.lock,
                        ),
                        const Gap(30),
                        Align(
                          alignment: Alignment.bottomRight,
                          child: ButtonPositive(
                            name: "Simpan",
                            function: () {},
                          ),
                        )
                      ],
                    ),
                  ),
                ),
              )
            ],
          )
        ],
      ),
    );
  }
}
