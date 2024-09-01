import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:reservation_app/src/data/bloc/reservation_building/reservation_building_bloc.dart';
import 'package:reservation_app/src/presentation/utils/general/parsing.dart';
import 'package:reservation_app/src/presentation/utils/routes/route_name.dart';
import 'package:reservation_app/src/presentation/pages/reservation/reservation_available_card_view.dart';

import '../../../data/bloc/reservation/reservation_bloc.dart';
import '../../../data/model/reservation_model.dart';
import '../../widgets/general/header_pages.dart';

class ReservationPage extends StatefulWidget {
  const ReservationPage({super.key});

  @override
  State<ReservationPage> createState() => _ReservationPageState();
}

class _ReservationPageState extends State<ReservationPage> {
  late TextEditingController dateStartController;
  late TextEditingController dateEndController;
  late DateTimeRange selectedTimeRange;
  final parsingDate = ParsingDate();
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
  _getBuildingAvail(String dateStart) {
    _reservationBuildingBloc = context.read<ReservationBuildingBloc>();
    _reservationBuildingBloc.add(GetBuildingAvail(dateStart));
  }

  /// pengecekan gedung yang tersedia
  _getReservationAvail(String dateStart, String dateEnd) {
    _reservationBloc = context.read<ReservationBloc>();
    _reservationBloc.add(GetReservationCheck(dateStart, dateEnd));
  }

  /// building initial
  _buildingAvailInitial() {
    _reservationBuildingBloc = context.read<ReservationBuildingBloc>();
    _reservationBuildingBloc.add(InitialBuildingAvail());
  }

  /// snackbar ketika gedung tidak tersedia
  _showToast(BuildContext context) {
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
    _buildingAvailInitial();
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
        }
      },
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        body: Center(
          child: Column(
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
                    _buildingAvailInitial();
                  },
                  child: SingleChildScrollView(
                    physics: const AlwaysScrollableScrollPhysics(),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                          vertical: 32, horizontal: 16),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Container(
                            width: double.infinity,
                            height: 200,
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(15),
                                border: Border.all(
                                  width: 1,
                                  color: Colors.black,
                                )),
                            child: Padding(
                              padding: const EdgeInsets.all(12),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    "Pilih tanggal reservasi",
                                    style: GoogleFonts.openSans(
                                      fontSize: 14,
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                                  const Gap(10),
                                  Builder(
                                    builder: (context) {
                                      if (dateStartController.text.isNotEmpty &&
                                          dateEndController.text.isNotEmpty) {
                                        return Column(
                                          children: [
                                            Row(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.center,
                                              children: [
                                                Material(
                                                  color: Colors.transparent,
                                                  child: Padding(
                                                    padding:
                                                        const EdgeInsets.all(
                                                            8.0),
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
                                                          "${parsingDate.convertDate(
                                                            dateStartController
                                                                .text,
                                                          )} - ${parsingDate.convertDate(
                                                            dateEndController
                                                                .text,
                                                          )}",
                                                          style: GoogleFonts
                                                              .openSans(
                                                            fontSize: 12,
                                                            fontWeight:
                                                                FontWeight.w500,
                                                          ),
                                                          maxLines: 1,
                                                          overflow: TextOverflow
                                                              .ellipsis,
                                                        ),
                                                      ),
                                                      Material(
                                                        color:
                                                            Colors.transparent,
                                                        child: Padding(
                                                          padding:
                                                              const EdgeInsets
                                                                  .all(8.0),
                                                          child: InkWell(
                                                            onTap: () {
                                                              setState(() {
                                                                dateStartController
                                                                    .clear();
                                                                dateEndController
                                                                    .clear();
                                                                _buildingAvailInitial();
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
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.center,
                                              children: [
                                                Material(
                                                  color: Colors.transparent,
                                                  child: Padding(
                                                    padding:
                                                        const EdgeInsets.all(
                                                            8.0),
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
                                                        style: GoogleFonts
                                                            .openSans(
                                                          fontSize: 12,
                                                          fontWeight:
                                                              FontWeight.w500,
                                                        ),
                                                      )),
                                                    ],
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ],
                                        );
                                      } else {
                                        return Row(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.center,
                                          children: [
                                            Material(
                                              color: Colors.transparent,
                                              child: Padding(
                                                padding:
                                                    const EdgeInsets.all(8.0),
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
                                    },
                                  ),
                                  const Divider(
                                    height: 1,
                                    color: Colors.black,
                                    thickness: 1,
                                  ),
                                  const Spacer(),
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
                                          onTap: (dateStartController
                                                  .text.isEmpty)
                                              ? null
                                              : () {
                                                  _getBuildingAvail(
                                                    dateStartController.text
                                                        .toString(),
                                                  );
                                                  _getReservationAvail(
                                                      dateStartController.text,
                                                      dateEndController.text);
                                                },
                                          borderRadius:
                                              BorderRadius.circular(8),
                                          child: const Padding(
                                            padding: EdgeInsets.symmetric(
                                                horizontal: 16, vertical: 8),
                                            child: Text(
                                              "Cari Gedung",
                                              style: TextStyle(
                                                  fontWeight: FontWeight.w500,
                                                  color: Colors.white),
                                            ),
                                          ),
                                        ),
                                      ),
                                    ),
                                  )
                                ],
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
                                            top: 10, bottom: 30),
                                        itemCount: building.length,
                                        shrinkWrap: true,
                                        physics:
                                            const NeverScrollableScrollPhysics(),
                                        itemBuilder: (context, index) {
                                          return Padding(
                                            padding: const EdgeInsets.symmetric(
                                                vertical: 8),
                                            child:
                                                ReservationBuildingAvailableCardView(
                                              imagePath: building[index].image!,
                                              buildingName:
                                                  building[index].name!,
                                              capacity: building[index]
                                                  .capacity!
                                                  .toString(),
                                              status: building[index].status!,
                                              function: () {
                                                if (booked.isNotEmpty) {
                                                  booked.any((element) =>
                                                          element
                                                              .buildingName! ==
                                                          building[index].name)
                                                      ? _showToast(context)
                                                      : context.pushNamed(
                                                          Routes()
                                                              .confirmReservation,
                                                          extra:
                                                              building[index],
                                                          queryParameters: {
                                                            "dateStart":
                                                                dateStartController
                                                                    .text
                                                                    .toString(),
                                                            "dateEnd":
                                                                dateEndController
                                                                    .text
                                                                    .toString(),
                                                          },
                                                        );
                                                } else {
                                                  context.pushNamed(
                                                    Routes().confirmReservation,
                                                    extra: building[index],
                                                    queryParameters: {
                                                      "dateStart":
                                                          dateStartController
                                                              .text
                                                              .toString(),
                                                      "dateEnd":
                                                          dateEndController.text
                                                              .toString(),
                                                    },
                                                  );
                                                }
                                              },
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
                              } else if (state is ResBuLoading) {
                                return const Center(
                                  child: Column(
                                    children: [
                                      Gap(30),
                                      CircularProgressIndicator()
                                    ],
                                  ),
                                );
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
        ),
      ),
    );
  }
}
