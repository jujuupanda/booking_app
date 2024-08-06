import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';
import 'package:go_router/go_router.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../data/bloc/building/building_bloc.dart';
import '../../utils/routes/route_name.dart';
import '../../widgets/general/header_pages.dart';
import '../../widgets/general/building_card_view.dart';

class BuildingPage extends StatefulWidget {
  const BuildingPage({super.key});

  @override
  State<BuildingPage> createState() => _BuildingPageState();
}

class _BuildingPageState extends State<BuildingPage> {
  late BuildingBloc _buildingBloc;
  late String roleUser;

  _getBuilding() {
    _buildingBloc = context.read<BuildingBloc>();
    _buildingBloc.add(GetBuilding());
  }

  _getRole() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    roleUser = prefs.getString("role")!;
    setState(() {
      roleUser = roleUser;
    });
  }


  @override
  void didChangeDependencies() {
    roleUser = "";
    _getRole();
    _getBuilding();
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: roleUser == "1"
          ? Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(15),
              ),
              child: Material(
                color: Colors.transparent,
                child: InkWell(
                  borderRadius: BorderRadius.circular(15),
                  onTap: () {
                    context.pushNamed(Routes().createBuilding);
                  },
                  child: const Padding(
                    padding: EdgeInsets.all(8.0),
                    child: Icon(
                      Icons.add_circle_outline,
                      size: 36,
                      color: Colors.blueAccent,
                    ),
                  ),
                ),
              ),
            )
          : const SizedBox(),
      body: Column(
        children: [
          const HeaderPage(
            name: "Gedung",
          ),
          Expanded(
            child: RefreshIndicator(
              onRefresh: () async {
                _getBuilding();
              },
              child: SingleChildScrollView(
                physics: const AlwaysScrollableScrollPhysics(),
                child: BlocBuilder<BuildingBloc, BuildingState>(
                  builder: (context, state) {
                    if (state is BuildingGetSuccess) {
                      final buildings = state.buildings;
                      if (buildings.isNotEmpty) {
                        return ListView.builder(
                          padding: const EdgeInsets.only(bottom: 80),
                          itemCount: buildings.length,
                          physics: const NeverScrollableScrollPhysics(),
                          shrinkWrap: true,
                          itemBuilder: (context, index) {
                            return Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: BuildingCardView(
                                imagePath: "imagePath",
                                buildingName: buildings[index].name!,
                                capacity: buildings[index].capacity!.toString(),
                                status: buildings[index].status!,
                                function: () {
                                  roleUser == "1" ?
                                  context.pushNamed(
                                    Routes().detailBuildingAdmin,
                                    extra: buildings[index],
                                  ) : context.pushNamed(
                                    Routes().detailBuilding,
                                    extra: buildings[index],
                                  );
                                },
                              ),
                            );
                          },
                        );
                      } else {
                        return const Column(
                          children: [
                            Gap(30),
                            Center(
                              child: Text(
                                "Tidak ada gedung :(",
                                style: TextStyle(fontSize: 18),
                                textAlign: TextAlign.center,
                              ),
                            ),
                          ],
                        );
                      }
                    } else {
                      return const SizedBox(
                        height: 500,
                        child: Center(
                          child: CircularProgressIndicator(),
                        ),
                      );
                    }
                  },
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

/// tambahkan detial info gedung ketika diklik
