import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../data/bloc/reservation/reservation_bloc.dart';
import '../../../data/bloc/reservation_building/reservation_building_bloc.dart';
import '../../../data/model/building_model.dart';
import '../../../data/model/reservation_model.dart';
import '../../utils/general/parsing.dart';
import '../../utils/routes/route_name.dart';
import '../../widgets/general/button_positive.dart';
import '../../widgets/general/header_pages.dart';
import '../../widgets/general/widget_custom_loading.dart';
import 'building_available_card_view.dart';

class ReservationPage extends StatefulWidget {
  const ReservationPage({super.key});

  @override
  State<ReservationPage> createState() => _ReservationPageState();
}

class _ReservationPageState extends State<ReservationPage> {
  late TextEditingController dateStartController;
  late TextEditingController dateEndController;
  late DateTimeRange selectedTimeRange;
  late ReservationBuildingBloc _reservationBuildingBloc;
  late ReservationBloc _reservationBloc;
  late List<ReservationModel> booked;
  double containerHeight = 100;

  /// fungsi untuk mengambil rentang tanggal

  pickRangeDate(BuildContext context) async {
    final DateTimeRange? dateTimeRange = await showDateRangePicker(
      context: context,
      firstDate: DateTime.now(),
      lastDate: DateTime(DateTime.now().year + 2),
      helpText: "Pilih tanggal",
      saveText: "Simpan",
    );
    if (dateTimeRange != null) {
      setState(() {
        selectedTimeRange = dateTimeRange;
        dateStartController =
            TextEditingController(text: selectedTimeRange.start.toString());
        dateEndController =
            TextEditingController(text: selectedTimeRange.end.toString());
      });
    }
  }

  /// mendapatkan gedung yang tersedia
  getBuildingAvail() {
    _reservationBuildingBloc = context.read<ReservationBuildingBloc>();
    _reservationBuildingBloc.add(GetBuildingAvail());
  }

  /// pengecekan gedung yang tersedia
  getReservationAvail(String dateStart, String dateEnd) {
    _reservationBloc = context.read<ReservationBloc>();
    _reservationBloc.add(GetReservationCheck(dateStart, dateEnd));
  }

  /// building initial
  buildingAvailInitial() {
    _reservationBuildingBloc = context.read<ReservationBuildingBloc>();
    _reservationBuildingBloc.add(InitialBuildingAvail());
  }

  /// snackbar ketika gedung tidak tersedia
  showToast(BuildContext context) {
    final scaffold = ScaffoldMessenger.of(context);
    scaffold.showSnackBar(
      SnackBar(
        duration: const Duration(seconds: 1, milliseconds: 250),
        content: Text(
          'Tidak tersedia pada tanggal ini',
          style: GoogleFonts.openSans(),
        ),
        action: SnackBarAction(
            label: 'Baik', onPressed: scaffold.hideCurrentSnackBar),
      ),
    );
  }

  @override
  void initState() {
    selectedTimeRange = DateTimeRange(
      start: DateTime.now(),
      end: DateTime.now(),
    );
    buildingAvailInitial();
    dateStartController = TextEditingController();
    dateEndController = TextEditingController();

    super.initState();
  }

