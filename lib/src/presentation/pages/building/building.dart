import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:reservation_app/src/presentation/pages/extracurricular/extracurricular_card_view.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../data/bloc/building/building_bloc.dart';
import '../../../data/bloc/extracurricular/extracurricular_bloc.dart';
import '../../utils/routes/route_name.dart';
import '../../widgets/general/header_pages.dart';
import 'building_card_view.dart';
import 'fab_building.dart';

class BuildingPage extends StatefulWidget {
  const BuildingPage({super.key});

  @override
  State<BuildingPage> createState() => _BuildingPageState();
}

class _BuildingPageState extends State<BuildingPage>
    with TickerProviderStateMixin {
  late BuildingBloc _buildingBloc;
  late ExtracurricularBloc _exschoolBloc;
  late String roleUser;
  late TabController tabController;
  int selectedIndex = 0;

  /// mendapatkan informasi gedung
  _getBuilding() {
    _buildingBloc = context.read<BuildingBloc>();
    _buildingBloc.add(GetBuildingByAgency());
  }

  /// mendapatkan ekstrakurikuler
  _getExtracurricular() {
    _exschoolBloc = context.read<ExtracurricularBloc>();
    _exschoolBloc.add(GetExtracurricular());
  }

  /// mendapatkan role pengguna
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
    _getExtracurricular();
    tabController = TabController(
      length: 2,
      vsync: this,
    );
    super.didChangeDependencies();
  }

  @override
  void dispose() {
    tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        floatingActionButton: Builder(
          builder: (context) {
            if (roleUser == "1") {
              return selectedIndex == 0
                  ? FABBuilding(
                      function: () {
                        context.pushNamed(
                          Routes().createBuilding,
                        );
                      },
                    )
                  : FABBuilding(
                      function: () {
                        context.pushNamed(
                          Routes().createSchedule,
                        );
                      },
                    );
            } else {
              return const SizedBox();
            }
          },
        ),
        body: Column(
          children: [
            const HeaderPage(
              name: "Gedung & Ekstrakurikuler",
            ),
            const Gap(10),
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
                      child: Text("Gedung"),
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
                      child: Text("Ekskul"),
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
                  buildingContent(),

                  /// second tab bar view
                  extracurricularContent(),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  RefreshIndicator extracurricularContent() {
    return RefreshIndicator(
      onRefresh: () async {
        _getExtracurricular();
      },
      child: SingleChildScrollView(
        physics: const AlwaysScrollableScrollPhysics(),
        child: BlocBuilder<ExtracurricularBloc, ExtracurricularState>(
          builder: (context, state) {
            if (state is ExtracurricularGetSuccess) {
              final excur = state.extracurriculars;
              if (excur.isNotEmpty) {
                return Column(
                  children: [
                    const Gap(10),
                    Text(
                      "Daftar Ekstrakurikuler",
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
                      itemCount: excur.length,
                      physics: const NeverScrollableScrollPhysics(),
                      shrinkWrap: true,
                      itemBuilder: (context, index) {
                        return Padding(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 8,
                            vertical: 4,
                          ),
                          child: ExtracurricularCardView(
                            name: excur[index].name!,
                            schedule: excur[index].schedule!,
                            image: excur[index].image!,
                            function: () {},
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
                        "Tidak ada ekstrakurikuler",
                        style: GoogleFonts.openSans(fontSize: 16),
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
    );
  }

  RefreshIndicator buildingContent() {
    return RefreshIndicator(
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
                return Column(
                  children: [
                    const Gap(10),
                    Text(
                      "Daftar Gedung",
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
                      itemCount: buildings.length,
                      physics: const NeverScrollableScrollPhysics(),
                      shrinkWrap: true,
                      itemBuilder: (context, index) {
                        return Padding(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 8,
                            vertical: 4,
                          ),
                          child: BuildingCardView(
                            imagePath: "imagePath",
                            buildingName: buildings[index].name!,
                            capacity: buildings[index].capacity!.toString(),
                            status: buildings[index].status!,
                            function: () {
                              roleUser == "1"
                                  ? context.pushNamed(
                                      Routes().detailBuildingAdmin,
                                      extra: buildings[index],
                                    )
                                  : context.pushNamed(
                                      Routes().detailBuilding,
                                      extra: buildings[index],
                                    );
                            },
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
                        "Tidak ada gedung",
                        style: GoogleFonts.openSans(fontSize: 16),
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
    );
  }
}
