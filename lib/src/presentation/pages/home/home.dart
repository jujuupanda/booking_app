import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';
import 'package:intl/intl.dart';
import 'package:reservation_app/src/presentation/widgets/general/exschool_card_view.dart';

import '../../../data/bloc/exschool/exschool_bloc.dart';
import '../../../data/bloc/reservation/reservation_bloc.dart';
import '../../widgets/general/header_pages.dart';
import '../../widgets/general/reservation_card_view.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  late DateTime dateTime;
  late String formattedDate;
  late ReservationBloc _reservationBloc;
  late ExschoolBloc _exschoolBloc;

  getReservation() {
    _reservationBloc = context.read<ReservationBloc>();
    _reservationBloc.add(GetReservation());
  }

  getExschool() {
    _exschoolBloc = context.read<ExschoolBloc>();
    _exschoolBloc.add(GetExschool());
  }

  getDateTime() {
    dateTime = DateTime.now();
    String formatted = DateFormat('EEEE, d MMMM yyyy').format(dateTime);
    formattedDate = formatted;
  }

  @override
  void didChangeDependencies() {
    getReservation();
    getDateTime();
    getExschool();
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          const HeaderPage(
            name: "Beranda",
          ),
          Expanded(
            child: RefreshIndicator(
              onRefresh: () async {
                getReservation();
                getExschool();
              },
              child: SingleChildScrollView(
                physics: const AlwaysScrollableScrollPhysics(),
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Gap(10),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Container(
                            decoration: BoxDecoration(
                              border: Border.all(
                                width: 1,
                                color: Colors.black,
                              ),
                              borderRadius: BorderRadius.circular(10),
                            ),
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Text(
                                formattedDate,
                                style: const TextStyle(fontSize: 12),
                              ),
                            ),
                          ),
                          const Text(
                            "Selamat Datang, User1",
                            style: TextStyle(
                              fontSize: 12,
                              fontStyle: FontStyle.italic,
                            ),
                          ),
                        ],
                      ),
                      const Gap(20),
                      Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(15),
                          color: Colors.blueAccent,
                        ),
                        width: double.infinity,
                        child: Padding(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 12,
                            vertical: 10,
                          ),
                          child: Column(
                            children: [
                              const Align(
                                alignment: Alignment.centerLeft,
                                child: Text(
                                  "Reservasi Anda",
                                  style: TextStyle(
                                    fontSize: 18,
                                    color: Colors.white,
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                              ),
                              BlocBuilder<ReservationBloc, ReservationState>(
                                builder: (context, state) {
                                  if (state is ReservationGetSuccess) {
                                    final reservations = state.reservations;
                                    if (reservations.isNotEmpty) {
                                      return ListView.builder(
                                        padding: EdgeInsets.zero,
                                        itemCount: reservations.length,
                                        shrinkWrap: true,
                                        physics:
                                            const NeverScrollableScrollPhysics(),
                                        itemBuilder: (context, index) {
                                          return ReservationCardView(
                                              buildingName: reservations[index]
                                                  .buildingName!,
                                              dateStart: reservations[index]
                                                  .dateStart!,
                                              dateEnd:
                                                  reservations[index].dateEnd!,
                                              information: reservations[index]
                                                  .information!,
                                              status:
                                                  reservations[index].status!);
                                        },
                                      );
                                    } else {
                                      return const Column(
                                        children: [
                                          Gap(30),
                                          Padding(
                                            padding: EdgeInsets.all(12),
                                            child: Center(
                                              child: Text(
                                                "Kamu tidak dalam reservasi. Reservasi Sekarang?",
                                                maxLines: 3,
                                                textAlign: TextAlign.center,
                                                style: TextStyle(
                                                  fontSize: 18,
                                                  fontWeight: FontWeight.w500,
                                                  color: Colors.white,
                                                ),
                                              ),
                                            ),
                                          )
                                        ],
                                      );
                                    }
                                  } else {
                                    return const Column(
                                      children: [
                                        Gap(30),
                                        Padding(
                                          padding: EdgeInsets.all(12),
                                          child: Center(
                                            child: CircularProgressIndicator(),
                                          ),
                                        )
                                      ],
                                    );
                                  }
                                },
                              ),
                            ],
                          ),
                        ),
                      ),
                      const Gap(15),
                      const Text(
                        "Informasi Jadwal Ekstrakurikuler SMANTAB",
                        style: TextStyle(
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      BlocBuilder<ExschoolBloc, ExschoolState>(
                        builder: (context, state) {
                          if (state is ExschoolGetSuccess) {
                            final exschool = state.exschools;
                            if (exschool.isNotEmpty) {
                              return ListView.builder(
                                itemCount: exschool.length,
                                shrinkWrap: true,
                                physics: const NeverScrollableScrollPhysics(),
                                padding: EdgeInsets.zero,
                                itemBuilder: (context, index) {
                                  return ExschoolCardView(
                                    image: exschool[index].image!,
                                    name: exschool[index].name!,
                                    schedule: exschool[index].schedule!,
                                  );
                                },
                              );
                            } else {
                              return const Column(
                                children: [
                                  Gap(30),
                                  Padding(
                                    padding: EdgeInsets.all(12),
                                    child: Center(
                                      child: Text("Tidak ada data ekskul"),
                                    ),
                                  )
                                ],
                              );
                            }
                          } else {
                            return const Column(
                              children: [
                                Gap(30),
                                Padding(
                                  padding: EdgeInsets.all(12),
                                  child: Center(
                                    child: CircularProgressIndicator(),
                                  ),
                                )
                              ],
                            );
                          }
                        },
                      )
                    ],
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