  @override
  void dispose() {
    dateStartController.dispose();
    dateEndController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<ReservationBloc, ReservationState>(
      listener: (context, state) {
        if (state is ReservationBooked) {
          booked = state.booked;
          print(booked);
        }
      },
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        body: Stack(
          children: [
            Column(
              children: [
                const HeaderPage(
                  name: "Reservasi",
                ),
                Expanded(
                  child: RefreshIndicator(
                    onRefresh: () async {
                      if (dateStartController.text.isNotEmpty &&
                          dateEndController.text.isNotEmpty) {
                        setState(() {
                          dateStartController.clear();
                          dateEndController.clear();
                        });
                      }
                      buildingAvailInitial();
                    },
                    child: SingleChildScrollView(
                      physics: const AlwaysScrollableScrollPhysics(),
                      child: Padding(
                        padding: const EdgeInsets.symmetric(
                          vertical: 32,
                          horizontal: 16,
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Container(
                              width: double.infinity,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(15),
                                border: Border.all(
                                  width: 1,
                                  color: Colors.black,
                                ),
                              ),
                              child: Padding(
                                padding: const EdgeInsets.all(12),
                                child: IntrinsicHeight(
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        "Pilih tanggal reservasi",
                                        style: GoogleFonts.openSans(
                                          fontSize: 14,
                                          fontWeight: FontWeight.w600,
                                        ),
                                      ),
                                      const Gap(10),
                                      selectedDateRange(),
                                      const Divider(
                                        height: 1,
                                        color: Colors.black,
                                        thickness: 1,
                                      ),
                                      const Gap(30),
                                      Align(
                                        alignment: Alignment.bottomRight,
                                        child: ButtonPositive(
                                          name: "Cari Gedung",
                                          function: buttonSearch(),
                                        ),
                                      )
                                    ],
                                  ),
                                ),
                              ),
                            ),
                            const Gap(18),
                            BlocBuilder<ReservationBuildingBloc,
                                ReservationBuildingState>(
                              builder: (context, state) {
                                if (state is ResBuGetSuccess) {
                                  final building = state.buildings;
                                  if (building.isNotEmpty) {
                                    return Column(
                                      children: [
                                        Text(
                                          "Gedung yang tersedia",
                                          style: GoogleFonts.openSans(
                                            fontSize: 14,
                                            fontWeight: FontWeight.w600,
                                          ),
                                        ),
                                        ListView.builder(
                                          padding: const EdgeInsets.only(
                                            top: 10,
                                            bottom: 30,
                                          ),
                                          itemCount: building.length,
                                          shrinkWrap: true,
                                          physics:
                                              const NeverScrollableScrollPhysics(),
                                          itemBuilder: (context, index) {
                                            return Padding(
                                              padding:
                                                  const EdgeInsets.symmetric(
                                                      vertical: 8),
                                              child:
                                                  reservationAvailableContent(
                                                building,
                                                index,
                                                context,
                                              ),
                                            );
                                          },
                                        ),
                                      ],
                                    );
                                  } else {
                                    return Center(
                                      child: Padding(
                                        padding: const EdgeInsets.all(12),
                                        child: Text(
                                          "Tidak ada gedung/ruang yang tersedia",
                                          style: GoogleFonts.openSans(
                                            fontWeight: FontWeight.w500,
                                            fontSize: 14,
                                          ),
                                        ),
                                      ),
                                    );
                                  }
                                } else {
                                  return const SizedBox();
                                }
                              },
                            )
                          ],
                        ),
                      ),
                    ),
                  ),
                )
              ],
            ),
            Center(
              child: BlocBuilder<ReservationBuildingBloc, ReservationBuildingState>(
                builder: (context, state) {
                  if (state is ResBuLoading) {
                    return const CustomLoading();
                  } else {
                    return const SizedBox();
                  }
                },
              ),
            )
          ],
        ),
      ),
    );
  }

  buttonSearch() {
    if (dateStartController.text.isEmpty) {
      return () {};
    } else {
      return () {
        getBuildingAvail();
        getReservationAvail(
          dateStartController.text,
          dateEndController.text,
        );
      };
    }
  }

  reservationAvailableContent(
      List<BuildingModel> building, int index, BuildContext context) {
    return BuildingAvailableCardView(
      building: building[index],
      function: () {
        if (booked.isNotEmpty) {
          booked.any((element) => element.buildingName! == building[index].name)
              ? showToast(context)
              : context.pushNamed(
                  Routes().confirmReservation,
                  extra: building[index],
                  queryParameters: {
                    "dateStart": dateStartController.text.toString(),
                    "dateEnd": dateEndController.text.toString(),
                  },
                );
        } else {
          context.pushNamed(
            Routes().confirmReservation,
            extra: building[index],
            queryParameters: {
              "dateStart": dateStartController.text.toString(),
              "dateEnd": dateEndController.text.toString(),
            },
          );
        }
      },
    );
  }

  selectedDateRange() {
    if (dateStartController.text.isNotEmpty &&
        dateEndController.text.isNotEmpty) {
      return Column(
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Material(
                color: Colors.transparent,
                child: Padding(
                  padding: const EdgeInsets.all(
                    8,
                  ),
                  child: InkWell(
                    onTap: () {
                      pickRangeDate(context);
                    },
                    child: const Icon(
                      Icons.date_range,
                      size: 30,
                    ),
                  ),
                ),
              ),
              Expanded(
                child: Row(
                  children: [
                    Expanded(
                      child: Text(
                        "${ParsingDate().convertDate(
                          dateStartController.text,
                        )} - ${ParsingDate().convertDate(
                          dateEndController.text,
                        )}",
                        style: GoogleFonts.openSans(
                          fontSize: 12,
                          fontWeight: FontWeight.w500,
                        ),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                    Material(
                      color: Colors.transparent,
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: InkWell(
                          onTap: () {
                            setState(() {
                              dateStartController.clear();
                              dateEndController.clear();
                              buildingAvailInitial();
                            });
                          },
                          child: const Icon(
                            Icons.close,
                            size: 30,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Material(
                color: Colors.transparent,
                child: Padding(
                  padding: const EdgeInsets.all(
                    8,
                  ),
                  child: InkWell(
                    onTap: () {
                      pickRangeDate(context);
                    },
                    child: const Icon(
                      Icons.date_range,
                      size: 30,
                    ),
                  ),
                ),
              ),
              Expanded(
                child: Row(
                  children: [
                    Expanded(
                      child: Text(
                        "${(selectedTimeRange.duration.inDays.toInt() + 1)} Hari",
                        style: GoogleFonts.openSans(
                          fontSize: 12,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ],
      );
    } else {
      return Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Material(
            color: Colors.transparent,
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: InkWell(
                onTap: () {
                  pickRangeDate(context);
                },
                child: const Icon(
                  Icons.date_range,
                  size: 30,
                ),
              ),
            ),
          ),
          Expanded(
            child: Text(
              "Pilih tanggal reservasi",
              style: GoogleFonts.openSans(
                fontSize: 12,
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
        ],
      );
    }
  }
}
