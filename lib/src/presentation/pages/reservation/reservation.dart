import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';
import 'package:go_router/go_router.dart';
import 'package:reservation_app/src/data/bloc/reservation_building/reservation_building_bloc.dart';
import 'package:reservation_app/src/presentation/utils/general/parsing.dart';
import 'package:reservation_app/src/presentation/utils/routes/route_name.dart';
import 'package:reservation_app/src/presentation/widgets/general/building_avail_card_view.dart';

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

  pickRangeDate(BuildContext context) async {
    final DateTimeRange? dateTimeRange = await showDateRangePicker(
      context: context,
      firstDate: DateTime.now(),
      lastDate: DateTime(2026),
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



  _getBuildingAvail(String dateStart) {
    _reservationBuildingBloc = context.read<ReservationBuildingBloc>();
    _reservationBuildingBloc.add(GetBuildingAvail(dateStart));
  }

  _buildingAvailInitial() {
    _reservationBuildingBloc = context.read<ReservationBuildingBloc>();
    _reservationBuildingBloc.add(InitialBuildingAvail());
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
  Widget build(BuildContext context) {
    return Scaffold(
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
                                const Text(
                                  "Pilih tanggal reservasi",
                                  style: TextStyle(
                                    fontSize: 14,
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                                const Gap(20),
                                Row(
                                  crossAxisAlignment:
                                      CrossAxisAlignment.center,
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
                                      child: (dateStartController
                                                  .text.isNotEmpty &&
                                              dateEndController
                                                  .text.isNotEmpty)
                                          ? Text(
                                              "${parsingDate.convertDate(
                                                dateStartController.text,
                                              )} - ${parsingDate.convertDate(
                                                dateEndController.text,
                                              )}",
                                              maxLines: 1,
                                              overflow: TextOverflow.ellipsis,
                                            )
                                          : const Text(
                                              "Pilih tanggal reservasi"),
                                    ),
                                    (dateStartController.text.isNotEmpty &&
                                            dateEndController.text.isNotEmpty)
                                        ? Material(
                                            color: Colors.transparent,
                                            child: Padding(
                                              padding:
                                                  const EdgeInsets.all(8.0),
                                              child: InkWell(
                                                onTap: () {
                                                  setState(() {
                                                    dateStartController
                                                        .clear();
                                                    dateEndController.clear();
                                                    _buildingAvailInitial();
                                                  });
                                                },
                                                child: const Icon(
                                                  Icons.close,
                                                  size: 30,
                                                ),
                                              ),
                                            ),
                                          )
                                        : const SizedBox(),
                                  ],
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
                                        onTap:
                                            (dateStartController.text.isEmpty)
                                                ? null
                                                : () {
                                                    _getBuildingAvail(
                                                      dateStartController.text
                                                          .toString(),
                                                    );
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
                        const Text(
                          "Gedung yang tersedia",
                          style: TextStyle(
                              fontSize: 14, fontWeight: FontWeight.w500),
                        ),
                        BlocBuilder<ReservationBuildingBloc,
                            ReservationBuildingState>(
                          builder: (context, state) {
                            if (state is ResBuGetSuccess) {
                              final building = state.buildings;
                              if (building.isNotEmpty) {
                                return ListView.builder(
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
                                      child: BuildingAvailCardView(
                                        imagePath: building[index].image!,
                                        buildingName: building[index].name!,
                                        capacity: building[index]
                                            .capacity!
                                            .toString(),
                                        status: (building[index].status !=
                                                "Tersedia")
                                            ? "Digunakan sampai dengan ${parsingDate.convertDate(building[index].usedUntil!)}"
                                            : building[index].status!,
                                        function: () {
                                          context.pushNamed(
                                            Routes().confirmReservation,
                                            extra: building[index],
                                            queryParameters: {
                                              "dateStart": dateStartController
                                                  .text
                                                  .toString(),
                                              "dateEnd": dateEndController
                                                  .text
                                                  .toString(),
                                            },
                                          );
                                        },
                                      ),
                                    );
                                  },
                                );
                              } else {
                                return const Center(
                                  child: Text(
                                      "Tidak ada gedung/ruang yang tersedia"),
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
    );
  }
}
