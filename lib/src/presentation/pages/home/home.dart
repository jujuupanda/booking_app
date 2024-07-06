
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';
import 'package:intl/intl.dart';

import '../../../data/bloc/reservation/reservation_bloc.dart';
import '../../widgets/general/header_pages.dart';
import '../../widgets/general/reservation_card_view.dart';
import '../../widgets/general/room_card_view.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  late DateTime dateTime;
  late String formattedDate;
  late ReservationBloc _reservationBloc;

  getReservation() {
    _reservationBloc = context.read<ReservationBloc>();
    _reservationBloc.add(const GetReservation("user1"));
  }

  getDateTime() {
    dateTime = DateTime.now();
    String formatted = DateFormat('EEEE, d MMMM yyyy').format(dateTime);
    formattedDate = formatted;
  }

  @override
  void didChangeDependencies() {
    getDateTime();
    getReservation();
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          InkWell(
              onTap: () {
                getReservation();
              },
              child: const HeaderPage()),
          Expanded(
            child: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Gap(10),
                    Center(
                      child: Text(
                        formattedDate,
                        style: const TextStyle(fontSize: 24),
                      ),
                    ),
                    const Gap(20),
                    const Text(
                      "Reservasi Berlangsung:",
                      style: TextStyle(fontSize: 16),
                    ),
                    const Gap(15),
                    BlocBuilder<ReservationBloc, ReservationState>(
                      builder: (context, state) {
                        if (state is ReservationSuccess) {
                          final reservations = state.reservations;
                          if (reservations.isNotEmpty) {
                            return Container(
                              constraints: const BoxConstraints(
                                maxHeight: 150,
                                minHeight: 50,
                              ),
                              child: ListView.builder(
                                padding: EdgeInsets.zero,
                                itemCount: reservations.length,
                                itemBuilder: (context, index) {
                                  return ReservationCardView(
                                      buildingName:
                                          reservations[index].buildingName!,
                                      numberOfGuest: reservations[index]
                                          .numberOfGuest!
                                          .toString(),
                                      dateStart: reservations[index].dateStart!,
                                      dateEnd: reservations[index].dateEnd!);
                                },
                              ),
                            );
                          } else {
                            return const Center(
                              child: Text(
                                "Kamu tidak dalam reservasi. Reservasi Sekarang?",
                                maxLines: 2,
                                textAlign: TextAlign.center,
                                style: TextStyle(fontSize: 18),
                              ),
                            );
                          }
                        } else {
                          return const Text(
                            "Mohon tunggu atau refresh halaman",
                            maxLines: 2,
                            textAlign: TextAlign.center,
                            style: TextStyle(fontSize: 18),
                          );
                        }
                      },
                    ),
                    const Gap(20),
                    const Text(
                      "Menunggu Persetujuan:",
                      style: TextStyle(fontSize: 16),
                    ),
                    const Gap(15),
                    SizedBox(
                      height: 250,
                      child: ListView.builder(
                        padding: EdgeInsets.zero,
                        itemCount: 1,
                        itemBuilder: (context, index) {
                          return const RoomCardView();
                        },
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

/// berisi gedung yang belum direservasi gedung yang telah direservasi
/// (start,end,who, sort date, info)
